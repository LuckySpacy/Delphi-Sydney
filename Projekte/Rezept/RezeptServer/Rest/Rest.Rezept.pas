unit Rest.Rezept;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestRezept = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation




constructor TRestRezept.Create;
begin
  inherited;
  FFeldList.Add('Rezeptname', ftString);
  FFeldList.Add('Basismenge', ftInteger);
  FFeldList.Add('Beschreibung', ftBlob);
  FFeldList.Add('Notiz', ftBlob);
  FFeldList.Add('PLAINBESCHREIBUNG', ftBlob);
  FFeldList.Add('PLAINNOTIZ', ftBlob);
  FFeldList.Add('RlId', ftInteger);
  Init;
end;

destructor TRestRezept.Destroy;
begin

  inherited;
end;


procedure TRestRezept.Init;
begin
  inherited;
end;



end.


