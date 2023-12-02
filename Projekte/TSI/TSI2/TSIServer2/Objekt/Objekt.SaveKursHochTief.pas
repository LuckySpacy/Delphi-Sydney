unit Objekt.SaveKursHochTief;

interface

uses
  SysUtils, Classes, System.IOUtils, System.Types, System.UITypes,
  DB.Aktie, DB.AktieList, DB.Kurs, DB.KursList, DB.KursHochTief;

type
  TStartProgressEvent=procedure(aAnzahl: Integer) of object;
  TProgressEvent=procedure(aProgress: Integer; aCaption: string) of object;
  TProgressRefreshLabelEvent=procedure(aCaption: string) of object;
  TSaveKursHochTief = class
  private
    fOnStartProgress: TStartProgressEvent;
    fOnProgress: TProgressEvent;
    fDBKursList: TDBKursList;
    fDBAktie: TDBAktie;
    fDBAktieList: TDBAktieList;
    fDBKurs: TDBKurs;
    fDBKursHochTief: TDBKursHochTief;
    fOnProgressRefreshLabel: TProgressRefreshLabelEvent;
    fProgressLabel: string;
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

{ TSaveKursHochTief }

uses
  DateUtils, Objekt.TSIServer2;

constructor TSaveKursHochTief.Create;
begin
  fDBKursList     := TDBKursList.Create;
  fDBAktie        := TDBAktie.Create(nil);
  fDBKurs         := TDBKurs.Create(nil);
  fDBKursHochTief := TDBKursHochTief.Create(nil);
  fDBAktieList    := TDBAktieList.Create;
end;

destructor TSaveKursHochTief.Destroy;
begin
  FreeAndNil(fDBKursList);
  FreeAndNil(fDBAktie);
  FreeAndNil(fDBKurs);
  FreeAndNil(fDBKursHochTief);
  FreeAndNil(fDBAktieList);
  inherited;
end;

procedure TSaveKursHochTief.Start;
var
  i1: Integer;
  LetztesJahr: TDateTime;
  LetztesHalbJahr: TDateTime;
begin

  LetztesJahr := trunc(IncYear(now, -1));
  LetztesHalbJahr := trunc(IncMonth(now, -6));

  fDBKursList.Trans := TSIServer2.IBT_TSI;
  fDBAktie.Trans := TSIServer2.IBT_TSI;
  fDBKurs.Trans := TSIServer2.IBT_TSI;
  fDBKursHochTief.Trans := TSIServer2.IBT_TSI;
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
      fProgressLabel := 'Kurs Hoch Tief für: ' + fDBAktieList.Item[i1].WKN + ' ' + fDBAktieList.Item[i1].Aktie;
      if Assigned(fOnProgress) then
        fOnProgress(i1, fProgressLabel);

      fDBKursHochTief.ReadAktie(fDBAktieList.Item[i1].Id);

      fDBKurs.MaxKurs(fDBAktieList.Item[i1].Id, LetztesJahr, now);
      FDBKursHochTief.HochJahrKurs  := fDBKurs.Kurs;
      FDBKursHochTief.HochJahrDatum := fDBKurs.Datum;

      fDBKurs.MaxKurs(fDBAktieList.Item[i1].Id, LetztesHalbJahr, now);
      FDBKursHochTief.HochHJahrKurs  := fDBKurs.Kurs;
      FDBKursHochTief.HochHJahrDatum := fDBKurs.Datum;

      fDBKurs.MinKurs(fDBAktieList.Item[i1].Id, LetztesJahr, now);
      FDBKursHochTief.TiefJahrKurs  := fDBKurs.Kurs;
      FDBKursHochTief.TiefJahrDatum := fDBKurs.Datum;


      fDBKurs.MinKurs(fDBAktieList.Item[i1].Id, LetztesHalbJahr, now);
      FDBKursHochTief.TiefHJahrKurs  := fDBKurs.Kurs;
      FDBKursHochTief.TiefHJahrDatum := fDBKurs.Datum;

      fDBKurs.LastKurs(fDBAktieList.Item[i1].Id);
      FDBKursHochTief.LetzterKurs  := fDBKurs.Kurs;
      FDBKursHochTief.LetzterKursDatum := fDBKurs.Datum;
      FDBKursHochTief.EPS := fDBKurs.EPS;
      fDBKursHochTief.KGV := fDBKurs.KGV;



      FDBKursHochTief.AkId := fDBAktieList.Item[i1].Id;
      FDBKursHochTief.SaveToDB;

      if TSIServer2.IBT_TSI.InTransaction then
        TSIServer2.IBT_TSI.Commit;

    end;
  finally
    if TSIServer2.IBT_TSI.InTransaction then
      TSIServer2.IBT_TSI.Rollback;

  end;


end;

end.
