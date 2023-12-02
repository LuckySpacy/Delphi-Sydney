unit Rest.Zutatenlistenname;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestZutatenlistenname = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation




constructor TRestZutatenlistenname.Create;
begin
  inherited;
  FFeldList.Add('RZ_ID', ftInteger);
  FFeldList.Add('ZL_ID', ftInteger);
  FFeldList.Add('Listenname', ftString);
  Init;
end;

destructor TRestZutatenlistenname.Destroy;
begin

  inherited;
end;


procedure TRestZutatenlistenname.Init;
begin
  inherited;
end;


end.
