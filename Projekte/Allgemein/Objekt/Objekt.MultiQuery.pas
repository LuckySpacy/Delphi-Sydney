unit Objekt.MultiQuery;

interface
uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.DBFeldList, Data.db, IBX.IBQuery,
  vcl.Dialogs, Objekt.Allg, FireDAC.Comp.Client, Objekt.MultiQueryFeld,
  Objekt.MultiqueryFeldList, FireDAC.DApt, Objekt.MultiTrans;

type
  TMultiQuery = class(TComponent)
  private
    fIBQuery: TIBQuery;
    fFDQuery: TFDQuery;
    fUseFirebird: Boolean;
    fUseMySql: Boolean;
    fSqlText: string;
    fTrans: TMultiTrans;
    fWasOpen: Boolean;
    fMultiQueryFeldList: TMultiQueryFeldList;
    procedure setUseFirebird(const Value: Boolean);
    procedure setUseMySql(const Value: Boolean);
    procedure setSqlText(const Value: string);
    procedure setTrans(const Value: TMultiTrans);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property UseMySql: Boolean read fUseMySql write setUseMySql;
    property UseFirebird: Boolean read fUseFirebird write setUseFirebird;
    property Trans: TMultiTrans read fTrans write setTrans;
    property SqlText: string read fSqlText write setSqlText;
    procedure Close;
    procedure OpenTrans;
    procedure RollbackTrans;
    procedure CommitTrans;
    procedure Open;
    function Eof: Boolean;
    function FieldByName(const FieldName: string): TField;
    function ParamByName(const Value: string): TMultiQueryFeld;
    procedure setParamSize(const Value: string; aSize: Integer);
    function Fields: TFields;
    procedure Next;
    procedure ExecSql;
  end;

implementation

{ TMultiQuery }

uses
  Objekt.Global;



constructor TMultiQuery.Create(AOwner: TComponent);
begin
  inherited;
  fUseMySql := Global.UseMySql;
  fUseFirebird := Global.UseFireBird;
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

  if (not fUseFirebird) and (not fUseMySql) and (fTrans <> nil) then
  begin
    if fTrans.IsIBTransaction then
      fIBQuery.Sql.Text := fSqlText;
    if fTrans.IsFDTransaction then
      fFDQuery.SQL.Text := fSqlText;
  end;

  fMultiQueryFeldList.Clear;
end;



procedure TMultiQuery.setTrans(const Value: TMultiTrans);
begin
  fTrans := Value;
  if fTrans.IsIBTransaction then
    fIBQuery.Transaction := TIBTransaction(fTrans.Trans);

  if fTrans.IsFDTransaction then
  begin
    fFDQuery.Transaction := TFDTransaction(fTrans.Trans);
    fFDQuery.Connection  := fFDQuery.Transaction.Connection;
  end;

end;


procedure TMultiQuery.CommitTrans;
begin
  fTrans.Commit;
end;


procedure TMultiQuery.Open;
begin
  if fTrans.IsIBTransaction then
    fIBQuery.Open;
  if fTrans.IsFDTransaction then
    fFDQuery.Open;
end;

procedure TMultiQuery.OpenTrans;
begin
  fTrans.Start;
end;


procedure TMultiQuery.RollbackTrans;
begin
  fTrans.Rollback;
end;



procedure TMultiQuery.Next;
begin
  if fTrans.IsIBTransaction then
    fIBQuery.Next;
  if fTrans.IsFDTransaction then
    fFDQuery.Next;
end;

function TMultiQuery.Eof: Boolean;
begin
  Result := true;

  if fTrans.IsIBTransaction then
    Result := fIBQuery.Eof;
  if fTrans.IsFDTransaction then
    Result := fFDQuery.Eof;

end;


procedure TMultiQuery.ExecSql;
begin
  if fTrans.IsIBTransaction then
    fIBQuery.ExecSql;
  if fTrans.IsFDTransaction then
    fFDQuery.ExecSql;
end;

function TMultiQuery.FieldByName(const FieldName: string): TField;
begin
  Result := nil;
  if fTrans.IsIBTransaction then
    Result := fIBQuery.FieldByName(Fieldname);
  if fTrans.IsFDTransaction then
    Result := fFDQuery.FieldByName(Fieldname);
end;

function TMultiQuery.Fields: TFields;
begin
  Result := nil;
  if fTrans.IsIBTransaction then
    Result := fIBQuery.Fields;
  if fTrans.IsFDTransaction then
    Result := fFDQuery.Fields;
end;

function TMultiQuery.ParamByName(const Value: string): TMultiQueryFeld;
begin
  Result := fMultiQueryFeldList.FieldByName(Value);
  if Result = nil then
  begin
  if fTrans.IsIBTransaction then
      Result := fMultiQueryFeldList.AddIB(fIBQuery.ParamByName(Value));
  if fTrans.IsFDTransaction then
      Result := fMultiQueryFeldList.AddFD(fFDQuery.ParamByName(Value));
  end;
end;

procedure TMultiQuery.setParamSize(const Value: string; aSize: Integer);
begin
  if fUseMySql then
    fFDQuery.ParamByName(Value).size := aSize;
end;



end.
