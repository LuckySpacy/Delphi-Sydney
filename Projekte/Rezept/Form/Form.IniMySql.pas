unit Form.IniMySql;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, nfsButton, Vcl.StdCtrls, Vcl.ExtCtrls,
  Datamodul.Bilder, Datamodul.Database, System.UITypes;

type
  Tfrm_IniMySql = class(TForm)
    pnl_Left_Datenbank: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnl_Client_Datenbank: TPanel;
    edt_Host: TEdit;
    edt_Port: TEdit;
    edt_Datenbankname: TEdit;
    edt_Username: TEdit;
    edt_Passwort: TEdit;
    btn_Check: TnfsButton;
    Panel1: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_CheckClick(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure Save;
  public
    { Public-Deklarationen }
  end;

var
  frm_IniMySql: Tfrm_IniMySql;

implementation

{$R *.dfm}

uses
  Objekt.Rezept;


procedure Tfrm_IniMySql.FormCreate(Sender: TObject);
begin
  edt_Host.Text          := Rezept.Ini.MySql.Host;
  edt_Datenbankname.Text := Rezept.Ini.MySql.Datenbankname;
  edt_Username.Text      := Rezept.Ini.MySql.Username;
  edt_Passwort.Text      := Rezept.Ini.MySql.Passwort;
  edt_Port.Text          := Rezept.Ini.MySql.Port;
end;

procedure Tfrm_IniMySql.FormDestroy(Sender: TObject);
begin //

end;

procedure Tfrm_IniMySql.Save;
begin
  Rezept.Ini.MySql.Host          := edt_Host.Text;
  Rezept.Ini.MySql.Datenbankname := edt_Datenbankname.Text;
  Rezept.Ini.MySql.Username      := edt_Username.Text;
  Rezept.Ini.MySql.Passwort      := edt_Passwort.Text;
  Rezept.Ini.MySql.Port          := edt_Port.Text;
end;


procedure Tfrm_IniMySql.btn_CheckClick(Sender: TObject);
begin
  save;

  dm.DB_MySql.Params.Clear;
  dm.DB_MySql.Params.Add('DriverID=MySQL');
  dm.DB_MySql.Params.Add('Server=' + Rezept.Ini.MySql.Host);
  dm.DB_MySql.Params.Add('Port=' + Rezept.Ini.MySql.Port);
  dm.DB_MySql.Params.Add('Database=' + Rezept.Ini.MySql.Datenbankname);
  dm.DB_MySql.Params.Add('User_Name=' + Rezept.Ini.MySql.Username);
  dm.DB_MySql.Params.Add('Password=' + Rezept.Ini.MySql.Passwort);
  dm.DB_MySql.Params.Add('CharacterSet=UTF8');
  dm.DB_MySql.Open;

end;


end.
