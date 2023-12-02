unit DB.JobDateiList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.JobDatei, System.Contnrs;


type
  TDBJobDateiList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBJobDatei;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBJobDatei read getItem;
    function Add: TDBJobDatei;
    procedure ReadAll;
    procedure ReadJob(aJoId: Integer);
    procedure ReadJobAndChangedDatum(aJoId: Integer; aChangedDatum: TDateTime);
    function AnzahlDateien(aJobId: Integer): Integer;
    procedure ResetChangeDatumForAll;
    procedure ResetChangeDatumFor(aJoId: Integer);
    function PfadExist(aPfad: string): Boolean;
  end;

implementation

{ TDBJobDateiList }



constructor TDBJobDateiList.Create;
begin
  inherited;

end;

destructor TDBJobDateiList.Destroy;
begin

  inherited;
end;

function TDBJobDateiList.getItem(Index: Integer): TDBJobDatei;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBJobDatei(fList.Items[Index]);
end;

function TDBJobDateiList.Add: TDBJobDatei;
begin
  Result := TDBJobDatei.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


procedure TDBJobDateiList.ReadAll;
var
  x: TDBJobDatei;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := 'select * from jobdatei where jd_DELETE != ' + QuotedStr('T') +
                       ' order by jd_datei desc';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBJobDatei.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;

procedure TDBJobDateiList.ReadJob(aJoId: Integer);
var
  x: TDBJobDatei;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' select * from jobdatei' +
                       ' where jd_DELETE != ' + QuotedStr('T') +
                       ' and jd_jo_id = ' + IntToStr(aJoId) +
                       ' order by jd_datei desc';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBJobDatei.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;

procedure TDBJobDateiList.ReadJobAndChangedDatum(aJoId: Integer; aChangedDatum: TDateTime);
var
  x: TDBJobDatei;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' select * from jobdatei' +
                       ' where jd_DELETE != ' + QuotedStr('T') +
                       ' and jd_jo_id = ' + IntToStr(aJoId) +
                       ' and jd_changedatum < :changedatum' +
                       ' order by jd_datei desc';
    fQuery.ParamByName('changedatum').AsDateTime := aChangedDatum;
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBJobDatei.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;

procedure TDBJobDateiList.ResetChangeDatumForAll;
begin
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' update jobdatei set jd_changedatum = :changedatum' +
                       ' where jd_DELETE != ' + QuotedStr('T');
    fQuery.ParamByName('changedatum').AsDateTime := StrToDate('01.01.1970');
    fQuery.ExecSQL;
  finally
    CommitTrans;
  end;
end;

procedure TDBJobDateiList.ResetChangeDatumFor(aJoId: Integer);
begin
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' update jobdatei set jd_changedatum = :changedatum' +
                       ' where jd_DELETE != ' + QuotedStr('T') +
                       ' and jd_jo_id = ' + IntToStr(aJoId);
    fQuery.ParamByName('changedatum').AsDateTime := StrToDate('01.01.1970');
    fQuery.ExecSQL;
  finally
    CommitTrans;
  end;
end;


function TDBJobDateiList.AnzahlDateien(aJobId: Integer): Integer;
begin
  Result := 0;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' select count(*) from jobdatei' +
                       ' where jd_DELETE != ' + QuotedStr('T') +
                       ' and   jd_jo_id = ' + IntToStr(aJobId);
    fQuery.Open;
    Result := fQuery.Fields[0].AsInteger;
    fQuery.Close;
  finally
    RollbackTrans;
  end;
end;


function TDBJobDateiList.PfadExist(aPfad: string): Boolean;
var
  CheckPfad: string;
begin
  fQuery.Transaction := fTrans;
  OpenTrans;
  try
    aPfad := IncludeTrailingPathDelimiter(LowerCase(aPfad));
    fQuery.Sql.Text := 'select jd_id, jd_datei from jobdatei where lower(jd_datei) like :Pfad';
    fQuery.ParamByName('Pfad').AsString := aPfad + '%';
    fQuery.Open;
    Result := false;
    while not fQuery.Eof do
    begin
      CheckPfad := IncludeTrailingPathDelimiter(LowerCase(ExtractFilePath(fQuery.FieldByName('jd_datei').AsString)));
      if CheckPfad = aPfad then
      begin
        Result := true;
        exit;
      end;
      fQuery.Next;
    end;
    Result := not fQuery.Eof;
  finally
    CommitTrans;
  end;
end;



end.
