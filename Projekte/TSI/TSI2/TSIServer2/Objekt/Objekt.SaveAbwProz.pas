unit Objekt.SaveAbwProz;

interface

uses
  SysUtils, Classes, System.IOUtils, System.Types, System.UITypes,
  DB.Aktie, DB.AktieList, DB.Kurs, DB.KursList, DB.AbwProz;

type
  TStartProgressEvent=procedure(aAnzahl: Integer) of object;
  TProgressEvent=procedure(aProgress: Integer; aCaption: string) of object;
  TProgressRefreshLabelEvent=procedure(aCaption: string) of object;
  TSaveAbwProz = class
  private
    fOnStartProgress: TStartProgressEvent;
    fOnProgress: TProgressEvent;
    fDBKursList: TDBKursList;
    fDBAktie: TDBAktie;
    fDBAktieList: TDBAktieList;
    fDBKurs: TDBKurs;
    fDBAbwProz: TDBAbwProz;
    fOnProgressRefreshLabel: TProgressRefreshLabelEvent;
    fProgressLabel: string;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    procedure ErmittleWert(aAkId, aTage: Integer; var aWert: Currency; var aDatum: TDateTime);
    property OnStartProgress: TStartProgressEvent read fOnStartProgress write fOnStartProgress;
    property OnProgress: TProgressEvent read fOnProgress write fOnProgress;
    property OnProgressRefreshLabel: TProgressRefreshLabelEvent read fOnProgressRefreshLabel write fOnProgressRefreshLabel;
  end;

implementation

{ TSaveTSIWerte }

uses
  DateUtils, Objekt.TSIServer2;

constructor TSaveAbwProz.Create;
begin
  fDBKursList  := TDBKursList.Create;
  fDBAktie     := TDBAktie.Create(nil);
  fDBKurs      := TDBKurs.Create(nil);
  fDBAbwProz   := TDBAbwProz.Create(nil);
  fDBAktieList := TDBAktieList.Create;
end;

destructor TSaveAbwProz.Destroy;
begin
  FreeAndNil(fDBKursList);
  FreeAndNil(fDBAktie);
  FreeAndNil(fDBKurs);
  FreeAndNil(fDBAbwProz);
  FreeAndNil(fDBAktieList);
  inherited;
end;



procedure TSaveAbwProz.Start;
var
  i1: Integer;
  KursWert: Currency;
  LastKurs: Currency;
  LastDatum: TDateTime;
  Datum: TDateTime;
