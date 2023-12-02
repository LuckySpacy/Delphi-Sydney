unit DBObj.DateiformatList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery,  DBObj.Dateiformat, Objekt.BasisList,
  DBObj.BasisList, Vcl.StdCtrls, System.Contnrs;

type
  TDBDateiformatList = class(TBasisListDBObj)
  private
    function getItem(Index: Integer): TDBDateiformat;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReadAll;
    property Item[Index:Integer]: TDBDateiformat read getItem;
    procedure Delete;
  end;

implementation

{ TDBDateiformatList }



constructor TDBDateiformatList.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TDBDateiformatList.Destroy;
begin

  inherited;
end;


procedure TDBDateiformatList.Delete;
begin

end;


function TDBDateiformatList.getItem(Index: Integer): TDBDateiformat;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBDateiformat(fList.Items[Index]);
end;


procedure TDBDateiformatList.ReadAll;
var
  x: TDBDateiformat;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Close;
  fQuery.Transaction := fTrans;
  OpenTrans;
  try
    fQuery.SQL.Text := 'select * from dateiformat order by df_id';
    fquery.Open;
    while not fQuery.Eof do
    begin
      x := TDBDateiformat.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fquery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;

end.
