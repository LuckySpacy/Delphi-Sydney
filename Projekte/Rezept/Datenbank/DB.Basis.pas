unit DB.Basis;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.DBFeldList, Data.db, IBX.IBQuery,
  vcl.Dialogs, Objekt.Allg, Objekt.MultiQuery, FireDAC.Comp.Client;

type
  TDBBasis = class(TComponent)
  private
    fOnAfterExecSql: TNotifyEvent;
    fOnNewTransaction: TNotifyEvent;
    procedure FuelleHistorieDBFelder;
    procedure setTrans(const Value: Pointer);
  protected
    fTrans: Pointer;
    fQuery: TMultiquery;
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
    procedure UpdateStatment_MySql(aQry: TMultiQuery);
    procedure InsertStatement_MySql(aQry: TMultiQuery);
    function ReadLastId: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; virtual;
    procedure OpenTrans;
    procedure CommitTrans;
    procedure RollbackTrans;
    procedure LoadByQuery(aQuery: TMultiQuery); virtual;
    property Id: Integer read fId;
    property Trans: Pointer read fTrans write setTrans;
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
  fQuery := TMultiquery.Create(nil);
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
  fQuery.Trans := fTrans;
  fQuery.SQLText := 'select GEN_ID(' + getGeneratorName + ', 1) FROM RDB$DATABASE';
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

procedure TDBBasis.LoadByQuery(aQuery: TMultiQuery);
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
  fQuery.Trans := fTrans;
  fQuery.SQLText := fFeldList.DeleteStatement;
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
  fQuery.OpenTrans;
  {
  fWasOpen := fTrans.InTransaction;
  if not fTrans.InTransaction then
    fTrans.StartTransaction;
  }
end;


procedure TDBBasis.CommitTrans;
begin
  fQuery.CommitTrans;
  {
  if (not fWasOpen) and (fTrans.InTransaction) then
    fTrans.Commit;
   }
end;


procedure TDBBasis.RollbackTrans;
begin
  fQuery.RollbackTrans;
  {
  if (not fWasOpen) and (fTrans.InTransaction) then
    fTrans.Commit;
    }
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
  fQuery.Trans := fTrans;

  if TObject(fTrans) is TIBTransaction then
    fQuery.SQLText := Sql
  else
  begin
    if fId = 0 then
      InsertStatement_MySql(fQuery)
    else
      UpdateStatment_MySql(fQuery);;
  end;

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


procedure TDBBasis.UpdateStatment_MySql(aQry: TMultiQuery);
var
  s: string;
  sql: string;
  i1: Integer;
  Id: Integer;
  Mem: TMemoryStream;
  List: TStringList;
begin
  Id := 0;
  sql := 'update ' + fFeldList.Tablename + ' set ';
  s := '';
  for i1 := 0 to fFeldList.Count -1 do
  begin
    if SameText(fFeldList.PrimaryKey, fFeldList.Feld[i1].Feldname) then
    begin
      Id := fFeldList.Feld[i1].AsInteger;
      continue;
    end;
    if i1 < fFeldList.Count -1 then
      s := ', '
    else
      s := '';

    sql := sql + fFeldList.Feld[i1].Feldname + '= :' + fFeldList.Feld[i1].Feldname + s;
  end;
  aQry.SqlText := sql + s + ' where ' + fFeldList.PrimaryKey + '=' + IntToStr(Id);
  for i1 := 0 to fFeldList.Count -1 do
  begin
    if SameText(fFeldList.PrimaryKey, fFeldList.Feld[i1].Feldname) then
      continue;
    if fFeldList.Feld[i1].DataType = ftBlob then
    begin
      List := TStringList.Create;
      List.Text := fFeldList.Feld[i1].AsString;
      Mem := TMemoryStream.Create;
      List.SaveToStream(Mem);
      //Mem.Position := 0;
      //mem.SaveToFile('d:\Bachmann\Daten\OneDrive\Asus-PC-2018\Programmierung\Delphi\Sydney\Projekte\Datenbank\MySql\Test.rtf');
      Mem.Position := 0;
      //aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsString := '';
      aQry.ParamByName(fFeldList.Feld[i1].Feldname).LoadFromStream(Mem, ftBlob, -1);
      FreeAndNil(Mem);
      FreeAndNil(List);
      continue;
    end;
    if (fFeldList.Feld[i1].DataType = ftDateTime) then
      aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsDateTime := fFeldList.Feld[i1].AsDateTime
    else
      if (fFeldList.Feld[i1].DataType = ftString) or (fFeldList.Feld[i1].DataType = ftBoolean) then
        aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsString := fFeldList.Feld[i1].AsString
      else
        if (fFeldList.Feld[i1].DataType = ftInteger) then
          aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsInteger := fFeldList.Feld[i1].AsInteger
        else
          if (fFeldList.Feld[i1].DataType = ftFloat) then
            aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsFloat := fFeldList.Feld[i1].AsFloat
          else
            aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsString := fFeldList.Feld[i1].AsString;

  end;
