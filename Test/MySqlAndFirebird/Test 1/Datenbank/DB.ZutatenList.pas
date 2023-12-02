unit DB.ZutatenList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.Zutaten, System.Contnrs;


type
  TDBZutatenList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBZutaten;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBZutaten read getItem;
    function Add: TDBZutaten;
    procedure ReadAll;
  end;

implementation

{ TDBZutatenList }


constructor TDBZutatenList.Create;
begin
  inherited;

end;

destructor TDBZutatenList.Destroy;
begin

  inherited;
end;

function TDBZutatenList.getItem(Index: Integer): TDBZutaten;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBZutaten(fList.Items[Index]);
end;

function TDBZutatenList.Add: TDBZutaten;
begin
  Result := TDBZutaten.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


procedure TDBZutatenList.ReadAll;
var
  x: TDBZutaten;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := 'select * from zutaten where zt_DELETE != ' + QuotedStr('T') +
                       ' order by zt_name';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBZutaten.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;

end.
