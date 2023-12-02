unit Objekt.Datei;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs;

type
  TDatei = class
  private
    fFilename: string;
    fFilePath: string;
    fFileDate: TDateTime;
    fLastSync: TDateTime;
  public
    constructor Create;
    destructor Destroy; override;
    property Filename: string read fFilename write fFilename;
    property FilePath: string read fFilePath write fFilePath;
    property FileDate: TDateTime read fFileDate write fFileDate;
    property LastSync: TDateTime read fLastSync write fLastSync;
    function FullFilename: string;
    function Unterordner(aHauptpfad: string): string;
    function ZielFullFilename(aQuellHauptpfad, aZielHauptpfad: string): string;
    function ZielPfad(aQuellHauptpfad, aZielHauptpfad: string): string;
  end;

implementation

{ TDatei }

constructor TDatei.Create;
begin
  fFilename := '';
  fFilePath := '';
  fFileDate := 0;
  fLastSync := 0;
end;

destructor TDatei.Destroy;
begin

  inherited;
end;

function TDatei.FullFilename: string;
begin
  Result := IncludeTrailingPathDelimiter(fFilePath) + fFilename;
end;

function TDatei.Unterordner(aHauptpfad: string): string;
begin
  Result := IncludeTrailingPathDelimiter(copy(fFilePath, Length(aHauptpfad)+1, Length(fFilePath)));
end;

function TDatei.ZielFullFilename(aQuellHauptpfad, aZielHauptpfad: string): string;
begin
  Result  := ZielPfad(aQuellHauptpfad, aZielHauptpfad) + fFilename;
end;


function TDatei.ZielPfad(aQuellHauptpfad, aZielHauptpfad: string): string;
var
  SubFolder: string;
begin
  SubFolder := Unterordner(aQuellHauptpfad);
  Result    := aZielHauptpfad + SubFolder;
end;
end.
