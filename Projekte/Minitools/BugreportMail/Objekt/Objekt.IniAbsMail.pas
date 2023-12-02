unit Objekt.IniAbsMail;

interface

uses
  System.SysUtils, Allgemein.RegIni;

type
  TIniAbsMail = class
  private
    fPfad: string;
    fIniFileName: string;
    fSection: string;
    function getSmtp: string;
    procedure setSmtp(const Value: string);
    function getBenutzer: string;
    procedure setBenutzer(const Value: string);
    function getAbsenderMail: string;
    procedure setAbsenderMail(const Value: string);
    procedure setPasswort(const Value: string);
    function getPasswort: string;
    function getPort: string;
    procedure setPort(const Value: string);
    function getTLS: string;
    procedure setTLS(const Value: string);
    procedure setAuthType(const Value: string);
    function getAuthType: string;
    function getSSLVersion: string;
    procedure setSSLVersion(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property Pfad: string read fPfad write fPfad;
    property IniFileName: string read fIniFileName write fIniFileName;
    function IniFullFileName: string;
    property Smtp: string read getSmtp write setSmtp;
    property Benutzer: string read getBenutzer write setBenutzer;
    property AbsenderMail: string read getAbsenderMail write setAbsenderMail;
    property Passwort: string read getPasswort write setPasswort;
    property Port: string read getPort write setPort;
    property TLS: string read getTLS write setTLS;
    property AuthType: string read getAuthType write setAuthType;
    property SSLVersion: string read getSSLVersion write setSSLVersion;
  end;

implementation

{ TIniAbsMail }

uses
  Objekt.Allgemein;

constructor TIniAbsMail.Create;
begin
  fIniFileName := '';
  fPfad := '';
  fSection := 'AbsMail';
end;

destructor TIniAbsMail.Destroy;
begin

  inherited;
end;

function TIniAbsMail.IniFullFileName: string;
begin
  Result := fPfad + fIniFilename;
end;


function TIniAbsMail.getAbsenderMail: string;
begin
  Result := AllgemeinObj.Entschluesseln(ReadIni(IniFullFileName, fSection, 'Absendermail', ''));
end;

function TIniAbsMail.getAuthType: string;
begin
  Result := ReadIni(IniFullFileName, fSection, 'AuthType', '0');
end;

function TIniAbsMail.getBenutzer: string;
begin
  Result := AllgemeinObj.Entschluesseln(ReadIni(IniFullFileName, fSection, 'Benutzer', ''));
end;

function TIniAbsMail.getPasswort: string;
begin
  Result := AllgemeinObj.Entschluesseln(ReadIni(IniFullFileName, fSection, 'Passwort', ''));
end;

function TIniAbsMail.getPort: string;
begin
  Result := ReadIni(IniFullFileName, fSection, 'Port', '');
end;

function TIniAbsMail.getSmtp: string;
begin
  Result := AllgemeinObj.Entschluesseln(ReadIni(IniFullFileName, fSection, 'Smtp', ''));
end;


function TIniAbsMail.getSSLVersion: string;
begin
  Result := ReadIni(IniFullFileName, fSection, 'SSLVersion', '0');
end;

function TIniAbsMail.getTLS: string;
begin
  Result := ReadIni(IniFullFileName, fSection, 'TLS', '0');
end;

procedure TIniAbsMail.setAbsenderMail(const Value: string);
begin
  WriteIni(IniFullFileName, fSection, 'Absendermail', AllgemeinObj.Verschluesseln(Value));
end;

procedure TIniAbsMail.setAuthType(const Value: string);
var
  i: Integer;
begin
  if not trystrToInt(Value, i) then
    i := 0;
  WriteIni(IniFullFileName, fSection, 'AuthType', IntToStr(i));
end;

procedure TIniAbsMail.setBenutzer(const Value: string);
begin
  WriteIni(IniFullFileName, fSection, 'Benutzer', AllgemeinObj.Verschluesseln(Value));
end;

procedure TIniAbsMail.setPasswort(const Value: string);
begin
  WriteIni(IniFullFileName, fSection, 'Passwort', AllgemeinObj.Verschluesseln(Value));
end;

procedure TIniAbsMail.setPort(const Value: string);
begin
  WriteIni(IniFullFileName, fSection, 'Port', Value);
end;

procedure TIniAbsMail.setSmtp(const Value: string);
begin
  WriteIni(IniFullFileName, fSection, 'Smtp', AllgemeinObj.Verschluesseln(Value));
end;

procedure TIniAbsMail.setSSLVersion(const Value: string);
var
  i: Integer;
begin
  if not trystrToInt(Value, i) then
    i := 0;
  WriteIni(IniFullFileName, fSection, 'SSLVersion', IntToStr(i));
end;

procedure TIniAbsMail.setTLS(const Value: string);
var
  i: Integer;
begin
  if not trystrToInt(Value, i) then
    i := 0;
  WriteIni(IniFullFileName, fSection, 'TLS', IntToStr(i));
end;

end.
