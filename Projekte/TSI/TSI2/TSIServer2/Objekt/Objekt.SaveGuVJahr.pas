unit Objekt.SaveGuVJahr;

interface

uses
  SysUtils, Classes, System.IOUtils, System.Types, System.UITypes,
  DB.Aktie, DB.AktieList, DB.Kurs, DB.KursList, DB.TSILast, DB.TSI, DB.TSIList,
  DB.GuVJahr, DB.GuVJahrList, System.Generics.Collections, DB.GuVJahre, db.AbwProz;

type
  TStartProgressEvent=procedure(aAnzahl: Integer) of object;
  TProgressEvent=procedure(aProgress: Integer; aCaption: string) of object;
  TProgressRefreshLabelEvent=procedure(aCaption: string) of object;
  TSaveGuVJahr = class
  private
    fOnStartProgress: TStartProgressEvent;
    fOnProgress: TProgressEvent;
    fDBKursList: TDBKursList;
    fDBAktie: TDBAktie;
    fDBAktieList: TDBAktieList;
    fDBGuVJahr: TDBGuVJahr;
    fDBGuVJahre: TDBGuVJahre;
    fDBKurs: TDBKurs;
    fOnProgressRefreshLabel: TProgressRefreshLabelEvent;
    fProgressLabel: string;
    fDBAbwProz: TDBAbwProz;
    fDBTSILast: TDBTSILast;
    procedure SetzeProzentWertToDBGuVJahre(aJahr: Integer; aProzent: real);
    procedure SetzeProzentDurchschnittWertToDBGuVJahre;
    procedure SetzeAbwProzentZumDurchschnitt;
    //procedure SchreibeGuV(aAkId: Integer; aLastTSIDate: TDateTime; aWochen: Integer; aFilename: string);
    //function getTSIWert(aStartDatum, aEndeDatum: TDateTime): Currency;
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

{ TSaveGuVJahr }

uses
  DateUtils, Objekt.TSIServer2;

constructor TSaveGuVJahr.Create;
begin
  fDBKursList  := TDBKursList.Create;
  fDBAktie     := TDBAktie.Create(nil);
  fDBAktieList := TDBAktieList.Create;
  fDBGuVJahr   := TDBGuVJahr.Create(nil);
  fDBGuVJahre  := TDBGuVJahre.Create(nil);
  fDBKurs      := TDBKurs.Create(nil);
  fDBAbwProz   := TDBAbwProz.Create(nil);
  fDBTSILast   := TDBTSILast.Create(nil);
end;

destructor TSaveGuVJahr.Destroy;
begin
  FreeAndNil(fDBKursList);
  FreeAndNil(fDBAktie);
  FreeAndNil(fDBAktieList);
  FreeAndNil(fDBGuVJahr);
  FreeAndNil(fDBGuVJahre);
  FreeAndNil(fDBKurs);
  FreeAndNil(fDBAbwProz);
  FreeAndNil(fDBTSILast);
  inherited;
end;


procedure TSaveGuVJahr.Start;
var
  i1, i2: Integer;
  //Jahr: Integer;
  YearList: TList<Integer>;
  StartDatum: TDateTime;
  EndDatum  : TDateTime;
  AkId: Integer;
  Diff: real;
  Proz: real;
  JahrList: TList<Integer>;
