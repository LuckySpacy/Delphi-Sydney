unit DB.PhotoBaumList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.PhotoBaum, System.Contnrs;


type
  TDBPhotoBaumList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBPhotoBaum;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBPhotoBaum read getItem;
    function Add: TDBPhotoBaum;
    procedure ReadAll;
    procedure ReadAllParentUid(aUId: string);
    procedure DeleteFromList(aStrings: TStrings);
  end;

implementation

{ TDBPhotoBaumList }


constructor TDBPhotoBaumList.Create;
begin
  inherited;

end;


destructor TDBPhotoBaumList.Destroy;
begin

  inherited;
end;

function TDBPhotoBaumList.getItem(Index: Integer): TDBPhotoBaum;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBPhotoBaum(fList.Items[Index]);
end;

function TDBPhotoBaumList.Add: TDBPhotoBaum;
begin
  Result := TDBPhotoBaum.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


procedure TDBPhotoBaumList.ReadAll;
var
  x: TDBPhotoBaum;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Trans := fTrans;
  fQuery.Close;
  fQuery.OpenTrans;
  try
    fQuery.SQL.Text := 'select * from photobaum where pb_DELETE != ' + QuotedStr('T') +
                       ' order by pb_bez';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBPhotoBaum.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    fQuery.RollbackTrans;
  end;
end;

procedure TDBPhotoBaumList.ReadAllParentUid(aUId: string);
var
  x: TDBPhotoBaum;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Trans := fTrans;
  fQuery.Close;
  fQuery.OpenTrans;
  try
    fQuery.SQL.Text := 'select * from photobaum where pb_DELETE != ' + QuotedStr('T') +
                       ' and pb_parent_Uid = :parentUid' +
                       ' order by pb_bez';
    fQuery.ParamByName('parentUid').AsString := aUId;
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBPhotoBaum.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    fQuery.RollbackTrans;
  end;
end;

procedure TDBPhotoBaumList.DeleteFromList(aStrings: TStrings);
var
  i1: Integer;
begin
  fQuery.Close;
  fQuery.OpenTrans;
  try
    fQuery.SQL.Text := 'delete from photobaum where pb_id = :id';
    for i1 := 0 to aStrings.Count -1 do
    begin
      fQuery.ParamByName('id').AsInteger := StrToInt(Trim(aStrings[i1]));
      fQuery.ExecSQL;
    end;
  finally
    fQuery.CommitTrans;
  end;
end;


end.
