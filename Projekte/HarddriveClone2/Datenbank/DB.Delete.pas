unit DB.Delete;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.DBFeldList, Data.db, IBX.IBQuery,
  vcl.Dialogs;

type
  TDBDelete = class
  private
    fSqlText: string;
    fWasOpen: Boolean;
    fMeinName: string;
    procedure setTrans(const Value: TIBTransaction);
    procedure setSqlText(const Value: string);
  protected
    fTrans: TIBTransaction;
    fQuery: TIBQuery;
  public
    constructor Create;
    destructor Destroy; override;
    property Trans: TIBTransaction read fTrans write setTrans;
    property SqlText: string read fSqlText write setSqlText;
    procedure Prepare;
    procedure Unprepare;
    function Execute(aId: Integer): Boolean;
    property MeinName: string read fMeinName write fMeinName;
  end;

implementation

{ TDBDelete }

constructor TDBDelete.Create;
begin
  inherited;
  fQuery := TIBQuery.Create(nil);
  fMeinName := '';
end;

destructor TDBDelete.Destroy;
begin
  FreeAndNil(fQuery);
  inherited;
end;


procedure TDBDelete.Prepare;
begin
  if fQuery.Transaction = nil then
    exit;
  fWasOpen := fQuery.Transaction.InTransaction;
  if not fWasOpen then
    fQuery.Transaction.StartTransaction;
  fQuery.Prepare;
end;

procedure TDBDelete.setSqlText(const Value: string);
begin
  if fQuery.Prepared then
    Unprepare;
  fSqlText := Value;
  fQuery.Close;
  fQuery.SQL.Text := fSqlText;
end;

procedure TDBDelete.setTrans(const Value: TIBTransaction);
begin
  fTrans := Value;
  fQuery.Transaction := Value;
end;

procedure TDBDelete.Unprepare;
begin
  fQuery.UnPrepare;
  if (not fWasOpen) and (fQuery.Transaction.InTransaction) then
    fQuery.Transaction.Commit;
end;

function TDBDelete.Execute(aId: Integer): Boolean;
begin
  Result := false;
  if fQuery.Transaction = nil then
    exit;
  fWasOpen := fQuery.Transaction.InTransaction;
  try
    fQuery.ParamByName('id').AsInteger := aId;
    if not fQuery.Transaction.InTransaction then
      fQuery.Transaction.StartTransaction;
    fQuery.ExecSQL;
    Result := true;
  finally
    if (not fWasOpen) and (fQuery.Transaction.InTransaction) then
      fQuery.Transaction.Commit;
  end;
end;


end.
