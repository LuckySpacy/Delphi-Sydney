unit Objekt.IniDatenbankAllgemein;

interface

uses
  IniFiles, SysUtils, Types, Registry, Variants, Windows, Classes,
  Objekt.Ini, Objekt.IniBase;

type
  TIniDatenbankAllgemein = class(TIniBase)
  private
    function getUseFirebird: Boolean;
    function getUseMySql: Boolean;
    procedure setUseFirebird(const Value: Boolean);
    procedure setUseMySql(const Value: Boolean);
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property UseFirebird: Boolean read getUseFirebird write setUseFirebird;
    property UseMySql: Boolean read getUseMySql write setUseMySql;
  end;

implementation

{ TIniDatenbankAllgemein }

constructor TIniDatenbankAllgemein.Create;
begin
  inherited;
  fSection := 'DatenbankAllgemein';
end;

destructor TIniDatenbankAllgemein.Destroy;
begin

  inherited;
end;

function TIniDatenbankAllgemein.getUseFirebird: Boolean;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'UseFirebird', '')) = 'T';
end;

function TIniDatenbankAllgemein.getUseMySql: Boolean;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'UseMySql', '')) = 'T';
end;

procedure TIniDatenbankAllgemein.setUseFirebird(const Value: Boolean);
var
  s: string;
begin
  if Value then
    s := 'T'
  else
    s := 'F';
  WriteIni(fIniFullname, fSection, 'UseFirebird', Verschluesseln(s));
end;

procedure TIniDatenbankAllgemein.setUseMySql(const Value: Boolean);
var
  s: string;
begin
  if Value then
    s := 'T'
  else
    s := 'F';
  WriteIni(fIniFullname, fSection, 'UseMySql', Verschluesseln(s));
end;

end.
