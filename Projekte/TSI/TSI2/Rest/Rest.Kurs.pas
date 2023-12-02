unit Rest.Kurs;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestKurs = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation




constructor TRestKurs.Create;
begin
  inherited;
//  FFeldList.Add('KU_ID', ftInteger);
//  FFeldList.Add('KU_UPDATE', ftstring);
//  FFeldList.Add('KU_DELETE', ftstring);
  FFeldList.Add('KU_AK_ID', ftInteger);
  FFeldList.Add('KU_DATUM', ftDate);
  FFeldList.Add('KU_KURS', ftfloat);
  FFeldList.Add('KU_EPS', ftfloat);
  FFeldList.Add('KU_KGV', ftfloat);
  Init;
end;

destructor TRestKurs.Destroy;
begin

  inherited;
end;


procedure TRestKurs.Init;
begin
  inherited;
end;

end.
