unit Objekt.IniMusikOrga;

interface

uses
  IniFiles, SysUtils, Types, Registry, Variants, Windows, Classes,
  Objekt.IniFirebird;

type
  TIniMusikOrga = class
  private
    fFirebird: TIniFirebird;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function Firebird: TIniFirebird;
  end;

implementation

{ TIniMusikOrga }

constructor TIniMusikOrga.Create;
begin
 fFirebird := TIniFirebird.Create;
end;

destructor TIniMusikOrga.Destroy;
begin
  FreeAndNil(fFirebird);
  inherited;
end;

function TIniMusikOrga.Firebird: TIniFirebird;
begin
  Result := fFirebird;
end;

end.
