unit Objekt.GridAktie;

interface

uses
  sysUtils, Classes;

type
  TGridAktie = class
  private
    fDepot: Boolean;
    fAktie: string;
    fWKN: string;
    fAkId: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property WKN: string read fWKN write fWKN;
    property Aktie: string read fAktie write fAktie;
    property Depot: Boolean read fDepot write fDepot;
    property AkId: Integer read fAkId write fAkId;
  end;

implementation

{ TGridAktie }

constructor TGridAktie.Create;
begin
  Init;
end;

destructor TGridAktie.Destroy;
begin

  inherited;
end;

procedure TGridAktie.Init;
begin
  fDepot := false;
  fAktie := '';
  fWKN   := '';
  fAkId  := 0;
end;

end.
