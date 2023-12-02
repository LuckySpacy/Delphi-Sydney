unit Objekt.MusikOrga;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Objekt.Logger, Objekt.IniMusikOrga;

type
  TMusikOrga = class
  private
    fIni: TIniMusikOrga;
  public
    Log: TLogger;
    constructor Create;
    destructor Destroy; override;
    function ProgrammPfad: string;
    property Ini: TIniMusikOrga read fIni;
  end;

var
  MusikOrga: TMusikOrga;

implementation

{ TRezept }

constructor TMusikOrga.Create;
begin
  fIni := TIniMusikOrga.Create;
end;

destructor TMusikOrga.Destroy;
begin
  FreeAndNil(fIni);
  inherited;
end;

function TMusikOrga.ProgrammPfad: string;
begin
  Result :=  IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

end.
