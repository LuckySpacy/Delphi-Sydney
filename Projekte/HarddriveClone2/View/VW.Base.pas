unit VW.Base;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.DBFeldList, Data.db, IBX.IBQuery,
  vcl.Dialogs;

type
  TVWBasis = class(TComponent)
  private
    procedure setTrans(const Value: TIBTransaction);
  protected
    fTrans: TIBTransaction;
    fQuery: TIBQuery;
    fId: Integer;
    fUpdate: string;
    fDelete: string;
    fFeldList: TDBFeldList;
    fGefunden: Boolean;
    fWasOpen: Boolean;
    fNeu: Boolean;
    fGeloescht: Boolean;
    procedure FuelleDBFelder; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; virtual;
    procedure OpenTrans;
    procedure CommitTrans;
    procedure RollbackTrans;
    procedure LoadByQuery(aQuery: TIBQuery); virtual;
    property Id: Integer read fId;
    property Trans: TIBTransaction read fTrans write setTrans;
    property FeldList: TDBFeldList read fFeldList write fFeldList;
    property Gefunden: Boolean read fGefunden;
  end;


implementation

{ TVWBasis }

uses
  Objekt.DBFeld;


constructor TVWBasis.Create(AOwner: TComponent);
begin
  inherited;
  fTrans := nil;
  fWasOpen := false;
  fQuery := TIBQuery.Create(nil);
  fFeldList := TDBFeldList.Create;
  fFeldList.Tablename := '';
  fFeldList.PrimaryKey := '';
  fFeldList.TablePrefix := '';
end;

destructor TVWBasis.Destroy;
begin
  FreeAndNil(fQuery);
  FreeAndNil(fFeldList);
  inherited;
end;



procedure TVWBasis.FuelleDBFelder;
begin

end;

procedure TVWBasis.Init;
begin

end;

procedure TVWBasis.LoadByQuery(aQuery: TIBQuery);
var
  i1: Integer;
  DBFeld: TDBFeld;
begin
  fFeldList.Clear;
  for i1 := 0 to aQuery.Fields.Count -1 do
  begin
    DBFeld := fFeldList.Add(aQuery.Fields[i1].Name, aQuery.Fields[i1].DataType);
    DBFeld.AsString := aQuery.Fields[i1].AsString;
  end;
end;

procedure TVWBasis.OpenTrans;
begin
  fWasOpen := fTrans.InTransaction;
  if not fTrans.InTransaction then
    fTrans.StartTransaction;
end;

procedure TVWBasis.RollbackTrans;
begin
  if (not fWasOpen) and (fTrans.InTransaction) then
    fTrans.Commit;
end;

procedure TVWBasis.CommitTrans;
begin
  if (not fWasOpen) and (fTrans.InTransaction) then
    fTrans.Commit;
end;


procedure TVWBasis.setTrans(const Value: TIBTransaction);
begin
  fTrans := Value;
end;

end.