begin
  fDBKursList.Trans := TSIServer2.IBT_TSI;
  fDBAktie.Trans := TSIServer2.IBT_TSI;
  fDBKurs.Trans := TSIServer2.IBT_TSI;
  fDBAbwProz.Trans := TSIServer2.IBT_TSI;
  fDBAktieList.Trans := TSIServer2.IBT_TSI;

  fDBAktieList.ReadAll;

  if Assigned(fOnStartProgress) then
    fOnStartProgress(fDBAktieList.Count);


  if TSIServer2.IBT_TSI.InTransaction then
    TSIServer2.IBT_TSI.Rollback;
  try
    for i1 := 0 to fDBAktieList.Count -1 do
    begin
      TSIServer2.IBT_TSI.StartTransaction;
      fProgressLabel := 'AbwProz für: ' + fDBAktieList.Item[i1].WKN + ' ' + fDBAktieList.Item[i1].Aktie;
      if Assigned(fOnProgress) then
        fOnProgress(i1, fProgressLabel);

      fDBAbwProz.ReadAktie(fDBAktieList.Item[i1].Id);
      fDBKurs.LastKurs(fDBAktieList.Item[i1].Id);
      LastKurs := fDBKurs.Kurs;
      LastDatum := fDBKurs.Datum;
      Datum    := LastDatum;
      KursWert := LastKurs;

      ErmittleWert(fDBAktieList.Item[i1].Id, 1, KursWert, Datum);
      fDBAbwProz.Datum1 := Datum;
      fDBAbwProz.Wert1  := KursWert; // Zurück kommt Prozentwert;


      KursWert := LastKurs;
      Datum := LastDatum;
      ErmittleWert(fDBAktieList.Item[i1].Id, 7, KursWert, Datum);
      fDBAbwProz.Datum7 := Datum;
      fDBAbwProz.Wert7  := KursWert; // Zurück kommt Prozentwert;

      KursWert := LastKurs;
      Datum := LastDatum;
      ErmittleWert(fDBAktieList.Item[i1].Id, 14, KursWert, Datum);
      fDBAbwProz.Datum14 := Datum;
      fDBAbwProz.Wert14  := KursWert; // Zurück kommt Prozentwert;

      KursWert := LastKurs;
      Datum := LastDatum;
      ErmittleWert(fDBAktieList.Item[i1].Id, 30, KursWert, Datum);
      fDBAbwProz.Datum30 := Datum;
      fDBAbwProz.Wert30  := KursWert; // Zurück kommt Prozentwert;

      KursWert := LastKurs;
      Datum := LastDatum;
      ErmittleWert(fDBAktieList.Item[i1].Id, 60, KursWert, Datum);
      fDBAbwProz.Datum60 := Datum;
      fDBAbwProz.Wert60  := KursWert; // Zurück kommt Prozentwert;

      KursWert := LastKurs;
      Datum := LastDatum;
      ErmittleWert(fDBAktieList.Item[i1].Id, 90, KursWert, Datum);
      fDBAbwProz.Datum90 := Datum;
      fDBAbwProz.Wert90  := KursWert; // Zurück kommt Prozentwert;

      KursWert := LastKurs;
      Datum := LastDatum;
      ErmittleWert(fDBAktieList.Item[i1].Id, 180, KursWert, Datum);
      fDBAbwProz.Datum180 := Datum;
      fDBAbwProz.Wert180  := KursWert; // Zurück kommt Prozentwert;


      KursWert := LastKurs;
      Datum := LastDatum;
      ErmittleWert(fDBAktieList.Item[i1].Id, 365, KursWert, Datum);
      fDBAbwProz.Datum365 := Datum;
      fDBAbwProz.Wert365  := KursWert; // Zurück kommt Prozentwert;


      fDBAbwProz.AkId := fDBAktieList.Item[i1].Id;
      fDBAbwProz.SaveToDB;

      if TSIServer2.IBT_TSI.InTransaction then
        TSIServer2.IBT_TSI.Commit;

     // break;


    end;
  finally
    if TSIServer2.IBT_TSI.InTransaction then
      TSIServer2.IBT_TSI.Rollback;

  end;


end;


procedure TSaveAbwProz.ErmittleWert(aAkId, aTage: Integer; var aWert: Currency;
  var aDatum: TDateTime);
var
  StartDatum: TDateTime;
  Wert: Currency;
  Diff: Currency;
begin
  StartDatum := aDatum;

  StartDatum := IncDay(StartDatum, -aTage);
  if DayOf(StartDatum) = DaySunday then
    StartDatum := IncDay(StartDatum, -2);
  if DayOf(StartDatum) = DaySaturday then
    StartDatum := IncDay(StartDatum, -1);

  fDBKurs.LastKursFromStartDate(aAkId, StartDatum);
  if not fDBKurs.Gefunden then
    exit;

  Wert   := fDBKurs.Kurs;
  aDatum := fDBKurs.Datum;

  if aWert = Wert then
  begin
    aWert := 0;
    exit;
  end;

  if aWert > Wert then
  begin
    Diff := aWert - Wert;
    aWert := Diff * 100 / Wert;
  end
  else
  begin
    Diff := Wert - aWert;
    aWert := Diff * 100 / Wert;
    aWert := aWert * -1;
  end;

end;


end.
