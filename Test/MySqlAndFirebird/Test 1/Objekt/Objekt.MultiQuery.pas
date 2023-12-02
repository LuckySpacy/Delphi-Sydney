unit Objekt.MultiQuery;

interface
uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.DBFeldList, Data.db, IBX.IBQuery,
  vcl.Dialogs, Objekt.Allg, FireDAC.Comp.Client, Objekt.MultiQueryFeld,
  Objekt.MultiqueryFeldList;

type
  TMultiQuery = class(TComponent)
  private
    fIBQuery: TIBQuery;
    fFDQuery: TFDQuery;
    fUseFirebird: Boolean;
    fUseMySql: Boolean;
    fIBTransaction: TIBTransaction;
    fFDTransaction: TFDTransaction;
    fSqlText: string;
    fTrans: Pointer;
    fWasOpen: Boolean;
    fMultiQueryFeldList: TMultiQueryFeldList;
    procedure setUseFirebird(const Value: Boolean);
    procedure setUseMySql(const Value: Boolean);
    procedure setIBTransaction(const Value: TIBTransaction);
    procedure setFDTransaction(const Value: TFDTransaction);
    procedure setSqlText(const Value: string);
    procedure setTrans(const Value: Pointer);
    procedure IBOpenTrans;
    procedure IBRollbackTrans;
    procedure IBCommitTrans;
    procedure MySqlOpenTrans;
    procedure MySqlRollbackTrans;
    procedure MySqlCommitTrans;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property UseMySql: Boolean read fUseMySql write setUseMySql;
    property UseFirebird: Boolean read fUseFirebird write setUseFirebird;
    property IBTransaction: TIBTransaction read fIBTransaction write setIBTransaction;
    property FDTransaction: TFDTransaction read fFDTransaction write setFDTransaction;
    property Trans: Pointer read fTrans write setTrans;
    property SqlText: string read fSqlText write setSqlText;
    procedure Close;
    procedure OpenTrans;
    procedure RollbackTrans;
    procedure CommitTrans;
    procedure Open;
    function Eof: Boolean;
    function FieldByName(const FieldName: string): TField;
    function ParamByName(const Value: string): TMultiQueryFeld;
    procedure Next;
  end;

implementation

{ TMultiQuery }



constructor TMultiQuery.Create(AOwner: TComponent);
begin
  inherited;
  fIBQuery := TIBQuery.Create(AOwner);
  fFDQuery := TFDQuery.Create(AOwner);
  fMultiQueryFeldList := TMultiQueryFeldList.Create;
  fWasOpen := false;
end;

destructor TMultiQuery.Destroy;
begin
  FreeAndNil(fIBQuery);
  FreeAndNil(fFDQuery);
  FreeAndNil(fMultiQueryFeldList);
  inherited;
end;






procedure TMultiQuery.setFDTransaction(const Value: TFDTransaction);
begin
  fFDTransaction := Value;
  fFDQuery.Transaction := fFDTransaction;
end;

procedure TMultiQuery.setIBTransaction(const Value: TIBTransaction);
begin
  fIBTransaction := Value;
  fIBQuery.Transaction := fIBTransaction;
end;


procedure TMultiQuery.setUseFirebird(const Value: Boolean);
begin
  fUseFirebird := Value;
  if Value then
    fUseMySql := false;
end;

procedure TMultiQuery.setUseMySql(const Value: Boolean);
begin
  fUseMySql := Value;
  if Value then
    fUseFirebird := false;
end;

procedure TMultiQuery.close;
begin
  if fUseFirebird then
    fIBQuery.Close;
  if fUseMySql then
    fFDQuery.Close;
end;


procedure TMultiQuery.setSqlText(const Value: string);
begin
  fSqlText := Value;
  if fUseFirebird then
    fIBQuery.Sql.Text := fSqlText;
  if fUseMySql then
    fFDQuery.SQL.Text := fSqlText;
