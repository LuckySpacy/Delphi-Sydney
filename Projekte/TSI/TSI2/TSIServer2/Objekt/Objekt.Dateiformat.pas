unit Objekt.Dateiformat;

interface

uses
  SysUtils, Classes;

type
  TDateiformat = class
  private
    fTrennzeichen: string;
    fPosHoch: Integer;
    fPosSchluss: Integer;
    fDatumFormat: string;
    fPosTief: Integer;
    fPosDatum: Integer;
    fPosVolumen: Integer;
    fPosEroeffnung: Integer;
    fSSID: Integer;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property PosDatum: Integer read fPosDatum write fPosDatum;
    property PosEroeffnung: Integer read fPosEroeffnung write fPosEroeffnung;
    property PosHoch: Integer read fPosHoch write fPosHoch;
    property PosTief: Integer read fPosTief write fPosTief;
    property PosSchluss: Integer read fPosSchluss write fPosSchluss;
    property PosVolumen: Integer read fPosVolumen write fPosVolumen;
    property DatumFormat: string read fDatumFormat write fDatumFormat;
    property Trennzeichen: string read fTrennzeichen write fTrennzeichen;
  end;

implementation

{ TDateiformat }

constructor TDateiformat.Create;
begin
  Init;
end;

destructor TDateiformat.Destroy;
begin

  inherited;
end;

procedure TDateiformat.Init;
begin
  fSSId          := 0;
  fPosHoch       := 0;
  fPosSchluss    := 0;
  fDatumFormat   := '';
  fPosTief       := 0;
  fPosDatum      := 0;
  fPosVolumen    := 0;
  fPosEroeffnung := 0;
  fTrennzeichen  := '';
end;


end.
