unit Rest.TSI;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestTSI = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation


constructor TRestTSI.Create;
begin
  inherited;
  FFeldList.Add('TS_AK_ID', ftInteger);
  FFeldList.Add('TS_WOCHEN', ftInteger);
  FFeldList.Add('TS_DATUM', ftDate);
  FFeldList.Add('TS_WERT', ftFloat);
  Init;
end;

destructor TRestTSI.Destroy;
begin

  inherited;
end;


procedure TRestTSI.Init;
begin
  inherited;
end;


end.
