unit Objekt.SaveTSIWerte;

interface

uses
  SysUtils, Classes, System.IOUtils, System.Types, System.UITypes,
  DB.Aktie, DB.AktieList, DB.Kurs, DB.KursList, DB.TSILast, DB.TSI, DB.TSIList;

type
  TStartProgressEvent=procedure(aAnzahl: Integer) of object;
  TProgressEvent=procedure(aProgress: Integer; aCaption: string) of object;
  TProgressRefreshLabelEvent=procedure(aCaption: string) of object;
  TSaveTSIWerte = class
  private
    fOnStartProgress: TStartProgressEvent;
    fOnProgress: TProgressEvent;
    fDBKursList: TDBKursList;
    fDBAktie: TDBAktie;
    fDBAktieList: TDBAktieList;
    fDBKurs: TDBKurs;
    fDBTSIList: TDBTSIList;
    fDBTSI: TDBTSI;
    fDBTSILast: TDBTSILast;
    fOnProgressRefreshLabel: TProgressRefreshLabelEvent;
    fProgressLabel: string;
    procedure SchreibeTSI(aAkId: Integer; aLastTSIDate: TDateTime; aWochen: Integer; aFilename: string);
    function getTSIWert(aStartDatum, aEndeDatum: TDateTime): Currency;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    property OnStartProgress: TStartProgressEvent read fOnStartProgress write fOnStartProgress;
    property OnProgress: TProgressEvent read fOnProgress write fOnProgress;
    property OnProgressRefreshLabel: TProgressRefreshLabelEvent read fOnProgressRefreshLabel write fOnProgressRefreshLabel;
  end;

implementation

{ TSaveTSIWerte }

uses
  DateUtils, Objekt.TSIServer2;

constructor TSaveTSIWerte.Create;
begin
  fDBKursList  := TDBKursList.Create;
  fDBAktie     := TDBAktie.Create(nil);
  fDBKurs      := TDBKurs.Create(nil);
  fDBTSIList   := TDBTSIList.Create;
  fDBTSI       := TDBTSI.Create(nil);
  fDBTSILast   := TDBTSILast.Create(nil);
  fDBAktieList := TDBAktieList.Create;
end;

destructor TSaveTSIWerte.Destroy;
begin
  FreeAndNil(fDBKursList);
  FreeAndNil(fDBAktie);
  FreeAndNil(fDBKurs);
  FreeAndNil(fDBTSIList);
  FreeAndNil(fDBTSI);
  FreeAndNil(fDBTSILast);
  FreeAndNil(fDBAktieList);
  inherited;
end;




procedure TSaveTSIWerte.Start;
var
  i1: Integer;
  LastTSIDate: TDateTime;
  Filename: string;
begin
  fDBKursList.Trans := TSIServer2.IBT_TSI;
  fDBAktie.Trans := TSIServer2.IBT_TSI;
  fDBKurs.Trans := TSIServer2.IBT_TSI;
  fDBTSIList.Trans := TSIServer2.IBT_TSI;
  fDBTSI.Trans := TSIServer2.IBT_TSI;
  fDBTSILast.Trans := TSIServer2.IBT_TSI;
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
      fProgressLabel := 'TSI-Wert für: ' + fDBAktieList.Item[i1].WKN + ' ' + fDBAktieList.Item[i1].Aktie;
      if Assigned(fOnProgress) then
        fOnProgress(i1, fProgressLabel);

      fDBTSILast.ReadAktie(fDBAktieList.Item[i1].Id, 27);
      if fDBTSILast.Gefunden then
        LastTSIDate := fDBTSILast.Datum
      else
      begin
        fDBKurs.ErsterKurs(fDBAktieList.Item[i1].Id);
        if fDBKurs.Gefunden then
          LastTSIDate := fDBKurs.Datum
        else
          LastTSIDate := 0;
      end;
      //LastTSIDate := StrToDate('01.04.2021');
      Filename := fDBAktieList.Item[i1].WKN + ' ' + fDBAktieList.Item[i1].Aktie;
      SchreibeTSI(fDBAktieList.Item[i1].Id, LastTSIDate, 27, Filename);
      SchreibeTSI(fDBAktieList.Item[i1].Id, LastTSIDate, 12, Filename);
      if TSIServer2.IBT_TSI.InTransaction then
        TSIServer2.IBT_TSI.Commit;
    end;
  finally
    if TSIServer2.IBT_TSI.InTransaction then
      TSIServer2.IBT_TSI.Rollback;

  end;

