unit Datamodul.TSI;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
  FireDAC.Comp.UI, FireDAC.Comp.Client;

type
  Tdm = class(TDataModule)
    Database: TIBDatabase;
    IBT: TIBTransaction;
    db: TFDConnection;
    MySqlTrans: TFDTransaction;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    function Connect: Boolean;
    function ConnectMySql: Boolean;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.UITypes, Objekt.Global, Vcl.Dialogs, Objekt.Ini;




procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  if Global = nil then
  begin
    Global := TGlobal.Create(nil);
    Global.Trans := IBT;
  end;

  if Global.DatenbankServer > '' then
    Database.DatabaseName := Global.DatenbankServer + ':' +  Global.DatenbankFilename
  else
    Database.DatabaseName := Global.DatenbankFilename;

  //Database.DatabaseName := 'c:\temp\Datenbank\Passwortbrief.FDB';
  Database.Params.Clear;
  Database.Params.Add('user_name=sysdba');
  Database.Params.Add('password=masterkey');
  Database.LoginPrompt := false;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin //

end;

function Tdm.Connect: Boolean;
var
  lst: TStringList;
  Filename: string;
begin
  try
    Database.Connected := true;
  except
    on E: Exception do
    begin
      lst := TStringList.Create;
      try
        lst.Add('Databasename = ' + Database.DatabaseName);
        lst.Add(E.Message);
        Filename := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Error.txt';
        lst.SaveToFile(Filename);
      finally
        FreeAndNil(lst);
      end;
      MessageDlg(E.Message, mtError, [mbOk], 0);
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
