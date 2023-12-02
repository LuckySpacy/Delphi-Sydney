unit Objekt.VergleichRezeptZutat;

interface

uses
  SysUtils, Classes;

type
  TVergleichRezeptZutat = class
  private
    fId: Integer;
    fEinheit: string;
    fMenge: real;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read fId write fId;
    property Menge: real read fMenge write fMenge;
    property Einheit: string read fEinheit write fEinheit;
    procedure Init;
  end;

implementation

{ TVergleich }

constructor TVergleichRezeptZutat.Create;
begin
  Init;
end;

destructor TVergleichRezeptZutat.Destroy;
begin

  inherited;
end;

procedure TVergleichRezeptZutat.Init;
begin
  fId  := 0;
  fMenge := 0;
  fEinheit := '';
end;

end.
