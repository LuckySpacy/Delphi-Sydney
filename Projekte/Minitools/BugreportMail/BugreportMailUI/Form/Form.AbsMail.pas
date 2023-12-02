unit Form.AbsMail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  Tfrm_AbsMail = class(TForm)
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
    Panel5: TPanel;
    Edt_SMTP: TEdit;
    Edt_User: TEdit;
    Edt_Passwort: TEdit;
    edt_Port: TEdit;
    cbo_TLS: TComboBox;
    cbo_AuthType: TComboBox;
    cbo_SSLVersion: TComboBox;
    edt_AbsMail: TEdit;
    btn_Mail: TButton;
    Label1: TLabel;
    edt_MailAn: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure cbo_TLSExit(Sender: TObject);
    procedure cbo_AuthTypeExit(Sender: TObject);
    procedure cbo_SSLVersionExit(Sender: TObject);
    procedure btn_MailClick(Sender: TObject);
    procedure Panel7MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    fMailError: Boolean;
    procedure MailError(Sender: TObject; aError: string);
  public
  end;

var
  frm_AbsMail: Tfrm_AbsMail;

implementation

uses
  Objekt.BugreportMail, Objekt.Mail;

{$R *.dfm}


procedure Tfrm_AbsMail.FormCreate(Sender: TObject);
begin  //
  edt_SMTP.Text := BugreportMail.Ini.AbsMail.Smtp;
  edt_User.Text := BugreportMail.Ini.AbsMail.Benutzer;
  edt_AbsMail.Text := BugreportMail.Ini.AbsMail.AbsenderMail;
  edt_Passwort.Text := BugreportMail.Ini.AbsMail.Passwort;
  edt_Port.Text := BugreportMail.Ini.AbsMail.Port;
  cbo_TLS.ItemIndex := StrToInt(BugreportMail.Ini.AbsMail.TLS);
  cbo_AuthType.ItemIndex := StrToInt(BugreportMail.Ini.AbsMail.AuthType);
  cbo_SSLVersion.ItemIndex := StrToInt(BugreportMail.Ini.AbsMail.SSLVersion);
end;


procedure Tfrm_AbsMail.FormDestroy(Sender: TObject);
begin //

end;




procedure Tfrm_AbsMail.cbo_AuthTypeExit(Sender: TObject);
begin
  BugreportMail.Ini.AbsMail.AuthType := IntToStr(cbo_AuthType.ItemIndex);
end;

procedure Tfrm_AbsMail.cbo_SSLVersionExit(Sender: TObject);
begin
  BugreportMail.Ini.AbsMail.SSLVersion := IntToStr(cbo_SSLVersion.ItemIndex);
end;

procedure Tfrm_AbsMail.cbo_TLSExit(Sender: TObject);
begin
  BugreportMail.Ini.AbsMail.TLS := IntToStr(cbo_TLS.ItemIndex);
end;

procedure Tfrm_AbsMail.EditExit(Sender: TObject);
begin
  BugreportMail.Ini.AbsMail.Smtp := edt_SMTP.Text;
  BugreportMail.Ini.AbsMail.Benutzer := edt_User.Text;
  BugreportMail.Ini.AbsMail.AbsenderMail := edt_AbsMail.Text;
  BugreportMail.Ini.AbsMail.Passwort := edt_Passwort.Text;
  BugreportMail.Ini.AbsMail.Port := edt_Port.Text;
end;


procedure Tfrm_AbsMail.btn_MailClick(Sender: TObject);
var
  Mail: TMail;
begin
  fMailError := false;
  Mail := TMail.Create;
  try
    Mail.AbsSmtp := edt_SMTP.Text;
    Mail.AbsEMail := edt_AbsMail.Text;
    Mail.AbsUsername := edt_User.Text;
    Mail.AbsPasswort := edt_Passwort.Text;
    Mail.AbsPort := StrToInt(edt_Port.Text);
    Mail.AbsTLS := cbo_TLS.ItemIndex;
    Mail.AbsSSLVersion := cbo_SSLVersion.ItemIndex;
    Mail.Betreff := 'Test';
    Mail.Nachricht := 'Dies ist ein Bugreport Test';
    Mail.EMailAdresse := edt_MailAn.Text;
    Mail.OnMailError := MailError;
    Mail.Verschicken;
    if not fMailError then
      ShowMessage('Mail wurde versendet');
  finally
    FreeAndNil(Mail);
  end;

end;

procedure Tfrm_AbsMail.MailError(Sender: TObject; aError: string);
begin
  fMailError := true;
  ShowMessage(aError);
end;



procedure Tfrm_AbsMail.Panel7MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssShift in Shift) and (ssAlt in Shift) and (ssCtrl in Shift) then
  begin
    Edt_SMTP.PasswordChar := #0;
    Edt_User.PasswordChar := #0;
    edt_AbsMail.PasswordChar := #0;
  end;
end;

end.
