unit DB.RezeptList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.Rezept, System.Contnrs, Objekt.MultiQuery;


type
  TDBRezeptList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBRezept;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBRezept read getItem;
    function Add: TDBRezept;
    procedure ReadAll;
  end;

implementation

{ TDBRezeptList }


constructor TDBRezeptList.Create;
begin
  inherited;

end;

destructor TDBRezeptList.Destroy;
begin

  inherited;
end;

function TDBRezeptList.getItem(Index: Integer): TDBRezept;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBRezept(fList.Items[Index]);
end;

procedure TDBRezeptList.ReadAll;
var
  x: TDBRezept;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Trans := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQLText := 'select * from rezept where rz_DELETE != ' + QuotedStr('T') +
                       ' order by rz_name';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBRezept.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;


function TDBRezeptList.Add: TDBRezept;
begin
  Result := TDBRezept.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


end.
