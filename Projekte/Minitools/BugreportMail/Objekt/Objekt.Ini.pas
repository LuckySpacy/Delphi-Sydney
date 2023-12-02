unit Objekt.Ini;

interface

uses
  System.SysUtils, Objekt.IniAbsMail;

type
  TIni = class
  private
    fPfad: string;
    fAbsMail: TIniAbsMail;
    procedure setPfad(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property Pfad: string read fPfad write setPfad;
    function IniFileName: string;
    function AbsMail: TIniAbsMail;
  end;

implementation

{ TIni }

function TIni.AbsMail: TIniAbsMail;
begin
  Result := fAbsMail;
end;

constructor TIni.Create;
begin
  fPfad := '';
  fAbsMail := TIniAbsMail.Create;
  fAbsMail.IniFileName := 'BugreportMail.Ini';
end;

destructor TIni.Destroy;
begin
  FreeAndNil(fAbsMail);
  inherited;
end;

function TIni.IniFileName: string;
begin
  Result := fPfad + 'BugreportMail.Ini';
end;

procedure TIni.setPfad(const Value: string);
begin
  fPfad := Value;
  fAbsMail.Pfad := fPfad;
end;

end.
