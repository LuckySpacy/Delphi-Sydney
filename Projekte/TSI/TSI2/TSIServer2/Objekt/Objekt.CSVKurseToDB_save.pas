unit Objekt.CSVKurseToDB;

interface

uses
  SysUtils, Classes, System.IOUtils, System.Types, System.UITypes,
  Objekt.CSVAktieList, Objekt.CSVAktie, DB.KursList, DB.Aktie,
  DB.Kurs;

type
  TStartProgressEvent=procedure(aAnzahl: Integer) of object;
  TProgressEvent=procedure(aProgress: Integer; aCaption: string) of object;
  TCSVKurseToDB = class
  private
    fCSVAktieList: TCSVAktieList;
    fOnStartProgress: TStartProgressEvent;
    fOnProgress: TProgressEvent;
    fDBKursList: TDBKursList;
    fDBAktie: TDBAktie;
    fDBKurs: TDBKurs;
    procedure SaveKurse;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start(aDownloadPfad: string);
    property OnStartProgress: TStartProgressEvent read fOnStartProgress write fOnStartProgress;
    property OnProgress: TProgressEvent read fOnProgress write fOnProgress;
  end;

implementation

{ TCSVKurseToDB }

uses
  Objekt.TSIServer2;

constructor TCSVKurseToDB.Create;
begin
  fCSVAktieList := TCSVAktieList.Create;
  fDBKursList := TDBKursList.Create;
  fDBKursList.Trans := TSIServer2.IBT_TSI;
  fDBAktie := TDBAktie.Create(nil);
  fDBAktie.Trans := TSIServer2.IBT_TSI;
  fDBKurs := TDBKurs.Create(nil);
  fDBKurs.Trans := TSIServer2.IBT_TSI;
end;

destructor TCSVKurseToDB.Destroy;
begin
  FreeAndNil(fCSVAktieList);
  FreeAndNil(fDBKursList);
  FreeAndNil(fDBAktie);
  FreeAndNil(fDBKurs);
  inherited;
end;

procedure TCSVKurseToDB.Start(aDownloadPfad: string);
var
  CSVListe: TStringDynArray;
  i1: Integer;
begin
  CSVListe := TDirectory.GetFiles(aDownloadPfad, '*.csv');

  if Assigned(fOnStartProgress) then
    fOnStartProgress(High(CSVListe));

  for i1 := low(CSVListe) to High(CSVListe) do
  begin
    fCSVAktieList.LoadFromFile(csvListe[i1]);
    if Assigned(fOnProgress) then
      fOnProgress(i1, fCSVAktieList.WKN + ' ' + fCSVAktieList.Aktie);
    SaveKurse;
  end;

end;

procedure TCSVKurseToDB.SaveKurse;
var
  i1: Integer;
  LastKurs: TDateTime;
begin
  fDBAktie.ReadWKN(fCSVAktieList.WKN);
  if not fDBAktie.Gefunden then
    TSIServer2.Protokoll.write('CSVKurseToDB', 'Aktie "' +  fCSVAktieList.WKN + ' ' + fCSVAktieList.Aktie + '" nicht gefunden.');
  LastKurs := fDBKursList.LastKurs(fDBAktie.Id);
  for i1 := 0 to fCSVAktieList.Count -1 do
  begin
    if Assigned(fOnProgress) then
      fOnProgress(i1, fCSVAktieList.WKN + ' ' + fCSVAktieList.Aktie + ' Kursdatum: ' + DateToStr(fCSVAktieList.Item[0].Datum));
    if fCSVAktieList.Item[0].Datum <= LastKurs then
      continue;
      {
     fDBKurs.init;
     fDBKurs.AKId := fDBAktie.id;
     fDBKurs.Datum := fCSVAktieList.Item[i1].Datum;
     fDBKurs.Kurs  := fCSVAktieList.Item[i1].Schluss;
     fDBKurs.SaveToDB;
     }
  end;
end;

end.
