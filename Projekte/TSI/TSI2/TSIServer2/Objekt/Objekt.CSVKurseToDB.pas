unit
Objekt.CSVKurseToDB;

interface

uses
  SysUtils, Classes, System.IOUtils, System.Types, System.UITypes,
  Objekt.CSVAktieList, Objekt.CSVAktie, DB.KursList, DB.Aktie,  DB.Kurs, Objekt.Dateiformat;

type
  TStartProgressEvent=procedure(aAnzahl: Integer) of object;
  TProgressEvent=procedure(aProgress: Integer; aCaption: string) of object;
  TProgressRefreshLabelEvent=procedure(aCaption: string) of object;
  TCSVKurseToDB = class
  private
    fCSVAktieList: TCSVAktieList;
    fOnStartProgress: TStartProgressEvent;
    fOnProgress: TProgressEvent;
    fDBKursList: TDBKursList;
    fDBAktie: TDBAktie;
    fDBKurs: TDBKurs;
    fOnProgressRefreshLabel: TProgressRefreshLabelEvent;
    fDateiFormat: TDateiFormat;
    procedure SaveKurse;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start(aDownloadPfad: string);
    property OnStartProgress: TStartProgressEvent read fOnStartProgress write fOnStartProgress;
    property OnProgress: TProgressEvent read fOnProgress write fOnProgress;
    property OnProgressRefreshLabel: TProgressRefreshLabelEvent read fOnProgressRefreshLabel write fOnProgressRefreshLabel;
    function DateiFormat: TDateiformat;
  end;

implementation

{ TCSVKurseToDB }

uses
  Objekt.TSIServer2;

constructor TCSVKurseToDB.Create;
begin
  fCSVAktieList := TCSVAktieList.Create;
  fDBKursList := TDBKursList.Create;
  fDBAktie := TDBAktie.Create(nil);
  fDBKurs := TDBKurs.Create(nil);
  fDateiFormat := TDateiFormat.Create;
end;

function TCSVKurseToDB.DateiFormat: TDateiformat;
begin
  Result := fDateiFormat;
end;

destructor TCSVKurseToDB.Destroy;
begin
  FreeAndNil(fCSVAktieList);
  FreeAndNil(fDBKursList);
  FreeAndNil(fDBAktie);
  FreeAndNil(fDBKurs);
  FreeAndNil(fDateiFormat);
   inherited;
 end;

 procedure TCSVKurseToDB.Start(aDownloadPfad: string);
 var
   CSVListe: TStringDynArray;  i1:
   Integer;
 begin
   fDBKursList.Trans := TSIServer2.IBT_TSI;
   fDBAktie.Trans := TSIServer2.IBT_TSI;
   fDBKurs.Trans := TSIServer2.IBT_TSI;
   CSVListe := TDirectory.GetFiles(aDownloadPfad, '*.csv');
   if Assigned(fOnStartProgress) then
     fOnStartProgress(High(CSVListe));
   fCSVAktieList.setDateiFormat(fDateiFormat);
   for i1 := low(CSVListe) to High(CSVListe) do
   begin
     if not FileExists(csvListe[i1]) then
     begin
       TSIServer2.Protokoll.write('CSVKurseToDB', 'Datei nicht gefunden:' + csvListe[i1]);
       continue;
     end;

     if not fCSVAktieList.LoadFromFile(csvListe[i1]) then
     begin
       TSIServer2.Protokoll.write('CSVKurseToDB', 'Aktie "' +  fCSVAktieList.WKN + ' ' + fCSVAktieList.Aktie + '" -->  Kurse konnten nicht eingelesen werden.');
       continue;
     end;
     //if fCSVAktieList.WKN <> '918422' then
     //  continue;
     //if fCSVAktieList.WKN <> 'DAX' then
     //  continue;
     if Assigned(fOnProgress) then
       fOnProgress(i1, 'KurseToDB: ' + fCSVAktieList.WKN + ' ' + fCSVAktieList.Aktie);
     if fCSVAktieList.Count = 0 then
     begin
       TSIServer2.Protokoll.write('CSVKurseToDB', 'Aktie "' +  fCSVAktieList.WKN + ' ' + fCSVAktieList.Aktie + '" -->  Keine Kurse gefunden.');
       continue;
     end;
     SaveKurse;
   end;
 end;

 procedure TCSVKurseToDB.SaveKurse;
 var
   i1: Integer;
   LastKurs: TDateTime;
   Kurs: real;
   EPS: real;
   KGV: real;
 begin
   fDBAktie.ReadWKN(fCSVAktieList.WKN);
   if not fDBAktie.Gefunden then
     TSIServer2.Protokoll.write('CSVKurseToDB', 'Aktie "' +  fCSVAktieList.WKN + ' ' + fCSVAktieList.Aktie + '" nicht gefunden.');
   LastKurs := fDBKursList.LastKurs(fDBAktie.Id);
   for i1 := 0 to fCSVAktieList.Count -1 do
   begin
     if Assigned(fOnProgressRefreshLabel) then
       fOnProgressRefreshLabel(fCSVAktieList.WKN + ' ' + fCSVAktieList.Aktie + ' Kursdatum: ' + DateToStr(fCSVAktieList.Item[0].Datum));
     if fCSVAktieList.Item[i1].Datum <= LastKurs then
       continue;
     if fCSVAktieList.Item[i1].Schluss = -1 then  // Wenn an einem Tag keine Kurse vorhanden sind, dann gibt Yahoo finance den Wert Null zurück
       continue;

     KGV  := 0;
     EPS  := TSIServer2.Allg.Runden(fDBAktie.EPS, 2);
     Kurs := TSIServer2.Allg.Runden(fCSVAktieList.Item[i1].Schluss, 5);

     if (Kurs > 0) and (EPS > 0) then
       KGV  := Kurs / EPS;

     if Kurs < 0 then
       KGV   := 9999999998;

     if EPS = 0 then
       KGV   := 9999999999;

     KGV  := TSIServer2.Allg.Runden(KGV, 2);

     fDBKurs.init;
     fDBKurs.AKId := fDBAktie.id;
     fDBKurs.Datum := fCSVAktieList.Item[i1].Datum;
     fDBKurs.Kurs  := fCSVAktieList.Item[i1].Schluss;
     fDBKurs.EPS   := EPS;
     fDBKurs.KGV   := KGV;
     fDBKurs.SaveToDB;
   end;
 end;

end.
