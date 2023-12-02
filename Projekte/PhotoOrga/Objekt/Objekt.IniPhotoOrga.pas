unit Objekt.IniPhotoOrga;

interface

uses
  IniFiles, SysUtils, Types, Registry, Variants, Windows, Classes, Objekt.IniFirebird,
  Objekt.IniEinstellung;

type
  TIniPhotoOrga = class
  private
    fIniFirebird: TIniFirebird;
    fIniEinstellung: TIniEinstellung;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Firebird: TIniFirebird read fIniFirebird write fIniFirebird;
    property Einstellung: TIniEinstellung read fIniEinstellung write fIniEinstellung;
  end;

implementation

{ TIniPhotoOrga }

constructor TIniPhotoOrga.Create;
begin
  fIniFirebird    := TIniFireBird.Create;
  fIniEinstellung := TIniEinstellung.Create;
end;

destructor TIniPhotoOrga.Destroy;
begin
  FreeAndNil(fIniFirebird);
  FreeAndNil(fIniEinstellung);
  inherited;
end;


end.
