unit DB.RezeptZutatenlist;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.RezeptZutaten, System.Contnrs;


type
  TDBRezeptzutatenList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBRezeptZutaten;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBRezeptZutaten read getItem;
    function Add: TDBRezeptZutaten;
    procedure ReadAll(aRzId, aZlId: Integer);
    procedure ReadAllVonZlId(aZlId: Integer);
  end;

implementation

{ TDBRezeptzutatenList }


constructor TDBRezeptzutatenList.Create;
begin
  inherited;

end;

destructor TDBRezeptzutatenList.Destroy;
begin

  inherited;
end;

function TDBRezeptzutatenList.getItem(Index: Integer): TDBRezeptZutaten;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBRezeptZutaten(fList.Items[Index]);
end;

function TDBRezeptzutatenList.Add: TDBRezeptZutaten;
begin
  Result := TDBRezeptZutaten.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


procedure TDBRezeptzutatenList.ReadAll(aRzId, aZlId: Integer);
var
  x: TDBRezeptZutaten;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Trans := fTrans;
  fQuery.Close;
  fQuery.OpenTrans;
  try
    fQuery.SQLText := ' select * from rezeptzutaten ' +
                      ' left outer join zutaten on zt_id = rt_zt_id' +
                      ' where rt_DELETE != ' + QuotedStr('T') +
                      ' and   rt_rz_id = ' + IntToStr(aRzId) +
                      ' and   rt_zl_id = ' + IntToStr(aZlId) +
                      ' order by rt_name';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBRezeptZutaten.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    fQuery.RollbackTrans;
  end;
end;

procedure TDBRezeptzutatenList.ReadAllVonZlId(aZlId: Integer);
var
  x: TDBRezeptZutaten;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Trans := fTrans;
  fQuery.Close;
  fQuery.OpenTrans;
  try
    fQuery.SQLText := ' select * from rezeptzutaten ' +
                      ' left outer join zutaten on zt_id = rt_zt_id' +
                      ' where rt_DELETE != ' + QuotedStr('T') +
                      ' and   rt_zl_id = ' + IntToStr(aZlId) +
                      ' order by rt_name';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBRezeptZutaten.Create(nil);
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