begin

  fDBKursList.Trans := TSIServer2.IBT_TSI;
  fDBAktie.Trans := TSIServer2.IBT_TSI;
  fDBAktieList.Trans := TSIServer2.IBT_TSI;
  fDBGuVJahr.Trans := TSIServer2.IBT_TSI;
  fDBGuVJahre.Trans := TSIServer2.IBT_TSI;
  fDBKurs.Trans := TSIServer2.IBT_TSI;
  fDBAbwProz.Trans := TSIServer2.IBT_TSI;
  fDBTSILast.Trans := TSIServer2.IBT_TSI;

  fDBAktieList.ReadAll;

  if Assigned(fOnStartProgress) then
    fOnStartProgress(fDBAktieList.Count);

  YearList := TList<Integer>.Create;
  JahrList := TList<Integer>.Create;


  for i1 := YearOf(now) - 5 to YearOf(now) do
    JahrList.Add(i1);



  if TSIServer2.IBT_TSI.InTransaction then
    TSIServer2.IBT_TSI.Rollback;
  try
    for i1 := 0 to fDBAktieList.Count -1 do
    begin
      if Assigned(fOnProgress) then
        fOnProgress(i1, fProgressLabel);
      //if fDBAktieList.Item[i1].WKN <> 'A0JMPL' then
      //  continue;
      if not TSIServer2.IBT_TSI.InTransaction then
        TSIServer2.IBT_TSI.StartTransaction;
      //fDBKurs.ErsterKurs(fDBAktieList.Item[i1].FeldList.FieldByName('AK_ID').AsInteger);
      //Jahr := YearOf(fDBKurs.Datum);
      AkId := fDBAktieList.Item[i1].FeldList.FieldByName('AK_ID').AsInteger;
      fDBKurs.YearList(AkId, YearList);
      fProgressLabel := 'GuV für: ' + fDBAktieList.Item[i1].WKN + ' ' + fDBAktieList.Item[i1].Aktie;

      //if AkId <> 136 then
      //  continue;


      fDBGuVJahre.Init;
      fDBGuVJahre.ReadAkId(AkId);
      fDBGuVJahre.AkId := AkId;
      fDBGuvJahre.Jahr1 := JahrList.Items[0];
      fDBGuvJahre.Jahr2 := JahrList.Items[1];
      fDBGuvJahre.Jahr3 := JahrList.Items[2];
      fDBGuvJahre.Jahr4 := JahrList.Items[3];
      fDBGuvJahre.Jahr5 := JahrList.Items[4];
      fDBGuvJahre.Jahr6 := JahrList.Items[5];

      fDBAbwProz.ReadAktie(AkId);
      if fDBAbwProz.Gefunden then
        fDBGuVJahre.Proz365Tage := fDBAbwProz.FeldList.FieldByName('AP_WERT365').AsFloat;

      fDBTSILast.ReadAktie(AkId, 27);
      if fDBTSILast.Gefunden then
        fDBGUVJahre.TSI27 := fDBTSILast.FeldList.FieldByName('TL_WERT').AsFloat;

      for i2 := 0 to YearList.Count -1 do
      begin
        if Assigned(fOnProgressRefreshLabel) then
          fOnProgressRefreshLabel(fProgressLabel + ' Jahr: ' + IntToStr(YearList.Items[i2]));

        fDBGuVJahr.ReadJahr(AkId, YearList.Items[i2]);
        SetzeProzentWertToDBGuVJahre(YearList.Items[i2], fDBGuVJahr.Prozent);


        if (YearList.Items[i2] <> YearOf(now)) and (fDBGuVJahr.Gefunden) then
          continue;

        StartDatum := StrToDate('01.01.' + IntToStr(YearList.Items[i2]));
        fDBKurs.ErsterKursVonStartdatum(AkId, StartDatum);
        fDBGuVJahr.Jahr := YearList.Items[i2];
        fDBGuVJahr.AkId := AkId;
        fDBGuVJahr.StartDatum := fDBKurs.Datum;
        fDBGuVJahr.Startwert  := fDBKurs.Kurs;
        EndDatum := StrToDate('31.12.' + IntToStr(YearList.Items[i2]));
        fDBKurs.LetzterKursVonEnddatum(AkId, StartDatum, EndDatum);
        fDBGuVJahr.EndDatum := fDBKurs.Datum;
        fDBGuVJahr.Endwert  := fDBKurs.Kurs;

        if (YearList.Items[i2] <> YearOf(now)) then
        begin
          if (MonthOf(fDBGuVJahr.StartDatum) <> 1)
          or (MonthOf(fDBGuVJahr.EndDatum) <> 12) then
            continue;
        end;

        if fDBGuVJahr.Endwert >=  fDBGuVJahr.StartWert then
        begin
          Diff := fDBGuVJahr.Endwert - fDBGuVJahr.StartWert;
          Proz := Diff * 100 / fDBGuVJahr.StartWert;
        end
        else
        begin
          Diff := fDBGuVJahr.Startwert - fDBGuVJahr.EndWert;
          Proz := Diff * 100 / fDBGuVJahr.StartWert;
          Proz := Proz *-1;
        end;

        fDBGuVJahr.Prozent := Proz;
        fDBGuVJahr.SaveToDB;
        SetzeProzentWertToDBGuVJahre(YearList.Items[i2], fDBGuVJahr.Prozent);

      end;
      SetzeProzentDurchschnittWertToDBGuVJahre;
      SetzeAbwProzentZumDurchschnitt;
      fDBGuVJahre.SaveToDB;
      if TSIServer2.IBT_TSI.InTransaction then
        TSIServer2.IBT_TSI.Commit;
    end;
  finally
    if TSIServer2.IBT_TSI.InTransaction then
      TSIServer2.IBT_TSI.Rollback;
    FreeAndNil(YearList);
    FreeAndNil(JahrList);
  end;

