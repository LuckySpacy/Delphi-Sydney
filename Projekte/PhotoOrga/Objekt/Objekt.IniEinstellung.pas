unit Objekt.IniEinstellung;

interface

uses
  IniFiles, SysUtils, Types, Registry, Variants, Windows, Classes,
  Objekt.Ini, Objekt.IniBase;

type
  TIniEinstellung = class(TIniBase)
  private
    function getBilderpfad: string;
    procedure setBilderpfad(const Value: string);
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Bilderpfad: string read getBilderpfad write setBilderpfad;
  end;

implementation

{ TIniEinstellung }

constructor TIniEinstellung.Create;
begin
  inherited;

end;

destructor TIniEinstellung.Destroy;
begin

  inherited;
end;

function TIniEinstellung.getBilderpfad: string;
begin
  Result := ReadIni(fIniFullName, fSection, 'Bilderpfad', '');
end;

procedure TIniEinstellung.setBilderpfad(const Value: string);
begin
  WriteIni(fIniFullName, fSection, 'Bilderpfad', Value);
end;

end.
