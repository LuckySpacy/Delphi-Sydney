unit Objekt.Mail;

interface

uses
  SysUtils, Classes,
  IdMessage, IdPOP3, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, Vcl.StdCtrls, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdGlobal,
  IdSASlLogin, IdUserPassProvider;

type
  TMail = class(TObject)
  private
    fSmtp: TIdSMTP;
    fMsg: TIdMessage;
    fIOHandler: TIdSSLIOHandlerSocketOpenSSL;
    fMeinPasswort: string;
    fMeineEmail: string;
    fBetreff: string;
    fPort: Integer;
    fNachricht: string;
    fMeinUsername: string;
    fHost: string;
    fEMailAdresse: string;
    fSSLVersion: Integer;
    fAuthType: Integer;
    fUseTLS: Integer;
    fSASLLogin: TIdSASLLogin;
    fUserPassProvider: TIdUserPassProvider;
    function IdSMTPAuthenticationType: TIdSMTPAuthenticationType;
    function IdSSLVersion: TIdSSLVersion;
    function IdUseTLS: TIdUseTLS;
  public
    constructor Create;
    destructor Destroy; override;
    property MeineEMail: string read fMeineEmail write fMeineEMail;
    property MeinPasswort: string read fMeinPasswort write fMeinPasswort;
    property MeinUsername: string read fMeinUsername write fMeinUsername;
    property Betreff: string read fBetreff write fBetreff;
    property Nachricht: string read fNachricht write fNachricht;
    property EMailAdresse: string read fEMailAdresse write fEMailAdresse;
    property Host: string read fHost write fHost;
    property Port: Integer read fPort write fPort;
    property UseTLS: Integer read fUseTLS write fUseTLS;
    property AuthType: Integer read fAuthType write fAuthType;
    property SSLVersion: Integer read fSSLVersion write fSSLVersion;
    procedure Send;
  end;


implementation

{ TMail }

constructor TMail.Create;
begin
  fSmtp := TIdSMTP.Create(nil);
  fMsg  := TIdMessage.Create(nil);
  fIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  fSmtp.IOHandler := FIOHandler;

  FMeineEmail   := '';
  FMeinPasswort := '';
  FBetreff      := '';
  FNachricht    := '';
  FEMailAdresse := '';
  fHost := '';
  fPort := 0;
  fUseTLS := 0;
  fAuthType := 0;
  fSSLVersion := 0;
  fSASLLogin := nil;
  fUserPassProvider := nil;

end;

destructor TMail.Destroy;
begin
  FreeAndNil(fSmtp);
  FreeAndNil(fMsg);
  FreeAndNil(fIOHandler);
  if fSASLLogin <> nil then
    FreeAndNil(fSASLLogin);
  //if fUserPassProvider <> nil then
  //  FreeAndNil(fUserPassProvider);
  inherited;
end;

function TMail.IdSMTPAuthenticationType: TIdSMTPAuthenticationType;
begin
  Result := satDefault;
  case fAuthType of
    0 : Result := satNone;
    1 : Result := satDefault;
    2 : Result := satSASL;
  end;
end;

function TMail.IdSSLVersion: TIdSSLVersion;
begin
  Result := sslvTLSv1;
  case fSSLVersion of
    0: Result := sslvSSLv2;
    1: Result := sslvSSLv23;
    2: Result := sslvSSLv3;
    3: Result := sslvTLSv1;
    4: Result := sslvTLSv1_1;
    5: Result := sslvTLSv1_2;
  end;
end;

function TMail.IdUseTLS: TIdUseTLS;
begin
  Result := utUseExplicitTLS;
  case fUseTLS of
    0: Result := utNoTLSSupport;
    1: Result := utUseImplicitTLS;
    2: Result := utUseRequireTLS;
    3: Result := utUseExplicitTLS;
  end;
end;

procedure TMail.Send;
begin

  fSmtp.SASLMechanisms.Clear;
  if (fUseTLS = 0) and (fIOHandler <> nil) then
    FreeAndNil(fIOHandler);

  if (fUseTLS = 0) and (fIOHandler = nil) then
    exit;

  if fIOHandler = nil then
    fIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  fSmtp.IOHandler := fIOHandler;
  TIdSSLIOHandlerSocketOpenSSL(fSmtp.IOHandler).SSLOptions.Method := IdSSLVersion;
  fSmtp.UseTLS := IdUseTLS;
  fSmtp.Username := fMeinUsername;
  fSmtp.Password := fMeinPasswort;
  fSmtp.Host     := fHost;

  fSmtp.AuthType := IdSMTPAuthenticationType;

  if IdSMTPAuthenticationType = satSASL then
  begin
    if fSASLLogin = nil then
      fSASLLogin := TIdSASLLogin.Create(nil);
    if fUserPassProvider = nil then
      fUserPassProvider := TIdUserPassProvider.Create(fSASLLogin);
    fSASLLogin.UserPassProvider := fUserPassProvider;
    fUserPassProvider.Username := fSmtp.Username;
    fUserPassProvider.Password := fSmtp.Password;
    fSmtp.SASLMechanisms.Add.SASL := fSASLLogin;
  end;

  fMsg.From.Address              := fMeineEmail;
  fMsg.Recipients.EMailAddresses := fEMailAdresse;
  fMsg.Body.Add(fNachricht);
  fMsg.Subject := fBetreff;
  fsmtp.Connect;
  fsmtp.Send(FMsg);
  fsmtp.Disconnect;
end;

end.
