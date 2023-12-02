unit Objekt.PhotoOrga;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Objekt.Logger, Objekt.IniPhotoOrga;

type
  TPhotoOrga = class
  private
    fIniPhotoOrga: TIniPhotoOrga;
  public
    Log: TLogger;
    constructor Create;
    destructor Destroy; override;
    property Ini: TIniPhotoOrga read fIniPhotoOrga write fIniPhotoOrga;
  end;

var
  PhotoOrga: TPhotoOrga;


implementation

{ TPhotoOrga }

constructor TPhotoOrga.Create;
begin
  Log   := TLogger.Create;
  fIniPhotoOrga := TIniPhotoOrga.Create;
end;

destructor TPhotoOrga.Destroy;
begin
  FreeAndNil(Log);
  FreeAndNil(fIniPhotoOrga);
  inherited;
end;

end.