end;

procedure TSaveGuVJahr.SetzeProzentWertToDBGuVJahre(aJahr: Integer; aProzent: real);
begin
  if fDBGuVJahre.Jahr1 = aJahr then
    fDBGuVJahre.Prozent1 := aProzent;
  if fDBGuVJahre.Jahr2 = aJahr then
    fDBGuVJahre.Prozent2 := aProzent;
  if fDBGuVJahre.Jahr3 = aJahr then
    fDBGuVJahre.Prozent3 := aProzent;
  if fDBGuVJahre.Jahr4 = aJahr then
    fDBGuVJahre.Prozent4 := aProzent;
  if fDBGuVJahre.Jahr5 = aJahr then
    fDBGuVJahre.Prozent5 := aProzent;
  if fDBGuVJahre.Jahr6 = aJahr then
    fDBGuVJahre.Prozent6 := aProzent;
end;


procedure TSaveGuVJahr.SetzeProzentDurchschnittWertToDBGuVJahre;
  function AddSumme(aSumme, aProzent: real; var aIndex:Integer): real;
  begin
    Result := aSumme;
    if aProzent <> 0 then
    begin
      Inc(aIndex);
      Result := aSumme + aProzent;
    end;
  end;
var
  i1: Integer;
  Summe: real;
begin
  fDBGuVJahre.Durchschnitt := 0;
  i1 := 0;
  Summe := 0;
  Summe := AddSumme(Summe, fDBGuVJahre.Prozent1, i1);
  Summe := AddSumme(Summe, fDBGuVJahre.Prozent2, i1);
  Summe := AddSumme(Summe, fDBGuVJahre.Prozent3, i1);
  Summe := AddSumme(Summe, fDBGuVJahre.Prozent4, i1);
  Summe := AddSumme(Summe, fDBGuVJahre.Prozent5, i1);
  if i1 > 0 then
    fDBGuVJahre.Durchschnitt := fDBGuVJahre.Runden(Summe / i1, 2);
end;


procedure TSaveGuVJahr.SetzeAbwProzentZumDurchschnitt;
var
  AktuellerProz: real;
  EinZwoelftelVonProz365Tage: real;
  RestMonate: Integer;
  Diff: real;
begin
  fDBGuVJahre.AbwProz := 0;
  EinZwoelftelVonProz365Tage := fDBGuVJahre.Runden(fDBGuVJahre.Proz365Tage / 12, 2);
  RestMonate := 12 - MonthOf(now);
  AktuellerProz := EinZwoelftelVonProz365Tage * RestMonate;
  AktuellerProz := AktuellerProz +  fDBGuVJahre.Prozent6; //=Laufendes Jahr;
  if fDBGUVJahre.Durchschnitt > AktuellerProz then
  begin
    Diff := fDBGUVJahre.Durchschnitt - AktuellerProz;
    fDBGuVJahre.AbwProz := fDBGuVJahre.Runden(Diff * 100 / AktuellerProz, 2);
  end;
  if fDBGUVJahre.Durchschnitt < AktuellerProz then
  begin
    Diff := AktuellerProz - fDBGuVJahre.Durchschnitt;
    fDBGuVJahre.AbwProz := fDBGuVJahre.Runden(Diff * 100 / AktuellerProz, 2) * -1;
  end;
  fDBGuVJahre.AbwProzSort := fDBGuVJahre.AbwProz;
  if fDBGuVJahre.TSI27 < 1 then
  begin
    if fDBGuVJahre.AbwProzSort > 0 then
      fDBGuVJahre.AbwProzSort := 0;
  end;
end;


end.
