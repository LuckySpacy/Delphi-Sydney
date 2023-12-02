unit VW.Base;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.DBFeldList, Data.db, DB.TBQuery,
  db.TBTransaction, vcl.Dialogs;

type
  TVWBasis = class(TComponent)
  private
    procedure setTrans(const Value: TTBTransaction);
  protected
    fTrans: TTBTransaction;
    fQuery: TTBQuery;
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
    procedure LoadByQuery(aQuery: TTBQuery); virtual;
    property Id: Integer read fId;
    property Trans: TTBTransaction read fTrans write setTrans;
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
  fQuery := TTBQuery.Create(nil);
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

procedure TVWBasis.LoadByQuery(aQuery: TTBQuery);
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




procedure TVWBasis.setTrans(const Value: TTBTransaction);
begin
  fTrans := Value;
end;

end.
