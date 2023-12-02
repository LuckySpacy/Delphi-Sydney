unit DB.PhotoList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.Photo, System.Contnrs;


type
  TDBPhotoList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBPhoto;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBPhoto read getItem;
    function Add: TDBPhoto;
    procedure ReadAll;
  end;

implementation

{ TDBPhotoList }


constructor TDBPhotoList.Create;
begin
  inherited;

end;

destructor TDBPhotoList.Destroy;
begin

  inherited;
end;

function TDBPhotoList.getItem(Index: Integer): TDBPhoto;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBPhoto(fList.Items[Index]);
end;

function TDBPhotoList.Add: TDBPhoto;
begin
  Result := TDBPhoto.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


procedure TDBPhotoList.ReadAll;
var
  x: TDBPhoto;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Trans := fTrans;
  fQuery.Close;
  fQuery.OpenTrans;
  try
    fQuery.SQL.Text := 'select * from photo where ph_DELETE != ' + QuotedStr('T') +
                       ' order by pb_id desc';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBPhoto.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    fQuery.RollbackTrans;
  end;
end;

end.
