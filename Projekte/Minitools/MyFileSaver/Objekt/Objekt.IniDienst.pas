unit Objekt.IniDienst;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Allgemein.SysFolderlocation, Allgemein.Types, Allgemein.RegIni, shellapi,
  Objekt.Option;

type
  TIniDienst = class
  private
    fPfad: string;
    fSection: string;
    //function getIntervalInMinuten: string;
    //procedure setIntervalInMinuten(const Value: string);
    function getDebugInfo: string;
    procedure setDebugInfo(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property Pfad: string read fPfad write fPfad;
    //property IntervalInMinuten: string read getIntervalInMinuten write setIntervalInMinuten;
    property DebugInfo: string read getDebugInfo write setDebugInfo;
    function IniFilename: string;
  end;

implementation

{ TIniDienst }

constructor TIniDienst.Create;
begin
  fSection := 'Dienst';
end;

destructor TIniDienst.Destroy;
begin

  inherited;
end;


function TIniDienst.IniFilename: string;
begin
  Result := fPfad + 'MyFileServer.Ini';
end;

procedure TIniDienst.Init;
begin

end;

function TIniDienst.getDebugInfo: string;
begin
  Result := ReadIni(IniFilename, fSection, 'DebugInfo', '?');
  if Result = '?' then
  begin
    setDebugInfo('0');
    Result := '0';
  end;
end;

{
function TIniDienst.getIntervalInMinuten: string;
begin
  Result := ReadIni(IniFilename, fSection, 'IntervalInMinuten', '?');
  if Result = '?' then
  begin
    setIntervalInMinuten('10');
    Result := ReadIni(IniFilename, fSection, 'IntervalInMinuten', '10');
  end;
end;
}

procedure TIniDienst.setDebugInfo(const Value: string);
begin
  WriteIni(IniFilename, fSection, 'DebugInfo', Value);
end;

{
procedure TIniDienst.setIntervalInMinuten(const Value: string);
begin
  WriteIni(IniFilename, fSection, 'IntervalInMinuten', Value);
end;
}
end.
