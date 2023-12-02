unit Objekt.Global;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TGlobal = class
  private
    fUseMySql: Boolean;
    fUseFirebird: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property UseFirebird: Boolean read fUseFirebird write fUseFirebird;
    property UseMySql: Boolean read fUseMySql write fUseMySql;
  end;

var
  Global: TGlobal;

implementation

{ TGlobal }

constructor TGlobal.Create;
begin
  fUseFirebird := false;
  fUseMySql := false;
end;

destructor TGlobal.Destroy;
begin

  inherited;
end;


initialization
  Global := TGlobal.Create;

finalization
 if Global <> nil then
   FreeAndNil(Global);


end.
