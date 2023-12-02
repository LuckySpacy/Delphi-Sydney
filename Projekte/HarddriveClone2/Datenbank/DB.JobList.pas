unit DB.JobList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.Job, System.Contnrs;


type
  TDBJobList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBJob;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBJob read getItem;
    function Add: TDBJob;
    procedure ReadAll;
    procedure ReadAll_Aktiv;
  end;

implementation

{ TDBJobList }


constructor TDBJobList.Create;
begin
  inherited;

end;

destructor TDBJobList.Destroy;
begin

  inherited;
end;

function TDBJobList.getItem(Index: Integer): TDBJob;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBJob(fList.Items[Index]);
end;

function TDBJobList.Add: TDBJob;
begin
  Result := TDBJob.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;



procedure TDBJobList.ReadAll;
var
  x: TDBJob;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := 'select * from job where jo_DELETE != ' + QuotedStr('T') +
                       ' order by jo_prio desc';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBJob.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;


procedure TDBJobList.ReadAll_Aktiv;
var
  x: TDBJob;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' select * from job'+
                       ' where jo_DELETE != ' + QuotedStr('T') +
                       ' and jo_aktiv = ' + QuotedStr('T') +
                       ' order by jo_prio desc';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBJob.Create(nil);
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
