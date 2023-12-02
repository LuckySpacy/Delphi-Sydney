unit Objekt.IniBase;

interface

uses
  IniFiles, SysUtils, Types, Registry, Variants, Windows, Classes,
  Objekt.Ini, Objekt.Folderlocation, Types.Folder, Objekt.Verschluesseln;

type
  TIniBase = class(TIni)
  private
    fFolderlocation: TFolderlocation;
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
    property Section: string read fSection write fSection;
  end;

implementation

{ TIniBase }

constructor TIniBase.Create;
begin
  inherited;
  fVerschluesseln := TVerschluesseln.Create;
  fFolderlocation := TFolderlocation.Create(cCSIDL_APPDATA);
  fPfad := IncludeTrailingPathDelimiter(fFolderlocation.GetShellFolder) + 'tbMusikOrga\';
  if not DirectoryExists(fPfad) then
    ForceDirectories(fPfad);
  fIniFullName := fPfad + 'tbMusikOrga.Ini';
end;

destructor TIniBase.Destroy;
begin
  FreeAndNil(fFolderlocation);
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
