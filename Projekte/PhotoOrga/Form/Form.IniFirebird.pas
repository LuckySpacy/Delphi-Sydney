unit Form.IniFirebird;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.StdCtrls, Vcl.ExtCtrls,
  Datamodul.Database, System.UITypes, tbButton;

type
  Tfrm_IniFirebird = class(Tfrm_Base)
    Panel1: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Panel2: TPanel;
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
    btn_Check: TtbButton;
    btn_Datenbank_Leeren: TtbButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_CheckClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_Datenbank_LeerenxClick(Sender: TObject);
  private
    procedure Save;
  public
  end;

var
  frm_IniFirebird: Tfrm_IniFirebird;

implementation

{$R *.dfm}

uses
  Objekt.PhotoOrga;




procedure Tfrm_IniFirebird.FormCreate(Sender: TObject);
begin //
  inherited;
  edt_Host.Text          := PhotoOrga.Ini.Firebird.Host;
  edt_Datenbankpfad.Text := PhotoOrga.Ini.Firebird.Datenbankpfad;
  edt_Datenbankname.Text := PhotoOrga.Ini.Firebird.Datenbankname;
  edt_Username.Text      := PhotoOrga.Ini.Firebird.Username;
  edt_Passwort.Text      := PhotoOrga.Ini.Firebird.Passwort;
end;

procedure Tfrm_IniFirebird.FormDestroy(Sender: TObject);
begin //
  inherited;

end;


procedure Tfrm_IniFirebird.Save;
begin
  PhotoOrga.Ini.Firebird.Host          := edt_Host.Text;
  PhotoOrga.Ini.Firebird.Datenbankpfad := edt_Datenbankpfad.Text;
  PhotoOrga.Ini.Firebird.Datenbankname := edt_Datenbankname.Text;
  PhotoOrga.Ini.Firebird.Username      := edt_Username.Text;
  PhotoOrga.Ini.Firebird.Passwort      := edt_Passwort.Text;
end;

procedure Tfrm_IniFirebird.btn_CheckClick(Sender: TObject);
begin
  save;
  dm.IB_PhotoOrga.Databasename := Trim(PhotoOrga.Ini.Firebird.Host) +':' +
                               Trim(IncludeTrailingPathDelimiter(PhotoOrga.Ini.Firebird.Datenbankpfad)) +
                               Trim(PhotoOrga.Ini.Firebird.Datenbankname);
  dm.IB_PhotoOrga.Params.Clear;
  dm.IB_PhotoOrga.Params.Add('user_name=' + PhotoOrga.Ini.Firebird.Username);
  dm.IB_PhotoOrga.Params.Add('password=' + PhotoOrga.Ini.Firebird.Passwort);
  dm.IB_PhotoOrga.LoginPrompt := false;
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
  if dm.IB_PhotoOrga.connected then
    MessageDlg('Verbindung zur Datenbank konnte hergestellt werden.', mtInformation, [mbOk], 0);
end;


procedure Tfrm_IniFirebird.btn_Datenbank_LeerenxClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Möchtest du wirklich die Datenbank leeren?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;
  if MessageDlg('Ganz sicher?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;
end;

procedure Tfrm_IniFirebird.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  save;
end;



end.
