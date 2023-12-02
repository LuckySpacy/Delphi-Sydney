unit Objekt.IniBase;

interface

uses
  IniFiles, SysUtils, Types, Variants, Classes,
  Objekt.Ini, Objekt.Verschluesseln;

type
  TIniBase = class(TIni)
  private
  protected
    fVerschluesseln: TVerschluesseln;
    fSection: string;
    fPfad: string;
    fIniFullname: string;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Entschluesseln(aValue: string): string;
    function Verschluesseln(aValue: string): string;
    property Pfad: String read fPfad write fPfad;
    property IniFullname: string read fIniFullname write fIniFullname;
    property Section: String read fSection write fSection;
  end;

implementation

{ TIniBase }

constructor TIniBase.Create;
begin
  inherited;
  fVerschluesseln := TVerschluesseln.Create;
end;

destructor TIniBase.Destroy;
begin
  FreeAndNil(fVerschluesseln);
  inherited;
end;

function TIniBase.Entschluesseln(aValue: string): string;
begin
  Result := aValue;
  if Result > '' then
    Result := fVerschluesseln.Entschluesseln(Result);
end;

function TIniBase.Verschluesseln(aValue: string): string;
begin
  if aValue = '' then
  begin
    Result := aValue;
    exit;
  end;
  Result := fVerschluesseln.Verschluesseln(aValue);
end;

end.