end;



procedure TMultiQuery.setTrans(const Value: Pointer);
begin
  fTrans := Value;
  if fUseFirebird then
    fIBQuery.Transaction := TIBTransaction(fTrans);
  if fUseMySql then
  begin
    fFDQuery.Transaction := TFDTransaction(fTrans);
    fFDQuery.Connection  := fFDQuery.Transaction.Connection;
  end;
end;


procedure TMultiQuery.CommitTrans;
begin
  if fUseFirebird then
    IBCommitTrans;
  if fUseMySql then
    MySqlCommitTrans;
end;


procedure TMultiQuery.Open;
begin
  if fUseFirebird then
    fIBQuery.Open;
  if fUseMySql then
    fFDQuery.Open;
end;

procedure TMultiQuery.OpenTrans;
begin
  if fUseFirebird then
    IBOpenTrans;
  if fUseMySql then
    MySqlOpenTrans;
end;


procedure TMultiQuery.RollbackTrans;
begin
  if fUseFirebird then
    IBRollbackTrans;
  if fUseMySql then
    MySqlRollbackTrans;
end;


procedure TMultiQuery.IBCommitTrans;
begin
  if not Assigned(fIBQuery.Transaction) then
    exit;
  if (not fWasOpen) and (fIBQuery.Transaction.InTransaction) then
    fIBQuery.Transaction.Commit;
end;

procedure TMultiQuery.IBOpenTrans;
begin
  if not Assigned(fIBQuery.Transaction) then
    exit;
  fWasOpen := fIBQuery.Transaction.InTransaction;
  if not fIBQuery.Transaction.InTransaction then
    fIBQuery.Transaction.StartTransaction;
end;

procedure TMultiQuery.IBRollbackTrans;
begin
  if not Assigned(fIBQuery.Transaction) then
    exit;
  if (not fWasOpen) and (fIBQuery.Transaction.InTransaction) then
    fIBQuery.Transaction.Commit;
end;


procedure TMultiQuery.MySqlCommitTrans;
begin
  if not Assigned(fFDQuery.Transaction) then
    exit;
  if (not fWasOpen) and (fFDQuery.Transaction.Active) then
    fFDQuery.Transaction.Commit;
end;

procedure TMultiQuery.MySqlOpenTrans;
begin
  if not Assigned(fFDQuery.Transaction) then
    exit;
  fWasOpen := fFDQuery.Transaction.Active;
  if not fFDQuery.Transaction.Active then
    fFDQuery.Transaction.StartTransaction;
end;

procedure TMultiQuery.MySqlRollbackTrans;
begin
  if not Assigned(fFDQuery.Transaction) then
    exit;
  if (not fWasOpen) and (fFDQuery.Transaction.Active) then
    fFDQuery.Transaction.Commit;
end;


procedure TMultiQuery.Next;
begin
  if fUseFirebird then
    fIBQuery.Next;
  if fUseMySql then
    fFDQuery.Next;
end;

function TMultiQuery.Eof: Boolean;
begin
  Result := true;
  if fUseFirebird then
    Result := fIBQuery.Eof;
  if fUseMySql then
    Result := fFDQuery.Eof;
end;


function TMultiQuery.FieldByName(const FieldName: string): TField;
begin
  Result := nil;
  if fUseFirebird then
    Result := fIBQuery.FieldByName(Fieldname);
  if fUseMySql then
    Result := fFDQuery.FieldByName(Fieldname);
end;

function TMultiQuery.ParamByName(const Value: string): TMultiQueryFeld;
begin
  Result := fMultiQueryFeldList.FieldByName(Value);
  if Result = nil then
  begin
    if fUseFirebird then
      Result := fMultiQueryFeldList.AddIB(fIBQuery.ParamByName(Value));
    if fUseMySql then
      Result := fMultiQueryFeldList.AddFD(fFDQuery.ParamByName(Value));
  end;
end;


end.
