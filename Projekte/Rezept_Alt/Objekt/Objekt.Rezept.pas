unit Objekt.Rezept;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Objekt.Verschluesseln, Objekt.Logger, Objekt.IniEinstellung;

type
  TRezept = class
  private
    fVerschluesseln: TVerschluesseln;
    fLogger: TLogger;
    fIniEinstellung: TIniEinstellung;
  public
    constructor Create;
    destructor Destroy; override;
    property Verschluesseln: TVerschluesseln read fVerschluesseln write fVerschluesseln;
    property Logger: TLogger read fLogger write fLogger;
    property IniEinstellung: TIniEinstellung read fIniEinstellung write fIniEinstellung;
    function ProgrammPfad: string;
  end;

var
  Rezept: TRezept;


implementation

{ TRezept }



constructor TRezept.Create;
begin
  fVerschluesseln := TVerschluesseln.Create;
  fLogger := TLogger.Create;
  fIniEinstellung := TIniEinstellung.Create;
end;

destructor TRezept.Destroy;
begin
  FreeAndNil(fVerschluesseln);
  FreeAndNil(fLogger);
  FreeAndNil(fIniEinstellung);
  inherited;
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
