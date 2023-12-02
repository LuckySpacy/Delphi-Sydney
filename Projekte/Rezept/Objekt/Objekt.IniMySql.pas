unit Objekt.IniMySql;

interface

uses
  IniFiles, SysUtils, Types, Registry, Variants, Windows, Classes,
  Objekt.Ini, Objekt.IniBase;

type
  TIniMySql = class(TIniBase)
  private
    function getDatenbankname: string;
    function getHost: string;
    function getPasswort: string;
    function getPort: string;
    function getUsername: string;
    procedure setDatenbankname(const Value: string);
    procedure setHost(const Value: string);
    procedure setPasswort(const Value: string);
    procedure setPort(const Value: string);
    procedure setUsername(const Value: string);
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Datenbankname: string read getDatenbankname write setDatenbankname;
    property Host: string read getHost write setHost;
    property Username: string read getUsername write setUsername;
    property Passwort: string read getPasswort write setPasswort;
    property Port: string read getPort write setPort;
  end;


implementation

{ TIniMySql }

constructor TIniMySql.Create;
begin
  inherited;
  fSection := 'MySql';
end;

destructor TIniMySql.Destroy;
begin

  inherited;
end;

function TIniMySql.getDatenbankname: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'Datenbankname', ''));
end;

function TIniMySql.getHost: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'Host', ''));
end;

function TIniMySql.getPasswort: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'Passwort', ''));
end;

function TIniMySql.getPort: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'Port', ''));
end;

function TIniMySql.getUsername: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'Username', ''));
end;

procedure TIniMySql.setDatenbankname(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'Datenbankname', Verschluesseln(Value));
end;

procedure TIniMySql.setHost(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'Host', Verschluesseln(Value));
end;

procedure TIniMySql.setPasswort(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'Passwort', Verschluesseln(Value));
end;

procedure TIniMySql.setPort(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'Port', Verschluesseln(Value));
end;

procedure TIniMySql.setUsername(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'Username', Verschluesseln(Value));
end;

end.
