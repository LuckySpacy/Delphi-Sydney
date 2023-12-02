unit Objekt.IniTSIServer;

interface

uses
  IniFiles, Types, Variants, Classes,
  Objekt.IniFirebird, System.SysUtils, Objekt.IniAllgemein;

type
  TIniTSIServer = class
  private
    fFirebird: TIniFirebird;
    fTSI: TIniFirebird;
    fKurse: TIniFirebird;
    fAllgemein: TIniAllgemein;
    fPfad: string;
    procedure setPfad(const Value: string);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function Firebird: TIniFirebird;
    function TSI: TIniFirebird;
    function Kurse: TIniFirebird;
    function Allg: TIniAllgemein;
    property Pfad: string read fPfad write setPfad;
  end;

implementation

{ TIniTSIServer }


constructor TIniTSIServer.Create;
begin
  fFirebird := TIniFirebird.Create;
  fTSI := TIniFirebird.Create;
  fTSI.Section := 'Firbird_TSI';
  fKurse := TIniFirebird.Create;
  fKurse.Section := 'Firebird_Kurse';
  fAllgemein := TIniAllgemein.Create;
end;

destructor TIniTSIServer.Destroy;
begin
  FreeAndNil(fFireBird);
  FreeAndNil(fTSI);
  FreeAndNil(fKurse);
  FreeAndNil(fAllgemein);
  inherited;
end;

function TIniTSIServer.Firebird: TIniFirebird;
begin
  Result := Firebird;
end;

function TIniTSIServer.Kurse: TIniFirebird;
begin
  Result := fKurse;
end;

function TIniTSIServer.Allg: TIniAllgemein;
begin
  Result := fAllgemein;
end;


procedure TIniTSIServer.setPfad(const Value: string);
begin
  fPfad := Value;
  fFireBird.Pfad := fPfad;
  fFireBird.IniFullname := IncludeTrailingPathDelimiter(fPfad) + 'TSIServer.Ini';
  fTSI.IniFullname := IncludeTrailingPathDelimiter(fPfad) + 'TSIServer.Ini';
  fKurse.IniFullname := IncludeTrailingPathDelimiter(fPfad) + 'TSIServer.Ini';
  fAllgemein.IniFullname := IncludeTrailingPathDelimiter(fPfad) + 'TSIServer.Ini';
end;

function TIniTSIServer.TSI: TIniFirebird;
begin
  Result := fTSI;
end;

end.
