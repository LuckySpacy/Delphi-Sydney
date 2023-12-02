unit Objekt.Ini;

interface

uses
  IniFiles, SysUtils, Types, Registry, Variants, Windows;

type
  TNfRootKey = (HKEY_CLASSES_ROOT_, HKEY_CURRENT_USER_, HKEY_LOCAL_MACHINE_,
                HKEY_USERS_, HKEY_PERFORMANCE_DATA_, HKEY_CURRENT_CONFIG_,
                HKEY_DYN_DATA_);

type
  TNfIni = class
  private
  public
    function  ReadIni(const aFullFileName, aSection, aKey: String; const aDefault: String): String;
    procedure WriteIni(const aFullFileName, aSection, aKey: String; const aValue: String);
    procedure WriteIniBoolean(const aFullFileName, aSection, aKey: String; const aValue: Boolean);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TMyIni }

constructor TNfIni.Create;
begin

end;

destructor TNfIni.Destroy;
begin

  inherited;
end;

function TNfIni.ReadIni(const aFullFileName, aSection, aKey,
  aDefault: String): String;
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

procedure TNfIni.WriteIni(const aFullFileName, aSection, aKey, aValue: String);
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

procedure TNfIni.WriteIniBoolean(const aFullFileName, aSection, aKey: String;
  const aValue: Boolean);
var
  s: string;
  INI: TIniFile;
begin
  if aValue then
    s := '1'
  else
    s := '0';
  INI := TIniFile.Create(aFullFileName);
  try
    INI.WriteString(aSection, aKey, s);
  finally
    FreeAndNil(INI);
  end;
end;

end.
