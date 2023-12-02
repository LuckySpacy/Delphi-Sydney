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
    fPlainNotiz: string;
    fBasismenge: Integer;

    fPlainBeschreibung: string;    procedure setRezeptname(const Value: string);
    procedure setBeschreibung(const Value: string);
    procedure setNotiz(const Value: string);
    procedure setRLId(const Value: Integer);
    procedure setBasismenge(const Value: Integer);
    procedure setPlainBeschreibung(const Value: string);
    procedure setPlainNotiz(const Value: string);protected
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
    property Basismenge: Integer read fBasismenge write setBasismenge;
    property Beschreibung: string read fBeschreibung write setBeschreibung;
    property Notiz: string read fNotiz write setNotiz;
    property PlainBeschreibung: string read fPlainBeschreibung write setPlainBeschreibung;
    property PlainNotiz: string read fPlainNotiz write setPlainNotiz;
    property RL_ID: Integer read fRLId write setRLId;
    function Delete: Boolean; override;
  end;

implementation

{ TDBRezept }

uses
  DB.RzZt, DB.RzZtList, NFSRichviewEdit;

constructor TDBRezept.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('RZ_NAME', ftString);
  FFeldList.Add('RZ_BASISMENGE', ftInteger);
  FFeldList.Add('RZ_BESCHREIBUNG', ftBlob);
  FFeldList.Add('RZ_NOTIZ', ftBlob);
  FFeldList.Add('RZ_PLAINBESCHREIBUNG', ftBlob);
  FFeldList.Add('RZ_PLAINNOTIZ', ftBlob);
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
  fBasismenge := 0;
  fBeschreibung := '';
  fNotiz := '';
  fPlainBeschreibung := '';
  fPlainNotiz := '';
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
  fFeldList.FieldByName('RZ_BASISMENGE').AsInteger := fBasismenge;
  fFeldList.FieldByName('RZ_BESCHREIBUNG').AsString := fBeschreibung;
  fFeldList.FieldByName('RZ_NOTIZ').AsString := fNotiz;
  fFeldList.FieldByName('RZ_PLAINBESCHREIBUNG').AsString := fPlainBeschreibung;
  fFeldList.FieldByName('RZ_PLAINNOTIZ').AsString := fPlainNotiz;
  fFeldList.FieldByName('RZ_RL_ID').AsInteger := fRLId;
  inherited;
end;


procedure TDBRezept.LoadByQuery(aQuery: TMultiQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fRezeptname   := aQuery.FieldByName('RZ_NAME').AsString;
  fBasismenge   := aQuery.FieldByName('RZ_BASISMENGE').AsInteger;
  fBeschreibung := aQuery.FieldByName('RZ_BESCHREIBUNG').AsString;
  fNotiz        := aQuery.FieldByName('RZ_NOTIZ').AsString;
  fPlainBeschreibung := aQuery.FieldByName('RZ_PLAINBESCHREIBUNG').AsString;
  fPlainNotiz := aQuery.FieldByName('RZ_PLAINNOTIZ').AsString;
  fRLId       := aQuery.FieldByName('RZ_RL_ID').AsInteger;
  //fBeschreibung := '';
  //fNotiz := '';
  FuelleDBFelder;
end;


procedure TDBRezept.SaveToDB;
begin
  PlainBeschreibung := TNFSRichViewEdit.PlainText(fBeschreibung);
  PlainNotiz := TNFSRichViewEdit.PlainText(fNotiz);
  inherited;
end;




function TDBRezept.Delete: Boolean;
var
  DBRzZtList: TDBRzZtList;
  i1: Integer;
begin
  fQuery.Trans.Start;
  try
    DBRzZtList := TDBRzZtList.Create;
    DBRzZtList.Trans := fQuery.Trans;
    DBRzZtList.ReadAll(fId);
    for i1 := 0 to DBRzZtList.Count -1 do
    begin
      DBRzZtList.Item[i1].Delete;
    end;
    fQuery.SqlText := 'update rezeptzutaten set rt_update = ' + QuotedStr('T') + ' where rt_rz_id = ' + IntToStr(fId);
    fQuery.ExecSql;
    Result := inherited;
  finally
    fQuery.Trans.Commit;
    FreeAndNil(DBRzZtList);
  end;
end;

procedure TDBRezept.setBasismenge(const Value: Integer);
begin
  UpdateV(fBasismenge, Value);
  fFeldList.FieldByName('RZ_BASISMENGE').AsInteger := Value;
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

procedure TDBRezept.setPlainBeschreibung(const Value: string);
begin
  UpdateV(fPlainBeschreibung, Value);
  fFeldList.FieldByName('RZ_PLAINBESCHREIBUNG').AsString := Value;
end;

procedure TDBRezept.setPlainNotiz(const Value: string);
begin
  UpdateV(fPlainNotiz, Value);
  fFeldList.FieldByName('RZ_PLAINNOTIZ').AsString := Value;
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
