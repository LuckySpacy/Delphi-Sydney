unit Objekt.Vergleich;

interface


uses
  SysUtils, Classes;

type
  TVergleich = class
  private
    fBez: string;
    fId: Integer;
    fObjects: TObject;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read fId write fId;
    property Bez: string read fBez write fBez;
    property Objects: TObject read fObjects write fObjects;
    procedure Init;
  end;

implementation

{ TVergleich }

constructor TVergleich.Create;
begin
  Init;
end;

destructor TVergleich.Destroy;
begin

  inherited;
end;

procedure TVergleich.Init;
begin
  fBez := '';
  fId  := 0;
  fObjects := nil;
end;

end.
