unit DB.Zutaten;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db,
  Objekt.MultiQuery;

type
  TDBZutaten = class(TDBBasis)
  private
    fZutatenname: string;
    procedure setZutatenname(const Value: string);
  protected
    function getGeneratorName: string; override;
    function getTableName: string; override;
    function getTablePrefix: string; override;
    //function getTableId: Integer; override;
    procedure FuelleDBFelder; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure LoadByQuery(aQuery: TMultiQuery); override;
    procedure SaveToDB; override;
    property ZutatenName: string read fZutatenname write setZutatenname;
  end;

implementation

{ TDBZutaten }

constructor TDBZutaten.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('ZT_NAME', ftString);
  LegeHistorieFelderAn;
  Init;
end;

destructor TDBZutaten.Destroy;
begin

  inherited;
end;


procedure TDBZutaten.Init;
begin
  inherited;
  fZutatenname := '';
  FuelleDBFelder;
end;


function TDBZutaten.getGeneratorName: string;
begin
  Result := 'ZT_ID';
end;

function TDBZutaten.getTableName: string;
begin
  Result := 'ZUTATEN';
end;

function TDBZutaten.getTablePrefix: string;
begin
  Result := 'ZT';
end;



procedure TDBZutaten.FuelleDBFelder;
begin
  fFeldList.FieldByName('ZT_ID').AsInteger  := fID;
  fFeldList.FieldByName('ZT_NAME').AsString := fZutatenname;
  inherited;
end;



procedure TDBZutaten.LoadByQuery(aQuery: TMultiQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fZutatenname   := aQuery.FieldByName('ZT_NAME').AsString;
  FuelleDBFelder;
end;

procedure TDBZutaten.SaveToDB;
begin
  inherited;

end;

procedure TDBZutaten.setZutatenname(const Value: string);
begin
  UpdateV(fZutatenname, Value);
  fFeldList.FieldByName('ZT_NAME').AsString := Value;
end;

end.
