unit Objekt.SendMail;

interface

uses
  SysUtils, Classes,
  IdMessage, IdPOP3, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, Vcl.StdCtrls, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdGlobal;


type
  TMailErrorEvent=procedure(Sender: TObject; aError: string) of object;


type
  TSendMail = class(TObject)
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
    property OnMailError: TMailErrorEvent read fOnMailError write fOnMailError;
    function UseTLS: TIdUseTLS;
    function SSLVersion: TIdSSLVersion;
    procedure Verschicken;
  end;

implementation

{ TSendMail }

constructor TSendMail.Create;
begin
  FSmtp      := TIdSMTP.Create(nil);
  FMsg       := TIdMessage.Create(nil);
  FIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FSmtp.IOHandler := FIOHandler;
end;

destructor TSendMail.Destroy;
begin
  FreeAndNil(FSmtp);
  FreeAndNil(FMsg);
  FreeAndNil(FIOHandler);
  inherited;
end;

function TSendMail.SSLVersion: TIdSSLVersion;
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

function TSendMail.UseTLS: TIdUseTLS;
begin
  Result := utNoTLSSupport;
  case fAbsTLS of
    0: Result := utNoTLSSupport;
    1: Result := utUseImplicitTLS;
    2: Result := utUseRequireTLS;
    3: Result := utUseExplicitTLS;
  end;
end;

procedure TSendMail.Verschicken;
begin
  Fsmtp.Host := fAbsSmtp;
  Fsmtp.Password := fAbsPasswort;
  Fsmtp.Port := fAbsPort;
  Fsmtp.UseTLS := UseTLS;
  Fsmtp.Username := fAbsUsername;

  FIOHandler.SSLOptions.Method := SSLVersion;
  FIOHandler.SSLOptions.Mode   := sslmUnassigned;
  FIOHandler.SSLOptions.VerifyMode := [];
  FIOHandler.SSLOptions.VerifyDepth := 0;
  fsmtp.IOHandler := fIOHandler;

  FMsg.From.Address := fAbsUsername;
  FMsg.Recipients.EMailAddresses := FEMailAdresse;
  FMsg.Body.Add(FNachricht);
  FMsg.Subject := FBetreff;
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
