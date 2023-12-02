unit DB.PhotoUndBaumList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.PhotoUndBaum, System.Contnrs;


type
  TDBPhotoUndBaumList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBPhotoUndBaum;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBPhotoUndBaum read getItem;
    function Add: TDBPhotoUndBaum;
    procedure ReadAll(aPBUId: string);
    procedure ReadAllParentUid(aUId: string);
    procedure DeleteFromList(aStrings: TStrings);
  end;

implementation

{ TDBPhotoUndBaumList }


constructor TDBPhotoUndBaumList.Create;
begin
  inherited;

end;

procedure TDBPhotoUndBaumList.DeleteFromList(aStrings: TStrings);
begin

end;

destructor TDBPhotoUndBaumList.Destroy;
begin

  inherited;
end;

function TDBPhotoUndBaumList.getItem(Index: Integer): TDBPhotoUndBaum;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBPhotoUndBaum(fList.Items[Index]);
end;

function TDBPhotoUndBaumList.Add: TDBPhotoUndBaum;
begin
  Result := TDBPhotoUndBaum.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


procedure TDBPhotoUndBaumList.ReadAll(aPBUId: string);
var
  x: TDBPhotoUndBaum;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Trans := fTrans;
  fQuery.Close;
  fQuery.OpenTrans;
  try
    fQuery.SQL.Text := 'select * from photoundbaum' +
                       ' where pu_DELETE != ' + QuotedStr('T') +
                       ' and pu_pbuid = :pbuid' +
                       ' order by pb_bez';
    fQuery.ParamByName('pbuid').AsString := aPBUId;
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBPhotoUndBaum.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    fQuery.RollbackTrans;
  end;
end;

procedure TDBPhotoUndBaumList.ReadAllParentUid(aUId: string);
begin

end;

end.
