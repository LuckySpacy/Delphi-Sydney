unit DB.Musikpfad;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db;

type
  TDBMusikpfad = class(TDBBasis)
  private
    fPfad: string;
  protected
    function getGeneratorName: string; override;
    function getTableName: string; override;
    function getTablePrefix: string; override;
    //function getTableId: Integer; override;
    procedure FuelleDBFelder; override;
    procedure setPfad(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure LoadByQuery(aQuery: TIBQuery); override;
    procedure SaveToDB; override;
    function Delete: Boolean; override;
    property Pfad: string read fPfad write setPfad;
  end;

implementation

{ TDBMusikpfad }

constructor TDBMusikpfad.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('MP_PFAD', ftString);
  Init;
end;

destructor TDBMusikpfad.Destroy;
begin

  inherited;
end;

procedure TDBMusikpfad.Init;
begin
  inherited;
  fPfad := '';
  FuelleDBFelder;
end;


function TDBMusikpfad.getGeneratorName: string;
begin
  Result := 'MP_ID';
end;

function TDBMusikpfad.getTableName: string;
begin
  Result := 'Musikpfad';
end;

function TDBMusikpfad.getTablePrefix: string;
begin
  Result := 'MP';
end;



function TDBMusikpfad.Delete: Boolean;
begin
  inherited;
end;


procedure TDBMusikpfad.FuelleDBFelder;
begin
  fFeldList.FieldByName('MP_ID').AsInteger  := fID;
  fFeldList.FieldByName('MP_PFAD').AsString := fPfad;
  inherited;
end;



procedure TDBMusikpfad.LoadByQuery(aQuery: TIBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fPfad := aQuery.FieldByName('MP_PFAD').AsString;
  FuelleDBFelder;
end;

procedure TDBMusikpfad.SaveToDB;
begin
  inherited;

end;

procedure TDBMusikpfad.setPfad(const Value: string);
begin
  UpdateV(fPfad, Value);
  fFeldList.FieldByName('MP_PFAD').AsString := Value;
end;

end.
