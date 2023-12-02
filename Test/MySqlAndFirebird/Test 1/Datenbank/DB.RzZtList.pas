unit DB.RzZtList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.RzZt, System.Contnrs;


type
  TDBRzZtList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBRzZt;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBRzZt read getItem;
    function Add: TDBRzZt;
    procedure ReadAll(aRzId: Integer);
  end;

implementation

{ TDBRzZtList }


constructor TDBRzZtList.Create;
begin
  inherited;

end;

destructor TDBRzZtList.Destroy;
begin

  inherited;
end;

function TDBRzZtList.getItem(Index: Integer): TDBRzZt;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBRzZt(fList.Items[Index]);
end;

function TDBRzZtList.Add: TDBRzZt;
begin
  Result := TDBRzZt.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


procedure TDBRzZtList.ReadAll(aRzId: Integer);
var
  x: TDBRzZt;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' select * from RzZt ' +
                       ' join zutatenlistenname on rl_zl_id = zl_id' +
                       ' where rl_DELETE != ' + QuotedStr('T') +
                       ' and rl_rz_id = ' + IntToStr(aRzId);

    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBRzZt.Create(nil);
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
