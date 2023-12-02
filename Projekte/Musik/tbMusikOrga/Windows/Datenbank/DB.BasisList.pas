unit DB.BasisList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.BasisList, IBX.IBQuery;

type
  TDBBasisList = class(TBasisList)
  private
  protected
    fTrans: TIBTransaction;
    fQuery: TIBQuery;
    fWasOpen: Boolean;
    procedure OpenTrans;
    procedure CommitTrans;
    procedure RollbackTrans;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Trans: TIBTransaction read fTrans write fTrans;
    procedure Clear; override;
  end;


implementation

{ TDBBasisList }

constructor TDBBasisList.Create;
begin
  inherited;
  fTrans := nil;
  fQuery := TIBQuery.Create(nil);
end;

destructor TDBBasisList.Destroy;
begin
  FreeAndNil(fQuery);
  inherited;
end;


procedure TDBBasisList.OpenTrans;
begin
  fTrans.StartTransaction;
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
