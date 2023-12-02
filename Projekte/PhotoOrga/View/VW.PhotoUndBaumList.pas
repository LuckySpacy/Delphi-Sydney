unit VW.PhotoUndBaumList;

interface


uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  VW.PhotoUndBaum, System.Contnrs;


type
  TVWPhotoUndBaumList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TVWPhotoUndBaum;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TVWPhotoUndBaum read getItem;
    function Add: TVWPhotoUndBaum;
    procedure Read(aPBUId: string);
  end;

implementation

{ TVWPhotoUndBaumList }

uses
  Datamodul.Database, Objekt.Types;


constructor TVWPhotoUndBaumList.Create;
begin
  inherited;

end;

destructor TVWPhotoUndBaumList.Destroy;
begin

  inherited;
end;

function TVWPhotoUndBaumList.getItem(Index: Integer): TVWPhotoUndBaum;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TVWPhotoUndBaum(fList.Items[Index]);
end;


function TVWPhotoUndBaumList.Add: TVWPhotoUndBaum;
begin
  Result := TVWPhotoUndBaum.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;

procedure TVWPhotoUndBaumList.Read(aPBUId: string);
var
  x: TVWPhotoUndBaum;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Trans := fTrans;
  fQuery.Close;
  fQuery.OpenTrans;
  try
    fQuery.SQL.Text := 'select * from photoundbaum' +
                       ' join photo on PH_UID = pu_phuid' +
                       ' where Pu_DELETE != :del' +
                       ' and   pu_pbuid = :pbuid';
    fQuery.ParamByName('pbuid').AsString := aPBUId;
    fQuery.ParamByName('del').AsString := 'T';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TVWPhotoUndBaum.Create(nil);
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
