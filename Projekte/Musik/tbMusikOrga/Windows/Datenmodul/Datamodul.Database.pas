unit Datamodul.Database;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Comp.UI, FireDAC.Phys.MySQL, Datasnap.DBClient;

type
  Tdm = class(TDataModule)
    IB_MusikOrga: TIBDatabase;
    IBT_Standard: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    fPasswort: string;
    fPort: Integer;
    fDatenbankpfad: string;
    fDatenbankname: string;
    fHost: string;
    fUsername: string;
  public
    function CheckFirebird: Boolean;
    property Host: string read fHost write fHost;
    property Port: Integer read fPort write fPort;
    property Datenbankname: string read fDatenbankname write fDatenbankname;
    property Datenbankpfad: string read fDatenbankpfad write fDatenbankpfad;
    property Username: string read fUsername write fUsername;
    property Passwort: string read fPasswort write fPasswort;
    procedure Connect;
    procedure setEinstellung;
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

{ Tdm }

uses
 System.UITypes, VCL.Dialogs, Objekt.MusikOrga;



function Tdm.CheckFirebird: Boolean;
begin
  Result := true;
  IB_MusikOrga.Open;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  IB_MusikOrga.Params.Add('default character set UTF8');
  fPasswort      := '';
  fPort          := 0;
  fDatenbankpfad := '';
  fDatenbankname := '';
  fHost          := '';
  fUsername      := '';


//  IB_Rezept.params.Add('sql_role_name=UTF8');
end;

procedure Tdm.setEinstellung;
begin
  fHost := MusikOrga.Ini.Firebird.Host;
  fPort := 3050;
  fDatenbankpfad := MusikOrga.Ini.Firebird.Datenbankpfad;
  fDatenbankname := MusikOrga.Ini.Firebird.Datenbankname;
  fPasswort := MusikOrga.Ini.Firebird.Passwort;
  fUsername := MusikOrga.Ini.Firebird.Username;
end;

procedure Tdm.Connect;
begin
  dm.IB_MusikOrga.Databasename := Trim(fHost) +':' +
                               Trim(IncludeTrailingPathDelimiter(fDatenbankpfad)) +
                               Trim(fDatenbankname);
  dm.IB_MusikOrga.Params.Clear;
  dm.IB_MusikOrga.Params.Add('user_name=' + fUsername);
  dm.IB_MusikOrga.Params.Add('password=' + fPasswort);
  //dm.IB_Rezept.Params.Add('default character set UTF8');
  dm.IB_MusikOrga.Params.Add('lc_ctype=UTF8');

  dm.IB_MusikOrga.LoginPrompt := false;
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
