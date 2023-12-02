unit Objekt.IniRezept;

interface

uses
  IniFiles, SysUtils, Types, Registry, Variants, Windows, Classes,
  Objekt.IniFirebird, Objekt.IniMySql, Objekt.IniDatenbankAllgemein;

type
  TIniRezept = class
  private
    fFirebird: TIniFirebird;
    fMySql: TIniMySql;
    fDatenbankAllgemein: TIniDatenbankAllgemein;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function Firebird: TIniFirebird;
    function MySql: TIniMySql;
    function DatenbankAllgemein: TIniDatenbankAllgemein;
  end;

implementation

{ TIniRezept }

constructor TIniRezept.Create;
begin
  fFirebird := TIniFirebird.Create;
  fMySql := TIniMySql.Create;
  fDatenbankAllgemein := TIniDatenbankAllgemein.Create;
end;


destructor TIniRezept.Destroy;
begin
  FreeAndNil(fFirebird);
  FreeAndNil(fMySql);
  FreeAndNil(fDatenbankAllgemein);
  inherited;
end;

function TIniRezept.Firebird: TIniFirebird;
begin
  Result := fFirebird;
end;

function TIniRezept.MySql: TIniMySql;
begin
  Result := fMySql;
end;

function TIniRezept.DatenbankAllgemein: TIniDatenbankAllgemein;
begin
  Result := fDatenbankAllgemein;
end;


end.
