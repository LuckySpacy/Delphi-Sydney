unit DB.DateiList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  DB.Datei, System.Contnrs;


type
  TDBDateiList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBDatei;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TDBDatei read getItem;
    function Add: TDBDatei;
    procedure ReadAll(aJoId: Integer);
    function CountChangedDatumNotToday(aJoId: Integer): Integer;
    function CountFiles(aJoId: Integer): Integer;
    procedure ResetChangeDatumForAll;
    procedure ResetChangeDatumFor(aJoId: Integer);
    function PfadExist(aPfad: string): Boolean;
    function ReadPfadList(aPfad: string): Boolean;
  end;

implementation

{ TDBDateiList }


uses
  DateUtils;


constructor TDBDateiList.Create;
begin
  inherited;

end;

destructor TDBDateiList.Destroy;
begin

  inherited;
end;

function TDBDateiList.getItem(Index: Integer): TDBDatei;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBDatei(fList.Items[Index]);
end;


function TDBDateiList.Add: TDBDatei;
begin
  Result := TDBDatei.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;

procedure TDBDateiList.ReadAll(aJoId: Integer);
var
  x: TDBDatei;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := 'select * from datei' +
                       ' where da_DELETE != ' + QuotedStr('T') +
                       ' order by da_datei';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TDBDatei.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;


function TDBDateiList.CountChangedDatumNotToday(aJoId: Integer): Integer;
begin
  fQuery.Close;
  fQuery.Transaction := fTrans;
  fQuery.SQL.Text := ' select count(*) ' +
                     ' from datei ' +
                     ' inner join jobdatei on jd_da_id = da_id and jd_jo_id = :JoId' +
                     ' where da_delete != :delete ' +
                     ' and da_changedatum < :changedatum';
  fQuery.ParamByName('delete').AsString := 'T';
  fQuery.ParamByName('changedatum').AsDateTime :=  StartOfTheDay(now);
  fQuery.ParamByName('JoId').AsInteger :=  aJoId;
  OpenTrans;
  fQuery.Open;
  Result := fQuery.Fields[0].AsInteger;
  fQuery.Close;
  RollbackTrans;
end;

function TDBDateiList.CountFiles(aJoId: Integer): Integer;
begin
  fQuery.Close;
  fQuery.Transaction := fTrans;
  fQuery.SQL.Text := ' select count(*) ' +
                     ' from datei ' +
                     ' inner join jobdatei on jd_da_id = da_id and jd_jo_id = :JoId' +
                     ' where da_delete != :delete ';
  fQuery.ParamByName('delete').AsString := 'T';
  fQuery.ParamByName('JoId').AsInteger := aJoId;
  OpenTrans;
  fQuery.Open;
  Result := fQuery.Fields[0].AsInteger;
  fQuery.Close;
  RollbackTrans;
end;

procedure TDBDateiList.ResetChangeDatumForAll;
begin
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' update datei set da_changedatum = :changedatum' +
                       ' where da_DELETE != ' + QuotedStr('T');
    fQuery.ParamByName('changedatum').AsDateTime := StrToDate('01.01.1970');
    fQuery.ExecSQL;
  finally
    CommitTrans;
  end;
end;


procedure TDBDateiList.ResetChangeDatumFor(aJoId: Integer);
var
  qry: TIBQuery;
begin
  if fTrans = nil then
    exit;
  qry := TIBQuery.Create(nil);
  try
    qry.Transaction := fTrans;
    fQuery.Transaction := fTrans;
    fQuery.Close;
    OpenTrans;
    try
      qry.SQL.Text := ' select da_id from datei ' +
                      ' inner join jobdatei on jd_da_id = da_id and jd_jo_id = ' + IntToStr(aJoId);
      qry.Open;
      fQuery.SQL.Text := ' update datei set da_changedatum = :changedatum' +
                         ' where da_DELETE != ' + QuotedStr('T') +
                         ' and   da_Id = :id';
      fQuery.Prepare;
      while not qry.Eof do
      begin
        fQuery.ParamByName('changedatum').AsDateTime := StrToDate('01.01.1970');
        fQuery.ParamByName('id').AsInteger := qry.FieldByName('da_id').AsInteger;
        fQuery.ExecSQL;
        qry.Next;
      end;

    finally
      fQuery.UnPrepare;
      CommitTrans;
    end;
  finally
    FreeAndNil(qry);
  end;
end;


function TDBDateiList.PfadExist(aPfad: string): Boolean;
var
  CheckPfad: string;
begin
  fQuery.Transaction := fTrans;
  OpenTrans;
  try
    aPfad := IncludeTrailingPathDelimiter(LowerCase(aPfad));
    fQuery.Sql.Text := 'select da_id, da_datei from datei where lower(da_datei) like :Pfad';
    fQuery.ParamByName('Pfad').AsString := aPfad + '%';
    fQuery.Open;
    Result := false;
    while not fQuery.Eof do
    begin
      CheckPfad := IncludeTrailingPathDelimiter(LowerCase(ExtractFilePath(fQuery.FieldByName('da_datei').AsString)));
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


function TDBDateiList.ReadPfadList(aPfad: string): Boolean;
var
  CheckPfad: string;
  x : TDBDatei;
begin
  fList.Clear;
  fQuery.Transaction := fTrans;
  OpenTrans;
  try
    aPfad := IncludeTrailingPathDelimiter(LowerCase(aPfad));
    fQuery.Sql.Text := 'select * from datei where lower(da_datei) like :Pfad';
    fQuery.ParamByName('Pfad').AsString := aPfad + '%';
    fQuery.Open;
    Result := false;
    while not fQuery.Eof do
    begin
      CheckPfad := IncludeTrailingPathDelimiter(LowerCase(ExtractFilePath(fQuery.FieldByName('da_datei').AsString)));
      if CheckPfad = aPfad then
      begin
        x := TDBDatei.Create(nil);
        x.Trans := fTrans;
        x.LoadByQuery(fQuery);
        fList.Add(x);
      end;
      fQuery.Next;
    end;
    Result := not fQuery.Eof;
  finally
    CommitTrans;
  end;
end;



end.
