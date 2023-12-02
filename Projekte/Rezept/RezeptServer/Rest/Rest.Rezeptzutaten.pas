unit Rest.Rezeptzutaten;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestRezeptzutaten = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation




constructor TRestRezeptzutaten.Create;
begin
  inherited;
  FFeldList.Add('NAME', ftString);
  FFeldList.Add('MENGE', ftFloat);
  FFeldList.Add('RZ_ID', ftInteger);
  FFeldList.Add('ZL_ID', ftInteger);
  FFeldList.Add('ZT_ID', ftInteger);
  FFeldList.Add('EINHEIT', ftString);
  Init;
end;

destructor TRestRezeptzutaten.Destroy;
begin

  inherited;
end;


procedure TRestRezeptzutaten.Init;
begin
  inherited;
end;


end.
