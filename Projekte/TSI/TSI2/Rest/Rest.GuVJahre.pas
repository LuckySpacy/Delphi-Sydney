unit Rest.GuVJahre;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestGuVJahre = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation

{ TRestGuVJahre }

constructor TRestGuVJahre.Create;
begin
  inherited;
  fFeldList.Clear;
  fFeldList.Add('AK_ID', ftInteger);
  fFeldList.Add('AK_AKTIE', ftstring);
  fFeldList.Add('AK_WKN', ftstring);
  fFeldList.Add('AK_DEPOT', ftstring);
  FFeldList.Add('GJ_JAHR1', ftInteger);
  FFeldList.Add('GJ_PROZENT1', ftFloat);
  FFeldList.Add('GJ_JAHR2', ftInteger);
  FFeldList.Add('GJ_PROZENT2', ftFloat);
  FFeldList.Add('GJ_JAHR3', ftInteger);
  FFeldList.Add('GJ_PROZENT3', ftFloat);
  FFeldList.Add('GJ_JAHR4', ftInteger);
  FFeldList.Add('GJ_PROZENT4', ftFloat);
  FFeldList.Add('GJ_JAHR5', ftInteger);
  FFeldList.Add('GJ_PROZENT5', ftFloat);
  FFeldList.Add('GJ_JAHR6', ftInteger);
  FFeldList.Add('GJ_PROZENT6', ftFloat);
  FFeldList.Add('GJ_DURCHSCHNITT', ftFloat);
  FFeldList.Add('GJ_PROZ365TAGE', ftFloat);
  FFeldList.Add('GJ_TSI27', ftFloat);
  FFeldList.Add('GJ_ABWPROZ', ftFloat);
  FFeldList.Add('GJ_ABWPROZSORT', ftFloat);
end;

destructor TRestGuVJahre.Destroy;
begin

  inherited;
end;

procedure TRestGuVJahre.Init;
begin
  inherited;

end;

end.
