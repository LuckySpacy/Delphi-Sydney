unit Objekt.Rezept;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Objekt.Logger, Objekt.IniRezept, Objekt.Allg;

type
  TRezept = class
  private
    fIni: TIniRezept;
    fAllg: TAllg;
  public
    Log: TLogger;
    constructor Create;
    destructor Destroy; override;
    function ProgrammPfad: string;
    function Ini: TIniRezept;
    function Allg: TAllg;
  end;

var
  Rezept: TRezept;


implementation

{ TRezept }



constructor TRezept.Create;
begin
  Log   := TLogger.Create;
  fIni  := TIniRezept.Create;
  fAllg := TAllg.Create;
end;

destructor TRezept.Destroy;
begin
  FreeAndNil(Log);
  FreeAndNil(fIni);
  FreeAndNil(fAllg);
  inherited;
end;

function TRezept.Ini: TIniRezept;
begin
  Result := fIni;
end;

function TRezept.Allg: TAllg;
begin
  Result := fAllg;
end;


function TRezept.ProgrammPfad: string;
begin
  Result :=  IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;


initialization
  Rezept := TRezept.Create;

finalization
 if Rezept <> nil then
   FreeAndNil(Rezept);

end.
