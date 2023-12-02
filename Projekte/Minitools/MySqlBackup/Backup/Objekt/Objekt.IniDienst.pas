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
    function getIntervalInMinuten: string;
    procedure setIntervalInMinuten(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property Pfad: string read fPfad write fPfad;
    property IntervalInMinuten: string read getIntervalInMinuten write setIntervalInMinuten;
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
  Result := fPfad + 'MySqlBackup.Ini';
end;

procedure TIniDienst.Init;
begin

end;

function TIniDienst.getIntervalInMinuten: string;
begin
  Result := ReadIni(IniFilename, fSection, 'IntervalInMinuten', '10');
end;


procedure TIniDienst.setIntervalInMinuten(const Value: string);
begin
  WriteIni(IniFilename, fSection, 'IntervalInMinuten', Value);
end;

end.
