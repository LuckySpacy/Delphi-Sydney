unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, IdMessage, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdBaseComponent, IdComponent, IdServerIOHandler, IdSSL, IdSSLOpenSSL,
  IdSASL, IdSASLUserPass, IdSASLLogin, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdUserPassProvider;

type
  TForm1 = class(TForm)
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
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdSASLLogin1: TIdSASLLogin;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdUserPassProvider1: TIdUserPassProvider;
    procedure FormCreate(Sender: TObject);
    procedure btn_SendenClick(Sender: TObject);
  private
    procedure SendMail;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn_SendenClick(Sender: TObject);
begin
   // idSMTP1.SASLMechanisms.Add.SASL := IdSASLLogin1;
    try
      idSMTP1.Connect;
      try
        idSMTP1.Authenticate;
        SendMail;
      finally
        idSMTP1.Disconnect;
      end;
      ShowMessage('OK');
    except
      on E: Exception do
      begin
        ShowMessage(Format('Failed!'#13'[%s] %s', [E.ClassName, E.Message]));
        raise;
      end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin //
  edt_An.Text := 'bachmann@ass-systemhaus.de';
  edt_Betreff.Text := 'Das ist ein Test';
  mem_Body.Text := 'Das ist ein Test';
  edt_CC.Text := '';
  edt_BCC.Text := '';
end;

procedure TForm1.SendMail;
begin
  IdMessage1.From.Address := 'mustermann@blondundbillig.de';
  IdMessage1.Recipients.EMailAddresses := edt_An.Text;
  IdMessage1.Body.Add(mem_Body.Lines.Text);
  IdMessage1.Subject := edt_Betreff.Text;
  idSMTP1.Send(IdMessage1);
end;

end.
