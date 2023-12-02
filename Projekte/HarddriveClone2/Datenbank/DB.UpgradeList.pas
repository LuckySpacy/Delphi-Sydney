unit DB.UpgradeList;

interface

uses
  SysUtils, System.Classes, DB.BasisList, DB.Upgrade, Firedac.Stan.Param;

type
  TDBUpgradeList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TDBUpgrade;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index: Integer]: TDBUpgrade read getItem;
    function Add: TDBUpgrade;
    procedure ReadAll;
    procedure CreateIfNotExist;
    function DoUpgrade: Boolean;
  end;


implementation

{ TDBUpgradeList }

uses
  dm.Datenbank;




constructor TDBUpgradeList.Create;
begin
  inherited;
end;


destructor TDBUpgradeList.Destroy;
begin
  inherited;
end;


function TDBUpgradeList.getItem(Index: Integer): TDBUpgrade;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDBUpgrade(fList.Items[Index]);
end;

function TDBUpgradeList.Add: TDBUpgrade;
begin
  Result := TDBUpgrade.Create(nil);
  fList.Add(Result);
end;



procedure TDBUpgradeList.ReadAll;
var
  DBUprade: TDBUpgrade;
begin
  fQuery.Close;
  fQuery.Sql.Text := 'select * from upgrade order by up_datum';
  try
    fQuery.Open;
  except
    on E: Exception do
    begin
      //BasCloud.Log('          Error: ' + E.Message);
    end;
  end;
  fList.Clear;
  while not fQuery.Eof do
  begin
    DBUprade := Add;
    DBUprade.Trans := fTrans;
    DBUprade.LoadByQuery(fQuery);
    fQuery.Next;
  end;
end;


procedure TDBUpgradeList.CreateIfNotExist;
begin
  fQuery.Close;
  fQuery.Transaction.StartTransaction;
  fQuery.SQL.Text := 'select 1 from rdb$relations where rdb$relation_name = :Tabelle';
  fQuery.ParamByName('Tabelle').AsString := 'UPGRADE';
    fQuery.Open;
  if not fQuery.Eof then
    exit;

  fQuery.sql.Clear;
  fQuery.Sql.Add('CREATE TABLE UPGRADE (');
  fQuery.Sql.Add('up_id INTEGER NOT NULL,');
  fQuery.Sql.Add('up_datum       VARCHAR (14),');
  fQuery.Sql.Add('UP_UPDATE CHAR(1) CHARACTER SET UTF8  COLLATE UTF8,');
  fQuery.Sql.Add('UP_DELETE CHAR(1) CHARACTER SET UTF8  COLLATE UTF8,');
  fQuery.Sql.Add('CONSTRAINT PK_UP_ID PRIMARY KEY (up_id))');
  try
    fQuery.ExecSQL;
  except
    fQuery.Transaction.Rollback;
  end;
  fQuery.SQL.Clear;
  fQuery.SQL.Add('CREATE SEQUENCE UP_ID');
  try
    fQuery.ExecSQL;
  except
    fQuery.Transaction.Rollback;
  end;
  fQuery.Transaction.Commit;
end;


function TDBUpgradeList.DoUpgrade: Boolean;
var
  DBUpgrade: TDBUpgrade;
  LastUpdate: string;
  WurdeAktualisiert: Boolean;
begin
  Result := false;
  WurdeAktualisiert := false;
  fQuery.Transaction := fTrans;
  CreateIfNotExist;
  DBUpgrade := TDBUpgrade.Create(nil);
  try
    DBUpgrade.Trans := fTrans;
    LastUpdate := DBUpgrade.LastUpdate;
    if LastUpdate = '' then
    begin
      WurdeAktualisiert := true;
      if not fQuery.Transaction.InTransaction then
        fQuery.Transaction.StartTransaction;
      fQuery.SQL.Text := 'alter table ignorepfad add IG_EXAKTPFAD CHAR(1) CHARACTER SET UTF8  COLLATE UTF8';
      try
        fQuery.ExecSQL;
      except
        if fQuery.Transaction.InTransaction then
          fQuery.Transaction.Rollback;
      end;
    end;
    if fQuery.Transaction.InTransaction then
    begin
      fQuery.Transaction.Commit;
      Result := true;
      if not WurdeAktualisiert then
        Result := false;
    end;
  finally
    FreeAndNil(DBUpgrade);
  end;

end;


end.
