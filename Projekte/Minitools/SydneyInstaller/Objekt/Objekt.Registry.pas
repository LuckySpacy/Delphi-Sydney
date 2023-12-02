unit Objekt.Registry;

interface

uses
  SysUtils, Classes, variants, Registry, Winapi.Windows;

type
  TassRootKey = (HKEY_CLASSES_ROOT_, HKEY_CURRENT_USER_, HKEY_LOCAL_MACHINE_,
                HKEY_USERS_, HKEY_PERFORMANCE_DATA_, HKEY_CURRENT_CONFIG_,
                HKEY_DYN_DATA_);

type
  TAssRegistry = class
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function ReadRegistry(const aRootKey: TassRootKey; const aRegPfad, aSchluessel: String;
                      aDefault: Variant; const aCanCreate: Boolean = false): Variant;
    procedure WriteRegistry(const aRootKey: TassRootKey; const aRegPfad, aSchluessel: String;
                        const aValue: Variant; const aCanCreate: Boolean = true);
  end;

implementation

{ TAssRegistry }

constructor TAssRegistry.Create;
begin

end;

destructor TAssRegistry.Destroy;
begin

  inherited;
end;


function RootKeyToDWord(const aevRootKey: TassRootKey): DWord;
begin
  Result := 0;
  if aevRootKey = HKEY_CLASSES_ROOT_ then
    Result := Winapi.Windows.HKEY_CLASSES_ROOT;

  if aevRootKey = HKEY_CURRENT_USER_ then
    Result := Winapi.Windows.HKEY_CURRENT_USER;

  if aevRootKey = HKEY_LOCAL_MACHINE_ then
    Result := Winapi.Windows.HKEY_LOCAL_MACHINE;

  if aevRootKey = HKEY_USERS_ then
    Result := Winapi.Windows.HKEY_USERS;

  if aevRootKey = HKEY_PERFORMANCE_DATA_ then
    Result := Winapi.Windows.HKEY_PERFORMANCE_DATA;

  if aevRootKey = HKEY_CURRENT_CONFIG_ then
    Result := Winapi.Windows.HKEY_CURRENT_CONFIG;

  if aevRootKey = HKEY_DYN_DATA_ then
    Result := Winapi.Windows.HKEY_DYN_DATA;

end;


function TAssRegistry.ReadRegistry(const aRootKey: TassRootKey; const aRegPfad,
  aSchluessel: String; aDefault: Variant; const aCanCreate: Boolean): Variant;
var
  Reg: TRegistry;
  Result_OpenKey: Boolean;
begin
  Reg := TRegistry.Create(KEY_READ);
  Try
    Reg.RootKey := RootKeyToDWord(aRootKey);

    if aCanCreate then
      Result_OpenKey := Reg.OpenKey(aRegPfad, aCanCreate)
    else
      Result_OpenKey := Reg.OpenKeyReadOnly(aRegPfad);

    if not Result_OpenKey then
    begin
      Result := aDefault;
      exit;
    end;
    Result := Reg.ReadString(aSchluessel);

    Reg.CloseKey;
  finally
    FreeAndNil(Reg);
  end;
end;

procedure TAssRegistry.WriteRegistry(const aRootKey: TassRootKey;
  const aRegPfad, aSchluessel: String; const aValue: Variant;
  const aCanCreate: Boolean);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Try
    Reg.RootKey := RootKeyToDWord(aRootKey);
    if not Reg.OpenKey(aRegPfad, aCanCreate) then
      exit;
    Reg.WriteString(aSchluessel, aValue);
    Reg.CloseKey;
  finally
    FreeAndNil(Reg);
  end;
end;


end.
