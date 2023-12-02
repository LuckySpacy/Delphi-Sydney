unit DB.Basis;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.DBFeldList, Data.db, IBX.IBQuery,
  vcl.Dialogs, Objekt.Allg, FireDAC.Comp.Client;

type
  TDBBasis = class(TComponent)
  private
    fOnAfterExecSql: TNotifyEvent;
    fOnNewTransaction: TNotifyEvent;
    procedure FuelleHistorieDBFelder;
    procedure setTrans(const Value: TIBTransaction);
  protected
    fTrans: TIBTransaction;
    fQuery: TIBQuery;
    fId: Integer;
    fUpdate: string;
    fDelete: string;
    fDoUpdate: Boolean;
    fFeldList: TDBFeldList;
    fFeldListHis: TDBFeldList;
    fGefunden: Boolean;
    fWasOpen: Boolean;
    //fTransCounter: Integer;
    fNeu: Boolean;
    fAllg: TAllg;
    fGeloescht: Boolean;
    function getGeneratorName: string; virtual; abstract;
    function getTableName: string; virtual; abstract;
    function getTablePrefix: string; virtual; abstract;
    procedure UpdateV(var aOldValue: string; aNewValue: string); overload;
    procedure UpdateV(var aOldValue: Integer; aNewValue: Integer); overload;
    procedure UpdateV(var aOldValue: Boolean; aNewValue: Boolean); overload;
    procedure UpdateV(var aOldValue: TDateTime; aNewValue: TDateTime); overload;
    procedure UpdateV(var aOldValue: extended; aNewValue: extended; aNachkomma: integer); overload;
    procedure UpdateV(var aOldValue: double; aNewValue: double; aNachkomma: integer); overload;
    procedure UpdateV(var aOldValue: real; aNewValue: real; aNachkomma: integer); overload;
    procedure LegeHistorieFelderAn;
    procedure FuelleDBFelder; virtual;
    property OnAfterExecSql: TNotifyEvent read fOnAfterExecSql write fOnAfterExecSql;
    property OnNewTransaction: TNotifyEvent read fOnNewTransaction write fOnNewTransaction;
    function ReadLastId: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; virtual;
    procedure OpenTrans;
    procedure CommitTrans;
    procedure RollbackTrans;
    procedure LoadByQuery(aQuery: TIBQuery); virtual;
    property Id: Integer read fId;
    property Trans: TIBTransaction read fTrans write setTrans;
    property FeldList: TDBFeldList read fFeldList write fFeldList;
    property Gefunden: Boolean read fGefunden;
    procedure Read(aId: Integer); virtual;
    function Delete: Boolean; virtual;
    procedure SaveToDB; virtual;
    function GenerateId: Integer;
  end;

implementation

uses
  System.UITypes, Math;

constructor TDBBasis.Create(AOwner: TComponent);
begin
  inherited;
  fAllg  := TAllg.Create;
  fTrans := nil;
  fWasOpen := false;
  //fTransCounter := 0;
  fQuery := TIBQuery.Create(nil);
  fFeldList := TDBFeldList.Create;
  fFeldList.Tablename := getTableName;
  fFeldList.PrimaryKey := getTablePrefix+'_ID';
  fFeldList.TablePrefix := getTablePrefix;
  fFeldList.Add(getTablePrefix+'_ID', ftInteger);
  fFeldList.Add(getTablePrefix+'_UPDATE', ftString);
  fFeldList.Add(getTablePrefix+'_DELETE', ftString);

  fFeldListHis := TDBFeldList.Create;

end;

destructor TDBBasis.Destroy;
begin
  FreeAndNil(fQuery);
  FreeAndNil(fFeldList);
  FreeAndNil(fFeldListHis);
  FreeAndNil(fAllg);
  inherited;
end;


function TDBBasis.GenerateId: Integer;
begin
  Result := 0;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Transaction := fTrans;
  fQuery.SQL.Text := 'select GEN_ID(' + getGeneratorName + ', 1) FROM RDB$DATABASE';
  OpenTrans;
  try
    fQuery.Open;
    Result := fQuery.Fields[0].AsInteger;
    fQuery.Close;
  finally
    CommitTrans;
  end;
end;


procedure TDBBasis.Init;
begin
  fId := 0;
  fGeloescht := false;
  fGefunden := false;
  fDoUpdate := false;
  fUpdate := 'T';
  fDelete := 'F';
end;

procedure TDBBasis.LegeHistorieFelderAn;
var
  i1: Integer;
begin
  fFeldListHis.Clear;
  for i1 := 0 to fFeldList.Count -1 do
    fFeldListHis.Add(fFeldList.Feld[i1].Feldname, ftString);
end;

procedure TDBBasis.FuelleDBFelder;
begin
  fFeldList.FieldByName(getTablePrefix+'_UPDATE').AsString := fUpdate;
  fFeldList.FieldByName(getTablePrefix+'_DELETE').AsString := fDelete;
  fFeldList.FieldByName(getTablePrefix+'_ID').AsInteger    := fId;
  FuelleHistorieDBFelder;
end;


procedure TDBBasis.FuelleHistorieDBFelder;
var
  i1: Integer;
begin
  if fFeldListHis.Count <> fFeldList.Count then
    exit;
  for i1 := 0 to fFeldList.Count -1 do
    fFeldListHis.FieldByName(fFeldList.Feld[i1].Feldname).AsString := fFeldList.Feld[i1].AsString;
end;

procedure TDBBasis.LoadByQuery(aQuery: TIBQuery);
begin
  Init;
  fGefunden := not aQuery.Eof;
  if aQuery.Eof then
    exit;
  fId := aQuery.FieldByName(getTablePrefix+'_ID').AsInteger;
  fUpdate := aQuery.FieldByName(getTablePrefix+'_UPDATE').AsString;
  fDelete := aQuery.FieldByName(getTablePrefix+'_DELETE').AsString;
