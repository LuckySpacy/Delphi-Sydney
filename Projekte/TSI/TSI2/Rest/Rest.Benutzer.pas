unit Rest.Benutzer;

interface

uses
  Rest.Basis, sysUtils, Classes, Data.DB;

type
  TRestBenutzer = class(TRestBasis)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

implementation

{ TRestBenutzer }

constructor TRestBenutzer.Create;
begin
  inherited;
  //FFeldList.Add('BE_ID', ftInteger);
  FFeldList.Add('BE_VORNAME', ftString);
  FFeldList.Add('BE_NACHNAME', ftString);
  FFeldList.Add('BE_MAIL', ftString);
  FFeldList.Add('BE_PASSWORT', ftString);
  Init;
end;

destructor TRestBenutzer.Destroy;
begin

  inherited;
end;

procedure TRestBenutzer.Init;
begin
  inherited;

end;

end.
