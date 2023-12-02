unit Rest.Aktie;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestAktie = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation




constructor TRestAktie.Create;
begin
  inherited;
  FFeldList.Add('AK_ID', ftInteger);
  FFeldList.Add('AK_AKTIE', ftString);
  FFeldList.Add('AK_WKN', ftString);
  FFeldList.Add('AK_LINK', ftBlob);
  FFeldList.Add('AK_BI_ID', ftInteger);
  FFeldList.Add('AK_SYMBOL', ftString);
  FFeldList.Add('AK_DEPOT', ftString);
  FFeldList.Add('AK_AKTIV', ftString);
  Init;
end;

destructor TRestAktie.Destroy;
begin

  inherited;
end;


procedure TRestAktie.Init;
begin
  inherited;
end;

end.
