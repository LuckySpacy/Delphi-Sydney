unit Objekt.MultiTrans;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.DBFeldList, Data.db, IBX.IBQuery,
  vcl.Dialogs, Objekt.Allg, FireDAC.Comp.Client, FireDAC.DApt;

type
  TMultiTrans = class(TComponent)
  private
    fIBTransaction: TIBTransaction;
    fFDTransaction: TFDTransaction;
    fOpenZaehler: Integer;
    procedure setIBTransaction(const Value: TIBTransaction);
    procedure setFDTransaction(const Value: TFDTransaction);
    function getTrans: Pointer;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property IBTransaction: TIBTransaction read fIBTransaction write setIBTransaction;
    property FDTransaction: TFDTransaction read fFDTransaction write setFDTransaction;
    property Trans: Pointer read getTrans;
    procedure Start;
    procedure Commit;
    procedure Rollback;
    function IsIBTransaction: Boolean;
    function IsFDTransaction: Boolean;
  end;

implementation

{ TMultiTrans }


constructor TMultiTrans.Create(AOwner: TComponent);
begin
  inherited;
  fIBTransaction := nil;
  fFDTransaction := nil;
  fOpenZaehler := 0;
end;

destructor TMultiTrans.Destroy;
begin

  inherited;
end;


procedure TMultiTrans.setFDTransaction(const Value: TFDTransaction);
begin
  fFDTransaction := Value;
end;

procedure TMultiTrans.setIBTransaction(const Value: TIBTransaction);
begin
  fIBTransaction := Value
end;



function TMultiTrans.getTrans: Pointer;
begin
  Result := nil;
  if fFDTransaction <> nil then
    Result := fFDTransaction;
  if fIBTransaction <> nil then
    Result := fIBTransaction;
end;



function TMultiTrans.IsFDTransaction: Boolean;
begin
  Result := fFDTransaction <> nil;
end;

function TMultiTrans.IsIBTransaction: Boolean;
begin
  Result := fIBTransaction <> nil;
end;

procedure TMultiTrans.Start;
begin
  inc(fOpenZaehler);
  if fOpenZaehler > 1 then
    exit;

  if (fFDTransaction <> nil) then
  begin
    if fFDTransaction.Active then
      fFDTransaction.Rollback;
    fFDTransaction.StartTransaction;
  end;

  if fIBTransaction <> nil then
  begin
    if fIBTransaction.Active then
      fIBTransaction.Rollback;
    fIBTransaction.StartTransaction;
  end;
end;

procedure TMultiTrans.Commit;
begin
  dec(fOpenZaehler);
  if fOpenZaehler > 0 then
    exit;
  if fOpenZaehler < 0 then
    fOpenZaehler := 0;
  if (fFDTransaction <> nil) and (fFDTransaction.Active) then
    fFDTransaction.Commit;
  if (fIBTransaction <> nil) and (fIBTransaction.Active) then
    fIBTransaction.Commit;
end;

procedure TMultiTrans.Rollback;
begin
  dec(fOpenZaehler);
  if fOpenZaehler > 0 then
    exit;
  if fOpenZaehler < 0 then
    fOpenZaehler := 0;
  if (fFDTransaction <> nil) and (fFDTransaction.Active) then
    fFDTransaction.Rollback;
  if (fIBTransaction <> nil) and (fIBTransaction.Active) then
    fIBTransaction.Rollback;
end;



end.
