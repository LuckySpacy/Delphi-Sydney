unit Form.IniFirebird;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, nfsButton,
  Datamodul.Bilder, Datamodul.Database, System.UITypes;

type
  Tfrm_IniFirebird = class(TForm)
    pnl_Left_Datenbank: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnl_Client_Datenbank: TPanel;
    edt_Host: TEdit;
    edt_Datenbankpfad: TEdit;
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
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_CheckClick(Sender: TObject);
  private
  public
    procedure Save;
  end;

var
  frm_IniFirebird: Tfrm_IniFirebird;

implementation

{$R *.dfm}

uses
  Objekt.MusikOrga;


procedure Tfrm_IniFirebird.FormCreate(Sender: TObject);
begin //
  edt_Host.Text          := MusikOrga.Ini.Firebird.Host;
  edt_Datenbankpfad.Text := MusikOrga.Ini.Firebird.Datenbankpfad;
  edt_Datenbankname.Text := MusikOrga.Ini.Firebird.Datenbankname;
  edt_Username.Text      := MusikOrga.Ini.Firebird.Username;
  edt_Passwort.Text      := MusikOrga.Ini.Firebird.Passwort;
end;

procedure Tfrm_IniFirebird.FormDestroy(Sender: TObject);
begin //

end;

procedure Tfrm_IniFirebird.FormShow(Sender: TObject);
begin //
end;

procedure Tfrm_IniFirebird.Save;
begin
  MusikOrga.Ini.Firebird.Host          := edt_Host.Text;
  MusikOrga.Ini.Firebird.Datenbankpfad := edt_Datenbankpfad.Text;
  MusikOrga.Ini.Firebird.Datenbankname := edt_Datenbankname.Text;
  MusikOrga.Ini.Firebird.Username      := edt_Username.Text;
  MusikOrga.Ini.Firebird.Passwort      := edt_Passwort.Text;
end;


procedure Tfrm_IniFirebird.btn_CheckClick(Sender: TObject);
begin
  save;
  dm.IB_MusikOrga.Databasename := Trim(MusikOrga.Ini.Firebird.Host) +':' +
                               Trim(IncludeTrailingPathDelimiter(MusikOrga.Ini.Firebird.Datenbankpfad)) +
                               Trim(MusikOrga.Ini.Firebird.Datenbankname);
  dm.IB_MusikOrga.Params.Clear;
  dm.IB_MusikOrga.Params.Add('user_name=' + MusikOrga.Ini.Firebird.Username);
  dm.IB_MusikOrga.Params.Add('password=' + MusikOrga.Ini.Firebird.Passwort);
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
  if dm.IB_MusikOrga.connected then
    MessageDlg('Verbindung zur Datenbank konnte hergestellt werden.', mtInformation, [mbOk], 0);
end;

procedure Tfrm_IniFirebird.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  save;
end;

end.
