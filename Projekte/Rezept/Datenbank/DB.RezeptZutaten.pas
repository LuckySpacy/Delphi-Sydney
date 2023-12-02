unit DB.RezeptZutaten;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db, Objekt.MultiQuery;

type
  TDBRezeptZutaten = class(TDBBasis)
  private
    fZutatenname: string;
    fMenge: real;
    fRZId: Integer;
    fZLId: Integer;
    fZTId: Integer;
    fEinheit: string;
    procedure setZutatenname(const Value: string);
    procedure setMenge(const Value: real);
    procedure setRZID(const Value: Integer);
    procedure setZLID(const Value: Integer);

    procedure setZTID(const Value: Integer);
    procedure setEinheit(const Value: string); protected
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
    property Menge: real read fMenge write setMenge;
    property Einheit: string read fEinheit write setEinheit;
    property RZ_ID: Integer read fRZId write setRZID;
    property ZL_ID: Integer read fZLId write setZLID;
    property ZT_ID: Integer read fZTId write setZTID;
    procedure Read(aRzId, aZlId, aZtId: Integer); reintroduce; overload;
  end;

implementation

{ TDBZutatenliste }

constructor TDBRezeptZutaten.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('RT_NAME', ftString);
  FFeldList.Add('RT_MENGE', ftFloat);
  FFeldList.Add('RT_RZ_ID', ftInteger);
  FFeldList.Add('RT_ZL_ID', ftInteger);
  FFeldList.Add('RT_ZT_ID', ftInteger);
  FFeldList.Add('RT_EINHEIT', ftString);
  LegeHistorieFelderAn;
  Init;
end;

destructor TDBRezeptZutaten.Destroy;
begin

  inherited;
end;


procedure TDBRezeptZutaten.Init;
begin
  inherited;
  fZutatenname := '';
  fMenge := 0;
  fRZId  := 0;
  fZLId  := 0;
  fZTId  := 0;
  fEinheit := '';
  FuelleDBFelder;
end;


function TDBRezeptZutaten.getGeneratorName: string;
begin
  Result := 'RT_ID';
end;

function TDBRezeptZutaten.getTableName: string;
begin
  Result := 'REZEPTZUTATEN';
end;

function TDBRezeptZutaten.getTablePrefix: string;
begin
  Result := 'RT';
end;



procedure TDBRezeptZutaten.FuelleDBFelder;
begin
  fFeldList.FieldByName('RT_ID').AsInteger  := fID;
  fFeldList.FieldByName('RT_NAME').AsString := fZutatenname;
  fFeldList.FieldByName('RT_MENGE').AsFloat := fMenge;
  fFeldList.FieldByName('RT_EINHEIT').AsString := fEinheit;
  fFeldList.FieldByName('RT_RZ_ID').AsInteger := fRZId;
  fFeldList.FieldByName('RT_ZL_ID').AsInteger := fZLId;
  fFeldList.FieldByName('RT_ZT_ID').AsInteger := fZTId;
  inherited;
end;



procedure TDBRezeptZutaten.LoadByQuery(aQuery: TMultiQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fZutatenname   := aQuery.FieldByName('ZT_NAME').AsString;
  fMenge   := aQuery.FieldByName('RT_MENGE').AsFloat;
  fEinheit := aQuery.FieldByName('RT_EINHEIT').AsString;
  fRZId   := aQuery.FieldByName('RT_RZ_ID').AsInteger;
  fZLId   := aQuery.FieldByName('RT_ZL_ID').AsInteger;
  fZTId   := aQuery.FieldByName('RT_ZT_ID').AsInteger;
  FuelleDBFelder;
end;


procedure TDBRezeptZutaten.SaveToDB;
begin
  inherited;

end;

procedure TDBRezeptZutaten.setEinheit(const Value: string);
begin
  UpdateV(fEinheit, Value);
  fFeldList.FieldByName('RT_EINHEIT').AsString := Value;
end;

procedure TDBRezeptZutaten.setMenge(const Value: real);
begin
  UpdateV(fMenge, Value, 4);
  fFeldList.FieldByName('RT_MENGE').AsFloat := Value;
end;

procedure TDBRezeptZutaten.setRZID(const Value: Integer);
begin
  UpdateV(fRZId, Value);
  fFeldList.FieldByName('RT_RZ_ID').AsInteger := Value;
end;

procedure TDBRezeptZutaten.setZLID(const Value: Integer);
begin
  UpdateV(fZLId, Value);
  fFeldList.FieldByName('RT_ZL_ID').AsInteger := Value;
end;

procedure TDBRezeptZutaten.setZTID(const Value: Integer);
begin
  UpdateV(fZTId, Value);
  fFeldList.FieldByName('RT_ZT_ID').AsInteger := Value;
end;

procedure TDBRezeptZutaten.setZutatenname(const Value: string);
begin
  UpdateV(fZutatenname, Value);
  fFeldList.FieldByName('RT_NAME').AsString := Value;
end;


procedure TDBRezeptZutaten.Read(aRzId, aZlId, aZtId: Integer);
begin
  Init;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Trans := fTrans;
  fQuery.SQLText := 'select * from ' + getTableName +
                    ' left outer join zutaten on zt_id = rt_zt_id' +
                     ' where rt_delete != ' + QuotedStr('T') +
                     ' and rt_rz_id = ' + IntToStr(aRzId) +
                     ' and rt_zl_id = ' + IntToStr(aZlId) +
                     ' and rt_zt_id = ' + IntToStr(aZtId);
  fQuery.OpenTrans;
  try
    fQuery.Open;
    LoadByQuery(fQuery);
  finally
    fQuery.CommitTrans;
  end;
end;


end.
