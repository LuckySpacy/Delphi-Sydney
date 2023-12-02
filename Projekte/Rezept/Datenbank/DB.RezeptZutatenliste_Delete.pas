unit DB.RezeptZutatenliste;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db;

type
  TDBRezeptZutatenListe = class(TDBBasis)
  private
    fRZId: Integer;
    fZLId: Integer;
    procedure setRZId(const Value: Integer);
    procedure setZLId(const Value: Integer);
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
    property RZ_ID: Integer read fRZId write setRZId;
    property ZL_ID: Integer read fZLId write setZLId;
    function Delete: Boolean; override;
  end;

implementation

{ TDBRezept }

constructor TDBRezeptZutatenListe.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('RL_RZ_ID', ftInteger);
  FFeldList.Add('RL_ZL_ID', ftInteger);
  LegeHistorieFelderAn;
  Init;
end;

destructor TDBRezeptZutatenListe.Destroy;
begin

  inherited;
end;


procedure TDBRezeptZutatenListe.Init;
begin
  inherited;
  fRZId := 0;
  fZLId := 0;
end;

function TDBRezeptZutatenListe.getGeneratorName: string;
begin
  Result := 'RL_ID';
end;

function TDBRezeptZutatenListe.getTableName: string;
begin
  Result := 'Rezeptzutatenliste';
end;

function TDBRezeptZutatenListe.getTablePrefix: string;
begin
  Result := 'RL';
end;

procedure TDBRezeptZutatenListe.FuelleDBFelder;
begin
  fFeldList.FieldByName('RL_ID').AsInteger  := fID;
  fFeldList.FieldByName('RL_RZ_ID').AsInteger := fRZID;
  fFeldList.FieldByName('RL_ZL_ID').AsInteger := fZLID;
  inherited;
end;


procedure TDBRezeptZutatenListe.LoadByQuery(aQuery: TIBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fRZID   := aQuery.FieldByName('RL_RZ_ID').AsInteger;
  fZLID   := aQuery.FieldByName('RL_ZL_ID').AsInteger;
  FuelleDBFelder;
end;

procedure TDBRezeptZutatenListe.SaveToDB;
begin
  inherited;
end;

function TDBRezeptZutatenListe.Delete: Boolean;
begin
  Result := Inherited;
end;



procedure TDBRezeptZutatenListe.setRZId(const Value: Integer);
begin
  UpdateV(fRZID, Value);
  fFeldList.FieldByName('RL_RZ_ID').AsInteger := Value;
end;

procedure TDBRezeptZutatenListe.setZLId(const Value: Integer);
begin
  UpdateV(fZLID, Value);
  fFeldList.FieldByName('RL_ZL_ID').AsInteger := Value;
end;


end.