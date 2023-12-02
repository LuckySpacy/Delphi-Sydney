unit Rest.Depotname;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestDepotname = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation

{ TRestDepotname }

constructor TRestDepotname.Create;
begin
  inherited;
  FFeldList.Add('DP_NAME', ftString);
  FFeldList.Add('DP_BE_ID', ftInteger);
  Init;
end;

destructor TRestDepotname.Destroy;
begin

  inherited;
end;

procedure TRestDepotname.Init;
begin
  inherited;

end;

end.
