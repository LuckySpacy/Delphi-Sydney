unit Objekt.Mail;

interface

uses
  SysUtils, Classes,
  IdMessage, IdPOP3, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, Vcl.StdCtrls, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdGlobal, IdSASLLogin, IdUserPassProvider, IdAttachmentFile;


type
  TMailErrorEvent=procedure(Sender: TObject; aError: string) of object;


type
  TMail = class(TObject)
  private
    fSmtp: TIdSMTP;
    fMsg: TIdMessage;
    fIOHandler: TIdSSLIOHandlerSocketOpenSSL;
    fAbsUsername: string;
    fBetreff: string;
    fAbsEmail: string;
    fAbsPasswort: string;
    fOnMailError: TMailErrorEvent;
    fNachricht: string;
    fAbsSmtp: string;
    fEMailAdresse: string;
    fAbsPort: Integer;
    fAbsTLS: Integer;
    fAbsSSLVersion: Integer;
    fAbsAuthType: Integer;
    fSASLLogin: TIdSASLLogin;
    fUserPassProvider: TIdUserPassProvider;
  public
    constructor Create;
    destructor Destroy; override;
    property AbsEMail: string read fAbsEmail write fAbsEMail;
    property AbsPasswort: string read fAbsPasswort write fAbsPasswort;
    property AbsUsername: string read fAbsUsername write fAbsUsername;
    property AbsPort: Integer read fAbsPort write fAbsPort;
    property AbsTLS: Integer read fAbsTLS write fAbsTLS;
    property AbsSSLVersion: Integer read fAbsSSLVersion write fAbsSSLVersion;
    property Betreff: string read fBetreff write fBetreff;
    property Nachricht: string read fNachricht write fNachricht;
    property EMailAdresse: string read fEMailAdresse write fEMailAdresse;
    property AbsSmtp: string read fAbsSmtp write fAbsSmtp;
    property AbsAuthType: Integer read fAbsAuthType write fAbsAuthType;
    property OnMailError: TMailErrorEvent read fOnMailError write fOnMailError;
    function UseTLS: TIdUseTLS;
    function SSLVersion: TIdSSLVersion;
    function IdSMTPAuthenticationType: TIdSMTPAuthenticationType;
    procedure Verschicken(aAnhangList: TStrings);
  end;

implementation

{ TMail }

constructor TMail.Create;
begin
  FSmtp      := TIdSMTP.Create(nil);
  FMsg       := TIdMessage.Create(nil);
  FIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FSmtp.IOHandler := FIOHandler;
  fSASLLogin := nil;
  fUserPassProvider := nil;
  fAbsUsername := '';
  fBetreff := '';
  fAbsEmail := '';
  fAbsPasswort:= '';
  fOnMailError:= nil;
  fNachricht := '';
  fAbsSmtp := '';
  fEMailAdresse := '';
  fAbsPort := 0;
  fAbsTLS  := 0;
  fAbsSSLVersion := 0;
  fAbsAuthType := 0;
end;

destructor TMail.Destroy;
begin
  FreeAndNil(FSmtp);
  FreeAndNil(FMsg);
  FreeAndNil(FIOHandler);
  if fSASLLogin <> nil then
    FreeAndNil(fSASLLogin);
  inherited;
end;

function TMail.SSLVersion: TIdSSLVersion;
begin
  Result := sslvSSLv2;
  case fAbsSSLVersion of
    0: Result := sslvSSLv2;
    1: Result := sslvSSLv23;
    2: Result := sslvSSLv3;
    3: Result := sslvTLSv1;
    4: Result := sslvTLSv1_1;
    5: Result := sslvTLSv1_2;
  end;
end;

function TMail.UseTLS: TIdUseTLS;
begin
  Result := utNoTLSSupport;
  case fAbsTLS of
    0: Result := utNoTLSSupport;
    1: Result := utUseImplicitTLS;
    2: Result := utUseRequireTLS;
    3: Result := utUseExplicitTLS;
  end;
end;

function TMail.IdSMTPAuthenticationType: TIdSMTPAuthenticationType;
begin
  Result := satDefault;
  case fAbsAuthType of
    0 : Result := satNone;
    1 : Result := satDefault;
    2 : Result := satSASL;
  end;
end;


procedure TMail.Verschicken(aAnhangList: TStrings);
var
  i1: Integer;
begin

  fSmtp.SASLMechanisms.Clear;
  if (fAbsTLS = 0) and (fIOHandler <> nil) then
    FreeAndNil(fIOHandler);

  if (fAbsTLS = 0) and (fIOHandler = nil) then
    exit;


  Fsmtp.Host := fAbsSmtp;
  Fsmtp.Password := fAbsPasswort;
  Fsmtp.Port := fAbsPort;
  Fsmtp.UseTLS := UseTLS;
  Fsmtp.Username := fAbsUsername;

  FIOHandler.SSLOptions.Mode   := sslmUnassigned;
  FIOHandler.SSLOptions.VerifyMode := [];
  FIOHandler.SSLOptions.VerifyDepth := 0;
  fsmtp.IOHandler := fIOHandler;
  TIdSSLIOHandlerSocketOpenSSL(fSmtp.IOHandler).SSLOptions.Method := SSLVersion;


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


  FMsg.From.Address := fAbsUsername;
  FMsg.Recipients.EMailAddresses := FEMailAdresse;
  FMsg.Body.Add(FNachricht);
  FMsg.Subject := FBetreff;

  if aAnhangList <> nil then
  begin
    for i1 := 0 to aAnhangList.Count -1 do
    begin
      if FileExists(aAnhangList.Strings[i1]) then
        TIdAttachmentFile.Create(fMsg.MessageParts, aAnhangList.Strings[i1]);
    end;
  end;


  try
    Fsmtp.Connect;
    Fsmtp.Send(FMsg);
    Fsmtp.Disconnect;
  except
    on E: Exception do
    begin
      if Assigned(fOnMailError) then
        fOnMailError(Self, e.Message);
    end;
  end;

end;

end.