end;

procedure TDBBasis.InsertStatement_MySql(aQry: TMultiQuery);
var
  s: string;
  i1: Integer;
  Mem: TMemoryStream;
  List: TStringList;
begin
  s := '';

  for i1 := 0 to fFeldList.Count -1 do
  begin
    if SameText(fFeldList.PrimaryKey, fFeldList.Feld[i1].Feldname) then
      continue;
    s := s + fFeldList.Feld[i1].Feldname + ', ';
  end;
  s := copy(s, 1, Length(s)-2);
  s := 'Insert into ' + fFeldList.Tablename + ' (' + s;
  s := s + ') values (';
  for i1 := 0 to fFeldList.Count -1 do
  begin
    if SameText(fFeldList.PrimaryKey, fFeldList.Feld[i1].Feldname) then
      continue;
    s := s + ':' + fFeldList.Feld[i1].Feldname + ', ';
  end;
  s := copy(s, 1, Length(s)-2) + ')';

  aqry.SqlText := s;
  for i1 := 0 to fFeldList.Count -1 do
  begin
    if SameText(fFeldList.PrimaryKey, fFeldList.Feld[i1].Feldname) then
      continue;
    if fFeldList.Feld[i1].DataType = ftBlob then
    begin
      List := TStringList.Create;
      List.Text := fFeldList.Feld[i1].AsString;
      Mem := TMemoryStream.Create;
      List.SaveToStream(Mem);
      Mem.Position := 0;
      aQry.ParamByName(fFeldList.Feld[i1].Feldname).LoadFromStream(Mem, ftBlob, -1);
      FreeAndNil(Mem);
      FreeAndNil(List);
      continue;
    end;
    if (fFeldList.Feld[i1].DataType = ftDateTime) then
      aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsDateTime := fFeldList.Feld[i1].AsDateTime
    else
      if (fFeldList.Feld[i1].DataType = ftString) or (fFeldList.Feld[i1].DataType = ftBoolean) then
        aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsString := fFeldList.Feld[i1].AsString
      else
        if (fFeldList.Feld[i1].DataType = ftInteger) then
          aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsInteger := fFeldList.Feld[i1].AsInteger
        else
          if (fFeldList.Feld[i1].DataType = ftFloat) then
            aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsFloat := fFeldList.Feld[i1].AsFloat
          else
            aQry.ParamByName(fFeldList.Feld[i1].Feldname).AsString := fFeldList.Feld[i1].AsString;

  end;

end;


function TDBBasis.ReadLastId: Integer;
begin
  fQuery.Close;
  fQuery.SqlText := ' select ' + fFeldList.PrimaryKey + ' from ' + fFeldList.Tablename + ' order by ' + fFeldList.PrimaryKey + ' desc';

  OpenTrans;
  fQuery.Open;
  Result := fQuery.Fields[0].AsInteger;
  fQuery.Close;
  RollbackTrans;
end;


procedure TDBBasis.setTrans(const Value: Pointer);
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
  fQuery.Trans := fTrans;
  fQuery.SQLText := 'select * from ' + getTableName + ' where ' + getGeneratorName + '=' + IntToStr(aId);
  OpenTrans;
  try
    fQuery.Open;
    LoadByQuery(fQuery);
  finally
    CommitTrans;
  end;
end;

end.
