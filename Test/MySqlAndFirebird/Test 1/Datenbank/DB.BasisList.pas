unit DB.BasisList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.BasisList, IBX.IBQuery,
  Objekt.MultiQuery;


type
  TDBBasisList = class(TBasisList)
  private
    fUseFirebird: Boolean;

    fUseMySql: Boolean;    procedure setTrans(const Value: Pointer);

    procedure setUseFirebird(const Value: Boolean);
    procedure setUseMySql(const Value: Boolean);protected
    fTrans: Pointer;
    fQuery: TMultiQuery;
    fWasOpen: Boolean;
    procedure OpenTrans;
    procedure CommitTrans;
    procedure RollbackTrans;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Trans: Pointer read fTrans write setTrans;
    procedure Clear; override;
    property UseMySql: Boolean read fUseMySql write setUseMySql;
    property UseFirebird: Boolean read fUseFirebird write setUseFirebird;
  end;


implementation

{ TDBBasisList }

constructor TDBBasisList.Create;
begin
  inherited;
  fTrans := nil;
  fQuery := TMultiQuery.Create(nil);
end;

destructor TDBBasisList.Destroy;
begin
  FreeAndNil(fQuery);
  inherited;
end;


procedure TDBBasisList.OpenTrans;
begin
  fQuery.OpenTrans;
  {
  fWasOpen := fTrans.InTransaction;
  if not fTrans.InTransaction then
    fTrans.StartTransaction;
    }
end;


procedure TDBBasisList.CommitTrans;
begin
  fQuery.CommitTrans;
  {
  if (not fTrans.InTransaction) or (fWasOpen) then
    exit;
  fTrans.Commit;
  fWasOpen := false;
  }
end;



procedure TDBBasisList.RollbackTrans;
begin
  fQuery.RollbackTrans;
  {
  if (not fTrans.InTransaction) or (fWasOpen) then
    exit;
  fTrans.Rollback;
  fWasOpen := false;
  }
end;


procedure TDBBasisList.setTrans(const Value: Pointer);
begin
  fTrans := Value;
  fQuery.Trans := fTrans;
end;

procedure TDBBasisList.setUseFirebird(const Value: Boolean);
begin
  fUseFirebird := Value;
  if Value then
    fUseMySql := false;
  fQuery.UseFirebird := value;
end;

procedure TDBBasisList.setUseMySql(const Value: Boolean);
begin
  fUseMySql := Value;
  if Value then
    fUseFirebird := false;
  fQuery.UseMySql := Value;
end;

procedure TDBBasisList.Clear;
begin
  fList.Clear;
  inherited;
end;


end.
