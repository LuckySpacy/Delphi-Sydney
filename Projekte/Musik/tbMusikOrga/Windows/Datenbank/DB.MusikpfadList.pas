unit DB.MusikpfadList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.Musikpfad, System.Contnrs;


type
  TDBMusikpfadList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBMusikpfad;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBMusikpfad read getItem;
    function Add: TDBMusikpfad;
    procedure ReadAll;
  end;

implementation

{ TDBMusikpfadList }


constructor TDBMusikpfadList.Create;
begin
  inherited;

end;

destructor TDBMusikpfadList.Destroy;
begin

  inherited;
end;

function TDBMusikpfadList.Add: TDBMusikpfad;
begin
  Result := TDBMusikpfad.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


function TDBMusikpfadList.getItem(Index: Integer): TDBMusikpfad;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBMusikpfad(fList.Items[Index]);
end;


procedure TDBMusikpfadList.ReadAll;
var
  x: TDBMusikpfad;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := 'select * from musikpfad where mp_DELETE != ' + QuotedStr('T') +
                       ' order by mp_pfad';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBMusikpfad.Create(nil);
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
