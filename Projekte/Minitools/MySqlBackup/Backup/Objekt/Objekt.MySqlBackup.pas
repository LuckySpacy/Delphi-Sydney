unit Objekt.MySqlBackup;

interface

uses
  SysUtils, Classes, Objekt.Ini;


type
  TMySqlBackup = class
  private
    fPfad: string;
    fIni: TIni;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property Pfad: string read fPfad;
    function DataFileName: string;
    function Ini: TIni;
  end;

var
  MySqlBackup: TMySqlBackup;

implementation

{ TMySqlBackup }

constructor TMySqlBackup.Create;
begin
  fPfad := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  fIni := TIni.Create;
  fIni.Pfad := fPfad;
  Init;
end;

function TMySqlBackup.DataFileName: string;
begin
  Result := fPfad + 'MySqlBackup.dat';
end;

destructor TMySqlBackup.Destroy;
begin
  FreeAndNil(fIni);
  inherited;
end;

function TMySqlBackup.Ini: TIni;
begin
  Result := fIni;
end;

procedure TMySqlBackup.Init;
begin

end;

end.
