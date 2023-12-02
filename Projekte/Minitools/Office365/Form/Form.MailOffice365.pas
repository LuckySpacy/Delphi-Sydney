unit Form.MailOffice365;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Objekt.Ini;

type
  Tfrm_MailOffice365 = class(TForm)
    PageControl1: TPageControl;
    tbs_Mail: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    edt_Betreff: TEdit;
    edt_An: TEdit;
    edt_CC: TEdit;
    edt_BCC: TEdit;
    Panel4: TPanel;
    btn_Senden: TButton;
    mem_Body: TMemo;
    tbs_Einstellung: TTabSheet;
    Panel5: TPanel;
    Edt_SMTP: TEdit;
    Edt_User: TEdit;
    Edt_Passwort: TEdit;
    edt_Port: TEdit;
    cbo_TLS: TComboBox;
    cbo_AuthType: TComboBox;
    cbo_SSLVersion: TComboBox;
    edt_AbsMail: TEdit;
    Panel6: TPanel;
    Label192: TLabel;
    Label193: TLabel;
    Label5: TLabel;
    lbl_MailPort: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label6: TLabel;
    Panel7: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SendenClick(Sender: TObject);
  private
    fIni: TNfIni;
    fIniFilename: string;
    fPath: string;
    procedure MailSenden;
  public
  end;

var
  frm_MailOffice365: Tfrm_MailOffice365;

implementation

{$R *.dfm}

uses
  Types.Mail, Objekt.Mail;


procedure Tfrm_MailOffice365.FormCreate(Sender: TObject);
var
  i1: Integer;
begin
  fIni := TNfIni.Create;
  fPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  fIniFilename := fPath + 'Mailtest.Ini';

  cbo_TLS.Items.clear;
  for i1 := 0 to c_UstTLSMax do
    cbo_TLS.Items.Add(c_UseTLS[i1].Text);

  cbo_AuthType.Items.Clear;
  for i1 := 0 to c_AuthTypeMax do
    cbo_AuthType.Items.Add(c_AuthType[i1].Text);

  cbo_SSLVersion.Items.Clear;
  for i1 := 0 to c_SSLVersionMax do
    cbo_SSLVersion.Items.Add(c_SSLVersion[i1].Text);

end;

procedure Tfrm_MailOffice365.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fIni);
end;

procedure Tfrm_MailOffice365.FormShow(Sender: TObject);
begin
  edt_An.Text      := fIni.ReadIni(fIniFilename, 'Mail', 'An', '');
  edt_CC.Text      := fIni.ReadIni(fIniFilename, 'Mail', 'CC', '');
  edt_BCC.Text     := fIni.ReadIni(fIniFilename, 'Mail', 'BCC', '');
  edt_Betreff.Text := fIni.ReadIni(fIniFilename, 'Mail', 'Betreff', '');
  mem_Body.Text    := fIni.ReadIni(fIniFilename, 'Mail', 'Body', '');
  edt_SMTP.Text    := fIni.ReadIni(fIniFilename, 'MailEinstellung', 'SMTP', '');
  edt_User.Text    := fIni.ReadIni(fIniFilename, 'MailEinstellung', 'User', '');
  edt_Port.Text    := fIni.ReadIni(fIniFilename, 'MailEinstellung', 'Port', '');
  edt_Passwort.Text := fIni.ReadIni(fIniFilename, 'MailEinstellung', 'Passwort', '');
  edt_AbsMail.Text := fIni.ReadIni(fIniFilename, 'MailEinstellung', 'AbsenderMail', '');
  cbo_TLS.ItemIndex := StrToInt(fIni.ReadIni(fIniFilename, 'MailEinstellung', 'TLS', '-1'));
  cbo_AuthType.ItemIndex := StrToInt(fIni.ReadIni(fIniFilename, 'MailEinstellung', 'AuthType', '-1'));
  cbo_SSLVersion.ItemIndex := StrToInt(fIni.ReadIni(fIniFilename, 'MailEinstellung', 'SSLVersion', '-1'));
end;



procedure Tfrm_MailOffice365.btn_SendenClick(Sender: TObject);
begin
  MailSenden;
end;

procedure Tfrm_MailOffice365.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fIni.WriteIni(fIniFilename, 'Mail', 'An', edt_An.Text);
  fIni.WriteIni(fIniFilename, 'Mail', 'CC', edt_CC.Text);
  fIni.WriteIni(fIniFilename, 'Mail', 'BCC', edt_BCC.Text);
  fIni.WriteIni(fIniFilename, 'Mail', 'Betreff', edt_Betreff.Text);
  fIni.WriteIni(fIniFilename, 'Mail', 'Body', mem_Body.Text);
  fIni.WriteIni(fIniFilename, 'MailEinstellung', 'AbsenderMail', edt_AbsMail.Text);
  fIni.WriteIni(fIniFilename, 'MailEinstellung', 'SMTP', edt_SMTP.Text);
  fIni.WriteIni(fIniFilename, 'MailEinstellung', 'User', edt_User.Text);
  fIni.WriteIni(fIniFilename, 'MailEinstellung', 'Port', edt_Port.Text);
  fIni.WriteIni(fIniFilename, 'MailEinstellung', 'Passwort', edt_Passwort.Text);
  fIni.WriteIni(fIniFilename, 'MailEinstellung', 'TLS', IntToStr(cbo_TLS.ItemIndex));
  fIni.WriteIni(fIniFilename, 'MailEinstellung', 'AuthType', IntToStr(cbo_AuthType.ItemIndex));
  fIni.WriteIni(fIniFilename, 'MailEinstellung', 'SSLVersion', IntToStr(cbo_SSLVersion.ItemIndex));
end;


procedure Tfrm_MailOffice365.MailSenden;
var
  Mail: TMail;
begin
  Mail := TMail.Create;
  try
    Mail.MeineEMail   := edt_AbsMail.Text;
    Mail.MeinUsername := Edt_User.Text;
    Mail.MeinPasswort := edt_Passwort.Text;
    Mail.MeineEMail   := edt_AbsMail.Text;
    Mail.Betreff      := edt_Betreff.Text;
    Mail.Nachricht    := mem_Body.Text;
    Mail.Host         := edt_SMTP.Text;
    Mail.EMailAdresse := edt_An.Text;
    Mail.Port         := StrToInt(Trim(edt_Port.Text));
    Mail.UseTLS := cbo_TLS.ItemIndex; // 3
    Mail.AuthType := cbo_AuthType.ItemIndex;   //2
    Mail.SSLVersion := cbo_SSLVersion.ItemIndex; //5
    Mail.Send;
    ShowMessage('Mail wurde versendet');
  finally
    FreeAndNil(Mail);
  end;
end;


end.
