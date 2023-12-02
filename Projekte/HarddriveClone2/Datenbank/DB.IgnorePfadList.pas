unit DB.IgnorePfadList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.IgnorePfad, System.Contnrs;


type
  TDBIgnorePfadList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBIgnorePfad;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBIgnorePfad read getItem;
    function Add: TDBIgnorePfad;
    procedure ReadAll(aJoId: Integer);
  end;

implementation

{ TDBIgnorePfadList }


constructor TDBIgnorePfadList.Create;
begin
  inherited;

end;

destructor TDBIgnorePfadList.Destroy;
begin

  inherited;
end;

function TDBIgnorePfadList.getItem(Index: Integer): TDBIgnorePfad;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBIgnorePfad(fList.Items[Index]);
end;

function TDBIgnorePfadList.Add: TDBIgnorePfad;
begin
  Result := TDBIgnorePfad.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


procedure TDBIgnorePfadList.ReadAll(aJoId: Integer);
var
  x: TDBIgnorePfad;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := 'select * from ignorepfad' +
                       ' where ig_DELETE != ' + QuotedStr('T') +
                       ' and ig_jo_id = ' + IntToStr(aJoId) +
                       ' order by ig_pfadname';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBIgnorePfad.Create(nil);
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
