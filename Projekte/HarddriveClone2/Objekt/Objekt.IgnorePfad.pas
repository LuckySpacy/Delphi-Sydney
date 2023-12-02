unit Objekt.IgnorePfad;

interface

uses
  SysUtils, Classes;

type
  TIgnorePfad = class
  private
    fExact: Boolean;
    fPfad: string;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Pfad: string read fPfad write fPfad;
    property Exact: Boolean read fExact write fExact;
    procedure Init;
  end;

implementation

{ TIgnorePfad }

constructor TIgnorePfad.Create;
begin
  Init;
end;

destructor TIgnorePfad.Destroy;
begin

  inherited;
end;

procedure TIgnorePfad.Init;
begin
  fExact := false;
  fPfad  := '';
end;

end.
