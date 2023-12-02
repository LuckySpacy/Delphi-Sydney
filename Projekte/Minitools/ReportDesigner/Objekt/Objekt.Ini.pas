unit Objekt.Ini;

interface

uses
  SysUtils, Classes, variants, Registry, Winapi.Windows, System.IniFiles;


type
  TAssIni = class
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function  ReadIni(const aFullFileName, aSection, aKey: WideString; aDefault: WideString): WideString;
    procedure WriteIni(const aFullFileName, aSection, aKey: WideString; aValue: WideString);
  end;


implementation

{ TAssIni }

constructor TAssIni.Create;
begin

end;

destructor TAssIni.Destroy;
begin

  inherited;
end;

function TAssIni.ReadIni(const aFullFileName, aSection, aKey: WideString;
  aDefault: WideString): WideString;
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

procedure TAssIni.WriteIni(const aFullFileName, aSection, aKey: WideString;
  aValue: WideString);
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
