unit Datamodul.Database;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Comp.UI, FireDAC.Phys.MySQL, Objekt.MultiTrans, Datasnap.DBClient;

type
  Tdm = class(TDataModule)
    IB_Rezept: TIBDatabase;
    IBT_Standard: TIBTransaction;
    DB_MySql: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    fTest: TList;
    fMultiTrans: TMultiTrans;
    fPasswort: string;
    fPort: Integer;
    fDatenbankpfad: string;
    fDatenbankname: string;
    fHost: string;
    fUsername: string;
    { Private-Deklarationen }
  public
    function CheckFirebird: Boolean;
    function getTrans: Pointer;
    property Host: string read fHost write fHost;
    property Port: Integer read fPort write fPort;
    property Datenbankname: string read fDatenbankname write fDatenbankname;
    property Datenbankpfad: string read fDatenbankpfad write fDatenbankpfad;
    property Username: string read fUsername write fUsername;
    property Passwort: string read fPasswort write fPasswort;
    procedure ConnectMySql;
    procedure ConnectFirebirdDB;
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

{ Tdm }

uses
 System.UITypes, VCL.Dialogs, Objekt.Rezept;



function Tdm.CheckFirebird: Boolean;
begin
  Result := true;
  IB_Rezept.Open;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  IB_Rezept.Params.Add('default character set UTF8');
  fTest := TList.Create;
  fMultiTrans := TMultiTrans.Create(nil);

  fPasswort      := '';
  fPort          := 0;
  fDatenbankpfad := '';
  fDatenbankname := '';
  fHost          := '';
  fUsername      := '';


//  IB_Rezept.params.Add('sql_role_name=UTF8');
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(fTest);
  FreeAndNil(fMultiTrans);
end;

function Tdm.getTrans: Pointer;
begin
  {
  Result := nil;
  if Rezept.UseFirebird then
    Result := dm.IBT_Standard;
  if Rezept.UseMySql then
    Result := dm.FDTransaction1;
  }
  if Rezept.UseFirebird then
    fMultiTrans.IBTransaction := ibt_Standard;
  if Rezept.UseMySql then
    fMultiTrans.FDTransaction := FDTransaction1;
  Result := fMultiTrans;
end;


procedure Tdm.ConnectMySql;
begin
  dm.DB_MySql.Params.Clear;
  dm.DB_MySql.Params.Add('DriverID=MySQL');
  dm.DB_MySql.Params.Add('Server=' + fHost);
  dm.DB_MySql.Params.Add('Port=' + IntToStr(fPort));
  dm.DB_MySql.Params.Add('Database=' + fDatenbankname);
  dm.DB_MySql.Params.Add('User_Name=' + fUsername);
  dm.DB_MySql.Params.Add('Password=' + fPasswort);
  dm.DB_MySql.Params.Add('CharacterSet=UTF8');

  try
    dm.DB_MySql.Open;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      MessageDlg('Verbindung zur Datenbank fehlgeschlagen', mtError, [mbOk], 0);
      exit;
    end;
  end;
end;

procedure Tdm.ConnectFirebirdDB;
begin
  dm.IB_Rezept.Databasename := Trim(fHost) +':' +
                               Trim(IncludeTrailingPathDelimiter(fDatenbankpfad)) +
                               Trim(fDatenbankname);
  dm.IB_Rezept.Params.Clear;
  dm.IB_Rezept.Params.Add('user_name=' + fUsername);
  dm.IB_Rezept.Params.Add('password=' + fPasswort);
  //dm.IB_Rezept.Params.Add('default character set UTF8');
  dm.IB_Rezept.Params.Add('lc_ctype=UTF8');

  dm.IB_Rezept.LoginPrompt := false;
  try
    dm.CheckFirebird;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      MessageDlg('Verbindung zur Datenbank fehlgeschlagen', mtError, [mbOk], 0);
      exit;
    end;
  end;
end;

end.
