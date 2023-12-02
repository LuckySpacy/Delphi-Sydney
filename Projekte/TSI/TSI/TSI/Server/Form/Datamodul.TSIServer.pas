unit Datamodul.TSIServer;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Comp.UI,
  FireDAC.Phys.MySQL;

type
  Tdm = class(TDataModule)
    DatabaseKurse: TIBDatabase;
    IBTKursex: TIBTransaction;
    DatabaseTSI: TIBDatabase;
    IBTTSI: TIBTransaction;
    IBQuery1: TIBQuery;
    db: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    MySqlTrans: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    fDBMySqlTSIConnectError: Boolean;
    fDBMySqlTSIConnectErrorMsg: string;
  public
    function ConnectKurse: Boolean;
    function ConnectTSI: Boolean;
    function ConnectMySql: Boolean;
    property DBMySqlTSIConnectError: Boolean read fDBMySqlTSIConnectError;
    property DBMySqlTSIConnectErrorMsg: string read fDBMySqlTSIConnectErrorMsg;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.UITypes, Objekt.Ini, Objekt.Protokoll;


{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  fDBMySqlTSIConnectError := false;
end;


function Tdm.ConnectKurse: Boolean;
var
  lst: TStringList;
  Filename: string;
begin
  if DatabaseKurse.Connected then
  begin
    Result := true;
    exit;
  end;
  DatabaseKurse.DatabaseName := Ini.Server + ':' + Ini.KurseFDB;
  DatabaseKurse.Params.Clear;
  DatabaseKurse.Params.Add('user_name=sysdba');
  DatabaseKurse.Params.Add('password=masterkey');
  DatabaseKurse.LoginPrompt := false;
  try
    DatabaseKurse.Connected := true;
  except
    on E: Exception do
    begin
      lst := TStringList.Create;
      try
        lst.Add('Databasename = ' + DatabaseKurse.DatabaseName);
        lst.Add(E.Message);
        Filename := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Error.txt';
        lst.SaveToFile(Filename);
      finally
        FreeAndNil(lst);
      end;
      Protokoll.write('Tdm.ConnectKurse', E.Message);
      Result := false;
      exit;
    end;
  end;
  Result := true;
end;


function Tdm.ConnectTSI: Boolean;
var
  lst: TStringList;
  Filename: string;
begin
  if DatabaseTSI.Connected then
  begin
    Result := true;
    exit;
  end;
  DatabaseTSI.DatabaseName := Ini.Server + ':' + Ini.TSIFDB;
  DatabaseTSI.Params.Clear;
  DatabaseTSI.Params.Add('user_name=sysdba');
  DatabaseTSI.Params.Add('password=masterkey');
  DatabaseTSI.LoginPrompt := false;
  try
    DatabaseTSI.Connected := true;
  except
    on E: Exception do
    begin
      lst := TStringList.Create;
      try
        lst.Add('Databasename = ' + DatabaseKurse.DatabaseName);
        lst.Add(E.Message);
        Filename := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Error.txt';
        lst.SaveToFile(Filename);
      finally
        FreeAndNil(lst);
      end;
      Protokoll.write('Tdm.ConnectKurse', E.Message);
      Result := false;
      exit;
    end;
  end;
  Result := true;
end;


function Tdm.ConnectMySql: Boolean;
begin
  Result := true;
  try
    db.Params.Clear;
    db.Params.Add('DriverID=MySQL');
    db.Params.Add('Server='+ Ini.MySql_Server);
    db.Params.Add('Port='+Ini.MySql_Server_Port);
    db.Params.Add('Database='+Ini.MySql_Server_DB);
    db.Params.Add('User_Name=' + Ini.MySql_Server_User);
    db.Params.Add('Password=' + Ini.MySql_Server_PW);
    db.Params.Add('CharacterSet=UTF8');
    db.Open;
  except
    Result := false;
  end;
end;



end.
