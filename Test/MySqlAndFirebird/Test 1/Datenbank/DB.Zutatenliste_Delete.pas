unit DB.Zutatenliste;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db;

type
  TDBZutatenliste = class(TDBBasis)
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
    procedure LoadByQuery(aQuery: TIBQuery); override;
    procedure SaveToDB; override;
    property ZutatenName: string read fZutatenname write setZutatenname;
  end;

implementation

{ TDBZutatenliste }

constructor TDBZutatenliste.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('ZL_NAME', ftString);
  LegeHistorieFelderAn;
  Init;
end;

destructor TDBZutatenliste.Destroy;
begin

  inherited;
end;


procedure TDBZutatenliste.Init;
begin
  inherited;
  fZutatenname := '';
end;


function TDBZutatenliste.getGeneratorName: string;
begin
  Result := 'ZL_ID';
end;

function TDBZutatenliste.getTableName: string;
begin
  Result := 'ZUTATENLISTE';
end;

function TDBZutatenliste.getTablePrefix: string;
begin
  Result := 'ZL';
end;



procedure TDBZutatenliste.FuelleDBFelder;
begin
  fFeldList.FieldByName('ZL_ID').AsInteger  := fID;
  fFeldList.FieldByName('ZL_NAME').AsString := fZutatenname;
  inherited;
end;



procedure TDBZutatenliste.LoadByQuery(aQuery: TIBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fZutatenname   := aQuery.FieldByName('ZL_NAME').AsString;
  FuelleDBFelder;
end;

procedure TDBZutatenliste.SaveToDB;
begin
  inherited;

end;

procedure TDBZutatenliste.setZutatenname(const Value: string);
begin
  UpdateV(fZutatenname, Value);
  fFeldList.FieldByName('ZL_NAME').AsString := Value;
end;

end.
