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

end.
