unit DB.Rezept;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db,
  Objekt.MultiQuery;

type
  TDBRezept = class(TDBBasis)
  private
    fRezeptname: string;
    fBeschreibung: string;
    fNotiz: string;
    fRLId: Integer;
    procedure setRezeptname(const Value: string);
    procedure setBeschreibung(const Value: string);
    procedure setNotiz(const Value: string);
    procedure setRLId(const Value: Integer);
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
    property Rezeptname: string read fRezeptname write setRezeptname;
    property Beschreibung: string read fBeschreibung write setBeschreibung;
    property Notiz: string read fNotiz write setNotiz;
    property RL_ID: Integer read fRLId write setRLId;
    function Delete: Boolean; override;
  end;

implementation

{ TDBRezept }

constructor TDBRezept.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('RZ_NAME', ftString);
  FFeldList.Add('RZ_BESCHREIBUNG', ftString);
  FFeldList.Add('RZ_NOTIZ', ftString);
  FFeldList.Add('RZ_RL_ID', ftInteger);
  LegeHistorieFelderAn;
  Init;
end;

destructor TDBRezept.Destroy;
begin

  inherited;
end;


procedure TDBRezept.Init;
begin
  inherited;
  fRezeptname := '';
  fBeschreibung := '';
  fNotiz := '';
  fRLId := 0;
  FuelleDBFelder;
end;

{
function TDBRezept.getTableId: Integer;
begin
  Result := 0;
end;
}

function TDBRezept.getTableName: string;
begin
  Result := 'Rezept';
end;

function TDBRezept.getTablePrefix: string;
begin
  Result := 'RZ';
end;


function TDBRezept.getGeneratorName: string;
begin
  Result := 'RZ_ID';
end;

procedure TDBRezept.FuelleDBFelder;
begin
  fFeldList.FieldByName('RZ_ID').AsInteger  := fID;
  fFeldList.FieldByName('RZ_NAME').AsString := fRezeptname;
  fFeldList.FieldByName('RZ_BESCHREIBUNG').AsString := fBeschreibung;
  fFeldList.FieldByName('RZ_NOTIZ').AsString := fNotiz;
  fFeldList.FieldByName('RZ_RL_ID').AsInteger := fRLId;
  inherited;
end;


procedure TDBRezept.LoadByQuery(aQuery: TMultiQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fRezeptname   := aQuery.FieldByName('RZ_NAME').AsString;
  fBeschreibung := aQuery.FieldByName('RZ_BESCHREIBUNG').AsString;
  fNotiz        := aQuery.FieldByName('RZ_NOTIZ').AsString;
  fRLId         := aQuery.FieldByName('RZ_RL_ID').AsInteger;
  FuelleDBFelder;
end;


procedure TDBRezept.SaveToDB;
begin
  inherited;
end;




function TDBRezept.Delete: Boolean;
begin
  Result := inherited;
end;

procedure TDBRezept.setBeschreibung(const Value: string);
begin
  UpdateV(fBeschreibung, Value);
  fFeldList.FieldByName('RZ_BESCHREIBUNG').AsString := Value;
end;

procedure TDBRezept.setNotiz(const Value: string);
begin
  UpdateV(fNotiz, Value);
  fFeldList.FieldByName('RZ_NOTIZ').AsString := Value;
end;

procedure TDBRezept.setRezeptname(const Value: string);
begin
  UpdateV(fRezeptname, Value);
  fFeldList.FieldByName('RZ_NAME').AsString := Value;
end;

procedure TDBRezept.setRLId(const Value: Integer);
begin
  UpdateV(fRLId, Value);
  fFeldList.FieldByName('RZ_RL_ID').AsInteger := Value;
end;

end.
