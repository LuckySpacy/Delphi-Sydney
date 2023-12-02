unit Objekt.Invest;

interface

type
  TInvest = class
  private
    fWKN: string;
    fProzLaufendesJahr: real;
    fTSI27: real;
    fDurchschnitt: real;
    fProz365Tage: real;
    fAktie: string;
    fProzDurchschnitt: real;
    fProzDiff: real;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property WKN: string read fWKN write fWKN;
    property Aktie: string read fAktie write fAktie;
    property ProzLaufendesJahr: real read fProzLaufendesJahr write fProzLaufendesJahr;
    property Proz365Tage: real read fProz365Tage write fProz365Tage;
    property ProzDurchschnitt: real read fProzDurchschnitt write fProzDurchschnitt;
    property ProzDiff: real read fProzDiff write fProzDiff;
    property Durchschnitt: real read fDurchschnitt write fDurchschnitt;
    property TSI27: real read fTSI27 write fTSI27;
    procedure Init;
  end;


implementation

{ TInvest }

constructor TInvest.Create;
begin

end;

destructor TInvest.Destroy;
begin

  inherited;
end;

procedure TInvest.Init;
begin
  fWKN := '';
  fProzLaufendesJahr := 0;
  fTSI27 := 0;
  fDurchschnitt := 0;
  fProz365Tage :=  0;
  fAktie := '';
  fProzDurchschnitt := 0;
  fProzDiff := 0;
end;

end.