end;



function TDBBasis.Delete: Boolean;
begin
  Result := false;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Transaction := fTrans;
  fQuery.SQL.Text := fFeldList.DeleteStatement;
  OpenTrans;
  try
    fQuery.ExecSQL;
    fGeloescht := true;
    if Assigned(fOnAfterExecSql) then
      fOnAfterExecSql(nil);
  except
    on E: Exception do
    begin
      RollbackTrans;
      MessageDlg(E.Message, mtError, [mbOk], 0);
      raise;
      exit;
    end;
  end;
  Result := true;
  CommitTrans;
end;


procedure TDBBasis.OpenTrans;
begin
  fWasOpen := fTrans.InTransaction;
  if not fTrans.InTransaction then
    fTrans.StartTransaction;
end;


procedure TDBBasis.CommitTrans;
begin
  if (not fWasOpen) and (fTrans.InTransaction) then
    fTrans.Commit;
end;


procedure TDBBasis.RollbackTrans;
begin
  if (not fWasOpen) and (fTrans.InTransaction) then
    fTrans.Rollback;
end;


procedure TDBBasis.SaveToDB;
var
  Sql: string;
begin
  if not Assigned(fTrans) then
    exit;
  if (not fDoUpdate) and (fId > 0) then
    exit;
  fNeu := false;
  fDoUpdate := false;
  fGeloescht := false;
  if fId = 0 then
  begin
    if TObject(fTrans) is TIBTransaction then
      fid := GenerateId;
    fFeldList.FieldByName(getTablePrefix + '_ID').AsInteger := fId;
    fFeldList.FieldByName(getTablePrefix+'_UPDATE').AsString := fUpdate;
    fFeldList.FieldByName(getTablePrefix+'_DELETE').AsString := fDelete;
    if TObject(fTrans) is TIBTransaction then
      Sql := fFeldList.InsertStatement_Interbase;
    fNeu:= true;
  end
  else
    Sql := fFeldList.UpdateStatement;

  fQuery.Close;
  fQuery.Transaction := fTrans;
  fQuery.SQL.Text := Sql;

  OpenTrans;
  try
    fQuery.ExecSQL;
    if fId = 0 then
    begin
      fId := ReadLastId;
      fFeldList.FieldByName(getTablePrefix + '_ID').AsInteger := fId;
    end;

    if Assigned(fOnAfterExecSql) then
      fOnAfterExecSql(nil);
  except
    on E: Exception do
    begin
      RollbackTrans;
      MessageDlg(E.Message, mtError, [mbOk], 0);
      raise;
      exit;
    end;
  end;
  CommitTrans;
  FuelleHistorieDBFelder;
  fFeldList.SetChangedToAll(false);
end;


function TDBBasis.ReadLastId: Integer;
begin
  fQuery.Close;
  fQuery.Sql.Text := ' select ' + fFeldList.PrimaryKey + ' from ' + fFeldList.Tablename + ' order by ' + fFeldList.PrimaryKey + ' desc';

  OpenTrans;
  fQuery.Open;
  Result := fQuery.Fields[0].AsInteger;
  fQuery.Close;
  RollbackTrans;
end;


procedure TDBBasis.setTrans(const Value: TIBTransaction);
begin
  fTrans := Value;
  if Assigned(fOnNewTransaction) then
    fOnNewTransaction(nil);
end;

procedure TDBBasis.UpdateV(var aOldValue: Boolean; aNewValue: Boolean);
begin
  if not fDoUpdate then
    fDoUpdate := aOldValue <> aNewValue;
  aOldValue := aNewValue;
end;

procedure TDBBasis.UpdateV(var aOldValue: Integer; aNewValue: Integer);
begin
  if not fDoUpdate then
    fDoUpdate := aOldValue <> aNewValue;
  aOldValue := aNewValue;
end;

procedure TDBBasis.UpdateV(var aOldValue: string; aNewValue: string);
begin
  if not fDoUpdate then
    fDoUpdate := aOldValue <> aNewValue;
  aOldValue := aNewValue;
end;

procedure TDBBasis.UpdateV(var aOldValue: TDateTime; aNewValue: TDateTime);
begin
  if not fDoUpdate then
    fDoUpdate := aOldValue <> aNewValue;
  aOldValue := aNewValue;
end;

procedure TDBBasis.UpdateV(var aOldValue: extended; aNewValue: extended; aNachkomma: integer);
begin
  if not fDoUpdate then
    fDoUpdate := fAllg.VergleichFloatValue(aOldValue, aNewValue, aNachkomma) <> 0;
//    fDoUpdate := aOldValue <> aNewValue;
  aOldValue := aNewValue;
end;

procedure TDBBasis.UpdateV(var aOldValue: double; aNewValue: double; aNachkomma: integer);
begin
  if not fDoUpdate then
    fDoUpdate := fAllg.VergleichFloatValue(aOldValue, aNewValue, aNachkomma) <> 0;
  aOldValue := aNewValue;
end;


procedure TDBBasis.UpdateV(var aOldValue: real; aNewValue: real; aNachkomma: integer);
begin
  if not fDoUpdate then
    fDoUpdate := fAllg.VergleichFloatValue(aOldValue, aNewValue, aNachkomma) <> 0;
  aOldValue := aNewValue;
end;

procedure TDBBasis.Read(aId: Integer);
begin
  Init;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Transaction := fTrans;
  fQuery.SQL.Text := 'select * from ' + getTableName + ' where ' + getGeneratorName + '=' + IntToStr(aId);
  OpenTrans;
  try
    fQuery.Open;
    LoadByQuery(fQuery);
  finally
    CommitTrans;
  end;
end;

end.
