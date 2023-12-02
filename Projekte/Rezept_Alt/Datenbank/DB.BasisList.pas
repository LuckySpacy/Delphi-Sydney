unit DB.BasisList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.BasisList, FireDAC.Comp.Client;

type
  TDBBasisList = class(TBaseList)
  private
  protected
    fTrans: TFDTransaction;
    fQuery: TFDQuery;
    fWasOpen: Boolean;
    procedure OpenTrans;
    procedure CommitTrans;
    procedure RollbackTrans;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Trans: TFDTransaction read fTrans write fTrans;
    procedure Clear;
  end;


implementation

{ TDBBasisList }

constructor TDBBasisList.Create(AOwner: TComponent);
begin
  inherited;
  fTrans := nil;
  fQuery := TFDQuery.Create(nil);
end;

destructor TDBBasisList.Destroy;
begin
  FreeAndNil(fQuery);
  inherited;
end;


procedure TDBBasisList.OpenTrans;
begin
  fWasOpen := fTrans.Connection.InTransaction;
  if not fTrans.Connection.InTransaction then
    fTrans.Connection.StartTransaction;
end;


procedure TDBBasisList.CommitTrans;
begin
  if (not fTrans.Connection.InTransaction) or (fWasOpen) then
    exit;
  fTrans.Connection.Commit;
  fWasOpen := false;
end;



procedure TDBBasisList.RollbackTrans;
begin
  if (not fTrans.Connection.InTransaction) or (fWasOpen) then
    exit;
  fTrans.Rollback;
  fWasOpen := false;
end;


procedure TDBBasisList.Clear;
begin
  fList.Clear;
end;


end.
