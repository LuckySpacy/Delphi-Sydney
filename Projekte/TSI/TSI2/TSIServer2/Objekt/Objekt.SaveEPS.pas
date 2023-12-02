unit Objekt.SaveEPS;

interface

uses
  SysUtils, Classes, System.IOUtils, System.Types, System.UITypes,
  DB.Aktie, DB.AktieList;

type
  TStartProgressEvent=procedure(aAnzahl: Integer) of object;
  TProgressEvent=procedure(aProgress: Integer; aCaption: string) of object;
  TProgressRefreshLabelEvent=procedure(aCaption: string) of object;
  TSaveEPS = class
  private
    fOnStartProgress: TStartProgressEvent;
    fOnProgress: TProgressEvent;
    fDBAktie: TDBAktie;
    fDBAktieList: TDBAktieList;
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

{ TSaveEPS }

uses
  DateUtils, Objekt.TSIServer2;

constructor TSaveEPS.Create;
begin
  fDBAktie     := TDBAktie.Create(nil);
  fDBAktieList := TDBAktieList.Create;
end;

destructor TSaveEPS.Destroy;
begin
  FreeAndNil(fDBAktie);
  FreeAndNil(fDBAktieList);
  inherited;
end;

procedure TSaveEPS.Start;
var
  i1: Integer;
begin
  fDBAktie.Trans := TSIServer2.IBT_TSI;
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

      TSIServer2.IBT_TSI.Commit;
    end;
  finally
    if TSIServer2.IBT_TSI.InTransaction then
      TSIServer2.IBT_TSI.Rollback;
  end;

end;

end.