end;

procedure TSaveTSIWerte.SchreibeTSI(aAkId: Integer; aLastTSIDate: TDateTime; aWochen: Integer; aFilename: string);
var
  AnfangDatum: TDateTime;
  EndeDatum: TDateTime;
  Tage: Integer;
  TSIWert: Currency;
  Liste: TStringList;
  LastTSIDatum: TDateTime;
  LastTSIWert : Currency;
begin
  Liste := TStringList.Create;
  Tage := aWochen * 7;
  AnfangDatum := 0;
  Endedatum := 0;
  if aLastTSIDate > 0 then
  begin
    aLastTSIDate := IncDay(aLastTSIDate, 1);
    AnfangDatum := trunc(IncDay(aLastTSIDate, -Tage));
    EndeDatum   := aLastTSIDate;
  end;

  fDBKursList.ReadFromStart(aAkId, AnfangDatum);

  LastTSIDatum := 0;
  LastTSIWert  := 0;

  while EndeDatum <= trunc(now) do
  begin
    TSIWert := getTSIWert(AnfangDatum, EndeDatum);
    Liste.Add(DateToStr(EndeDatum) + ' ' + FloatToStr(TSIWert));
    if TSIWert > -999 then
    begin
      if Assigned(fOnProgressRefreshLabel) then
        fOnProgressRefreshLabel(fProgressLabel + ' Datum: ' + DateToStr(EndeDatum));
      LastTSIDatum := EndeDatum;
      LastTSIWert  := TSIWert;
      fDBTSI.ReadWert(aAkId, aWochen, EndeDatum);
      fDBTSI.AkId := aAKId;
      fDBTSI.Wochen := aWochen;
      fDBTSI.Datum  := EndeDatum;
      fDBTSI.Wert   := TSIWert;
      fDBTSI.SaveToDB;
    end;
    AnfangDatum := IncDay(AnfangDatum, 1);
    EndeDatum   := IncDay(EndeDatum, 1);
  end;

  if LastTSIDatum > 0 then
  begin
    fDBTSILast.ReadAktie(aAkId, aWochen);
    fDBTSILast.AkId := aAKId;
    fDBTSILast.Wochen := aWochen;
    fDBTSILast.Datum := LastTSIDatum;
    fDBTSILast.Wert  := LastTSIWert;
    fDBTSILast.SaveToDB;
  end;


 // Liste.SaveToFile('d:\MeineProgramme\TSI2\Kurse\' + aFilename + '_' + IntToStr(aWochen) + '.txt');

  FreeAndNil(Liste);
end;

function TSaveTSIWerte.getTSIWert(aStartDatum, aEndeDatum: TDateTime): Currency;
var
  i1: Integer;
  Anzahl: Integer;
  Werte: Currency;
  EndeDatumDerKursliste: TDateTime;
  LastKurs: Currency;
  EndeDatumGefunden: Boolean;
begin
  Result := -999;
  LastKurs := 0;
  if fDBKursList.count = 0 then
    exit;
  EndeDatumGefunden := false;
  EndeDatumDerKursliste := fDBKursList.Item[fDBKursList.Count-1].Datum;
  if EndeDatumDerKursListe < aEndeDatum then
    exit;
  Anzahl := 0;
  Werte  := 0;
  for i1 := 0 to fDBKursList.Count -1 do
  begin
    if fDBKursList.Item[i1].Datum <= aStartDatum then
      continue;
    if fDBKursList.Item[i1].Datum = aEndeDatum then
      EndeDatumGefunden := true;
    if fDBKursList.Item[i1].Datum >= aEndeDatum then
      continue;
    LastKurs := fDBKursList.Item[i1].Kurs;
    Werte := Werte + fDBKursList.Item[i1].Kurs;
    inc(Anzahl);
  end;
  if LastKurs = 0 then
  begin
    Result := -999;
    exit;
  end;
  Result := Werte / Anzahl; // Durchschnittlicher Kurswert;
  Result := LastKurs / Result; // Letzter Kurs / Durchschnittskurswert
  if not EndeDatumGefunden then
    Result := -999;
end;

end.
