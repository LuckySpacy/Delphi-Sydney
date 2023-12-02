unit DB.RzZt;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db,
  DB.Zutatenlistenname, Objekt.MultiQuery;

type
  TDBRzZt = class(TDBBasis)
  private
    fRZId: Integer;
    fZLId: Integer;
    fZutatenlistenname: string;
    fDBZutatenlistenname: TDBZutatenlistenname;
    procedure setRZId(const Value: Integer);
    procedure setZLId(const Value: Integer);
    procedure setZutatenlistenname(const Value: string);
    procedure ReadZutatenlistenname;
    procedure NewTransaction(Sender: TObject);
  protected
    function getGeneratorName: string; override;
    function getTableName: string; override;
    function getTablePrefix: string; override;
    //function getTableId: Integer; override;
    procedure FuelleDBFelder; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure LoadByQuery(aQuery: TMultiQuery); override;
    procedure SaveToDB; override;
    property RZ_ID: Integer read fRZId write setRZId;
    property ZL_ID: Integer read fZLId write setZLId;
    property Zutatenlistenname: string read fZutatenlistenname write setZutatenlistenname;
    function Delete: Boolean; override;
    procedure Read(aRz_Id, aZlId: Integer); reintroduce; overload;
  end;

implementation

{ TDBRezept }




constructor TDBRzZt.Create(AOwner: TComponent);
begin
  inherited;
  fDBZutatenlistenname := TDBZutatenlistenname.Create(nil);
  FFeldList.Add('RL_RZ_ID', ftInteger);
  FFeldList.Add('RL_ZL_ID', ftInteger);
  OnNewTransaction := NewTransaction;
  LegeHistorieFelderAn;
  Init;
end;

destructor TDBRzZt.Destroy;
begin
  FreeAndNil(fDBZutatenlistenname);
  inherited;
end;


procedure TDBRzZt.Init;
begin
  inherited;
  fRZId := 0;
  fZLId := 0;
  fZutatenlistenname := 'Zutaten';
  FuelleDBFelder;
end;

function TDBRzZt.getGeneratorName: string;
begin
  Result := 'RL_ID';
end;

function TDBRzZt.getTableName: string;
begin
  Result := 'RZZT';
end;

function TDBRzZt.getTablePrefix: string;
begin
  Result := 'RL';
end;

procedure TDBRzZt.FuelleDBFelder;
begin
  fFeldList.FieldByName('RL_ID').AsInteger  := fID;
  fFeldList.FieldByName('RL_RZ_ID').AsInteger := fRZID;
  fFeldList.FieldByName('RL_ZL_ID').AsInteger := fZLID;
  inherited;
end;


procedure TDBRzZt.LoadByQuery(aQuery: TMultiQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fRZID   := aQuery.FieldByName('RL_RZ_ID').AsInteger;
  fZLID   := aQuery.FieldByName('RL_ZL_ID').AsInteger;
  fZutatenlistenname := aQuery.FieldByName('ZL_NAME').AsString;
  FuelleDBFelder;
end;


procedure TDBRzZt.NewTransaction(Sender: TObject);
begin
  fDBZutatenlistenname.Trans := fTrans;
end;


procedure TDBRzZt.SaveToDB;
begin
  if fZlId = 0 then
  begin
    fDBZutatenlistenname.Init;
    fDBZutatenlistenname.ZutatenName := fZutatenlistenname;
    fDBZutatenlistenname.SaveToDB;
    ZL_ID := fDBZutatenlistenname.Id;
  end;
  inherited;
  ReadZutatenlistenname;
  fDBZutatenlistenname.SaveToDB;
end;

function TDBRzZt.Delete: Boolean;
begin
  Result := Inherited;
  ReadZutatenlistenname;
  fDBZutatenlistenname.Delete;
end;



procedure TDBRzZt.setRZId(const Value: Integer);
begin
  UpdateV(fRZID, Value);
  fFeldList.FieldByName('RL_RZ_ID').AsInteger := Value;
end;

procedure TDBRzZt.setZLId(const Value: Integer);
begin
  UpdateV(fZLID, Value);
  fFeldList.FieldByName('RL_ZL_ID').AsInteger := Value;
end;



procedure TDBRzZt.setZutatenlistenname(const Value: string);
begin
  ReadZutatenlistenname;
  fZutatenlistenname := Value;
  fDBZutatenlistenname.ZutatenName := fZutatenlistenname;
end;

procedure TDBRzZt.Read(aRz_Id, aZlId: Integer);
begin
  Init;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Trans := fTrans;
  fQuery.SQLText := 'select * from ' + getTableName +
                    ' join zutatenlistenname on rl_zl_id = zl_id' +
                    ' where RL_DELETE != ' + quotedStr('T') +
                    ' and   RL_RZ_ID = ' + IntToStr(aRz_Id) +
                    ' and   RL_ZL_ID = ' + IntToStr(aZlId);
  OpenTrans;
  try
    fQuery.Open;
    LoadByQuery(fQuery);
  finally
    CommitTrans;
  end;
end;


procedure TDBRzZt.ReadZutatenlistenname;
begin
  if fZlId = 0 then
  begin
    fDBZutatenlistenname.Init;
    exit;
  end;

  if fDBZutatenlistenname.Id <> fZLId then
    fDBZutatenlistenname.Read(fZlId);
end;

end.
