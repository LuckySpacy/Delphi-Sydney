unit Objekt.Ini;

interface

uses
  IniFiles, SysUtils, Types, Registry, Variants, Windows, Classes;

type
  TtbRootKey = (HKEY_CLASSES_ROOT_, HKEY_CURRENT_USER_, HKEY_LOCAL_MACHINE_,
                HKEY_USERS_, HKEY_PERFORMANCE_DATA_, HKEY_CURRENT_CONFIG_,
                HKEY_DYN_DATA_);

type
  TIni = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    function ReadInt(const aFullFileName, aSection, aKey: String; const aDefault: Integer = 0): Integer;
    function Read(const aFullFileName, aSection, aKey: String; const aDefault: string = ''): string;
    procedure WriteIni(const aFullFileName, aSection, aKey: String; aValue: String);
  end;


implementation

{ TIni }

constructor TIni.Create;
begin

end;

destructor TIni.Destroy;
begin

  inherited;
end;


function TIni.Read(const aFullFileName, aSection, aKey,
  aDefault: string): string;
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(aFullFileName);
  try
    Result := INI.ReadString(aSection, aKey, aDefault);
  finally
    FreeAndNil(INI);
  end;
end;

function TIni.ReadInt(const aFullFileName, aSection, aKey: String; const aDefault: Integer = 0): Integer;
var
  INI: TIniFile;
  s  : string;
begin
  INI := TIniFile.Create(aFullFileName);
  try
    s := INI.ReadString(aSection, aKey, IntToStr(aDefault));
    if not TryStrToInt(s, Result) then
      Result := aDefault;
  finally
    FreeAndNil(INI);
  end;
end;


procedure TIni.WriteIni(const aFullFileName, aSection, aKey: String; aValue: String);
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(aFullFileName);
  try
    INI.WriteString(aSection, aKey, aValue);
  finally
    FreeAndNil(INI);
  end;
end;

end.
