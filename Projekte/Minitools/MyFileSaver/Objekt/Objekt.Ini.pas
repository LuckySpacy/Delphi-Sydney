unit Objekt.Ini;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Allgemein.SysFolderlocation, Allgemein.Types, Allgemein.RegIni, shellapi,
  Objekt.IniDienst;

type
  TIni = class
  private
    fPfad: string;
    fDienst: TIniDienst;
    procedure setPfad(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property Pfad: string read fPfad write setPfad;
    function Dienst: TIniDienst;
  end;

implementation

{ TIni }

uses
  DateUtils;

constructor TIni.Create;
begin
  fDienst := TIniDienst.Create;
  Init;
end;

destructor TIni.Destroy;
begin
  FreeAndNil(fDienst);
  inherited;
end;



function TIni.Dienst: TIniDienst;
begin
  Result := fDienst;
end;

procedure TIni.Init;
begin
  fPfad := '';
end;

procedure TIni.setPfad(const Value: string);
begin
  fPfad := Value;
  fDienst.Pfad := Value;
end;

end.
