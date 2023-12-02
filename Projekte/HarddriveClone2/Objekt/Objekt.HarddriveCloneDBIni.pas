unit Objekt.HarddriveCloneDBIni;

interface

uses
  SysUtils, Types, Registry, Variants, Windows, Classes, Objekt.Ini;

type
  THarddriveCloneDBIni = class
  private
    fIni: TIni;
    fFullFileName: string;
    fSection: string;
    function getHost: string;
    procedure setHost(const Value: string);
    function getPfad: string;
    procedure setPfad(const Value: string);
    function getDatenbankname: string;
    procedure setDatenbankname(const Value: string);
    function getUsername: string;
    procedure setUsername(const Value: string);
    function getPasswort: string;
    procedure setPasswort(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property FullFileName: string read fFullFileName write fFullFileName;
    property Host: string read getHost write setHost;
    property Pfad: string read getPfad write setPfad;
    property Datenbankname: string read getDatenbankname write setDatenbankname;
    property Username: string read getUsername write setUsername;
    property Passwort: string read getPasswort write setPasswort;
  end;

implementation

{ THarddriveCloneDBIni }

constructor THarddriveCloneDBIni.Create;
begin
  fFullFileName := '';
  fSection := 'Datenbank';
  fIni := TIni.Create;
end;

destructor THarddriveCloneDBIni.Destroy;
begin
  FreeAndNil(fIni);
  inherited;
end;

function THarddriveCloneDBIni.getDatenbankname: string;
begin
  Result := fIni.Read(fFullFileName, fSection, 'Datenbankname', 'HarddriveClone.fdb');
end;

function THarddriveCloneDBIni.getHost: string;
begin
  Result := fIni.Read(fFullFileName, fSection, 'Host', 'localhost');
end;

function THarddriveCloneDBIni.getPasswort: string;
begin
  Result := fIni.Read(fFullFileName, fSection, 'Passwort', 'masterkey');
end;

function THarddriveCloneDBIni.getPfad: string;
begin
  Result := IncludeTrailingPathDelimiter(fIni.Read(fFullFileName, fSection, 'Pfad', ExtractFilePath(ParamStr(0))));
end;

function THarddriveCloneDBIni.getUsername: string;
begin
  Result := fIni.Read(fFullFileName, fSection, 'Username', 'sysdba');
end;

procedure THarddriveCloneDBIni.setDatenbankname(const Value: string);
begin
  fIni.WriteIni(fFullFileName, fSection, 'Datenbankname', Value);
end;

procedure THarddriveCloneDBIni.setHost(const Value: string);
begin
  fIni.WriteIni(fFullFileName, fSection, 'Host', Value);
end;

procedure THarddriveCloneDBIni.setPasswort(const Value: string);
begin
  fIni.WriteIni(fFullFileName, fSection, 'Passwort', Value);
end;

procedure THarddriveCloneDBIni.setPfad(const Value: string);
begin
  fIni.WriteIni(fFullFileName, fSection, 'Pfad', Value);
end;

procedure THarddriveCloneDBIni.setUsername(const Value: string);
begin
  fIni.WriteIni(fFullFileName, fSection, 'Username', Value);
end;

end.
