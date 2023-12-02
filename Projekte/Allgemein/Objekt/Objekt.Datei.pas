unit Objekt.Datei;

interface

uses
  SysUtils, Classes, Windows, Objekt.DateiDatum;

type
  TDatei = class
  private
    fFileAttributeData: TWin32FileAttributeData;
    fPfad: string;
    fDateiname: string;
    fFullDateiname: string;
    fDatum: TDateiDatum;
    fDateigroesse: Int64;
    fId: Integer;
    function getFullDateiname: string;
    procedure setFullDateiname(const Value: string);
    procedure FuelleFullDateiname;
    procedure setPfad(const Value: string);
    procedure setDateiname(const Value: string);
    procedure LeseFileAttributeData;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Pfad: string read fPfad write setPfad;
    property Dateiname: string read fDateiname write setDateiname;
    property FullDateiname: string read getFullDateiname write setFullDateiname;
    property Datum: TDateiDatum read fDatum;
    property Dateigroesse: Int64 read fDateigroesse;
    property Id: Integer read fId write fId;
    function Ext: string;
    function DateinameWithoutExt: string;
    function FullDateinameWithoutExt: string;
    procedure ChangeExt(aExt: string);
    procedure Init;
  end;

implementation

{ TDatei }



constructor TDatei.Create;
begin
  fDatum := TDateiDatum.Create;
  Init;
end;


destructor TDatei.Destroy;
begin
  FreeAndNil(fDatum);
  inherited;
end;




procedure TDatei.Init;
begin
  fId := 0;
  fPfad := '';
  fDateiname := '';
  fFullDateiname := '';
  fDateigroesse := 0;
end;


procedure TDatei.LeseFileAttributeData;
begin
  fDatum.Init;
  fDateigroesse := 0;
  if not FileExists(getFullDateiname) then
    exit;
  if not (GetFileAttributesEx(PChar(fFullDateiname), GetFileExInfoStandard, @fFileAttributeData)) then
    exit;
  fDatum.LeseDatum(fFileAttributeData);
  fDateigroesse := fFileAttributeData.nFileSizeLow or (fFileAttributeData.nFileSizeHigh shl 32);
end;

procedure TDatei.setDateiname(const Value: string);
begin
  fDateiname := Value;
  fFullDateiname := '';
  FuelleFullDateiname;
end;

procedure TDatei.setFullDateiname(const Value: string);
begin
  fFullDateiname := value;
  fPfad := IncludeTrailingPathDelimiter(ExtractFilePath(Value));
  fDateiname := ExtractFileName(Value);
  LeseFileAttributeData;
end;

procedure TDatei.setPfad(const Value: string);
begin
  fPfad := Value;
  fFullDateiname := '';
  FuelleFullDateiname;
end;

function TDatei.getFullDateiname: string;
begin
  if fFullDateiname > '' then
  begin
    Result := fFullDateiname;
    exit;
  end;
  FuelleFullDateiname;
  Result := fFullDateiname;
end;

procedure TDatei.FuelleFullDateiname;
begin
  if fFullDateiname > '' then
    exit;
  if (fPfad > '') and (fDateiname > '') then
    fFullDateiname := IncludeTrailingPathDelimiter(fPfad) + fDateiname;
 if ((fFullDateiname) > '') and (FileExists(fFullDateiname)) then
    LeseFileAttributeData;
end;

function TDatei.Ext: string;
begin
  Result := '';
  if Trim(fDateiname) = '' then
    exit;
  Result := ExtractFileExt(fDateiname);
  if (Length(Result) > 1) and (Result[1] = '.') then
    Result := copy(Result, 2, Length(Result));
end;


function TDatei.DateinameWithoutExt: string;
var
  sExt: string;
begin
  Result := '';
  if Trim(fDateiname) = '' then
    exit;
  sExt := Ext;
  Result := copy(fDateiname, 1, Length(fDateiname) - Length(sExt)-1);
end;

function TDatei.FullDateinameWithoutExt: string;
var
  sExt: string;
begin
  Result := '';
  if Trim(fDateiname) = '' then
    exit;
  sExt := Ext;
  Result := copy(getFullDateiname, 1, Length(getFullDateiname) - Length(sExt)-1);
end;



procedure TDatei.ChangeExt(aExt: string);
var
  s: string;
begin
  if aExt = '' then
    exit;
  if aExt[1] <> '.' then
    aExt := '.' + aExt;
  s := DateinameWithoutExt;
  s := s + aExt;
  setDateiname(s);
end;



end.
