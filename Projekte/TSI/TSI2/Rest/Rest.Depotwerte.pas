unit Rest.Depotwerte;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestDepotwerte = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation

{ TRestDepotwerte }

constructor TRestDepotwerte.Create;
begin
  inherited;
  fFeldList.Clear;
  fFeldList.Add('DW_ID', ftInteger);
  fFeldList.Add('DW_DP_ID', ftInteger);
  fFeldList.Add('DW_AK_ID', ftInteger);
  fFeldList.Add('AK_WKN', ftstring);
  fFeldList.Add('AK_AKTIE', ftstring);
end;

destructor TRestDepotwerte.Destroy;
begin

  inherited;
end;

procedure TRestDepotwerte.Init;
begin
  inherited;

end;

end.
