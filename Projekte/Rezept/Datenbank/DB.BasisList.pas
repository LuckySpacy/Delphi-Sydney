unit DB.BasisList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.BasisList, IBX.IBQuery,
  Objekt.MultiQuery, Objekt.MultiTrans;

type
  TDBBasisList = class(TBasisList)
  private
  protected
    fTrans: TMultiTrans;
    fQuery: TMultiQuery;
    fWasOpen: Boolean;
    procedure OpenTrans;
    procedure CommitTrans;
    procedure RollbackTrans;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Trans: TMultiTrans read fTrans write fTrans;
    procedure Clear; override;
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
  fTrans.Start;
  {
  fWasOpen := fTrans.InTransaction;
  if not fTrans.InTransaction then
    fTrans.StartTransaction;
  }
end;


procedure TDBBasisList.CommitTrans;
begin
  fTrans.Commit;

  {
  if (not fTrans.InTransaction) or (fWasOpen) then
    exit;
  fTrans.Commit;
  fWasOpen := false;
  }
end;



procedure TDBBasisList.RollbackTrans;
begin
  fTrans.Rollback;
  {
  if (not fTrans.InTransaction) or (fWasOpen) then
    exit;
  fTrans.Rollback;
  fWasOpen := false;
  }
end;


procedure TDBBasisList.Clear;
begin
  fList.Clear;
  inherited;
end;


end.
