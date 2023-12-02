unit DB.Photo;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db, DB.TBQuery;

type
  TDBPhoto = class(TDBBasis)
  private
    fDateiname: string;
    fUId: string;
    fBild: TMemoryStream;
    fPfad: string;
    fBildname: string;
    fDatum: TDateTime;
    procedure setBildname(const Value: string);
    procedure setDateiname(const Value: string);
    procedure setPfad(const Value: string);
    procedure setUId(const Value: string);
    procedure setDatum(const Value: TDateTime);
  protected
    function getGeneratorName: string; override;
    function getTableName: string; override;
    function getTablePrefix: string; override;
    procedure FuelleDBFelder; override;
    //function getTableId: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure LoadByQuery(aQuery: TTBQuery); override;
    procedure SaveToDB; override;
    property UId: string read fUId write setUId;
    property Bildname: string read fBildname write setBildname;
    property Dateiname: string read fDateiname write setDateiname;
    property Pfad: string read fPfad write setPfad;
    //property Bild: string read fBild write setBild;
    property Datum: TDateTime read fDatum write setDatum;
    procedure ReadFromDateiname(aPfad, aDateiname: string);
    procedure setBild(aStream: TMemoryStream);
    procedure LoadBildFromFile(aFullFilename: string);
  end;

implementation

{ TDBPhoto }

constructor TDBPhoto.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('PH_UID', ftString);
  FFeldList.Add('PH_NAME', ftString);
  FFeldList.Add('PH_PFAD', ftString);
  FFeldList.Add('PH_BILD', ftBlob);
  FFeldList.Add('PH_DATEINAME', ftString);
  FFeldList.Add('PH_DATUM', ftDateTime);
  fBild := TMemoryStream.Create;
  Init;
end;

destructor TDBPhoto.Destroy;
begin
  FreeAndNil(fBild);
  inherited;
end;

procedure TDBPhoto.Init;
begin
  inherited;
  fDateiname := '';
  fUId       := ErzeugeGuid;
  fPfad      := '';
  fBildname  := '';
  fDatum     := 0;
  fBild.Clear;
  FuelleDBFelder;
end;


procedure TDBPhoto.FuelleDBFelder;
begin
  fFeldList.FieldByName('PH_ID').AsInteger  := fID;
  fFeldList.FieldByName('PH_UID').AsString  := fUID;
  fFeldList.FieldByName('PH_NAME').AsString := fBildname;
  fFeldList.FieldByName('PH_PFAD').AsString := fPfad;
  //fFeldList.FieldByName('PH_BILD').AsString := fBild;
  fFeldList.FieldByName('PH_DATUM').AsDateTime := fDatum;
  fFeldList.FieldByName('PH_DATEINAME').AsString := fDateiname;
  inherited;
end;

function TDBPhoto.getGeneratorName: string;
begin
  Result := 'PH_ID';
end;

function TDBPhoto.getTableName: string;
begin
  Result := 'Photo';
end;

function TDBPhoto.getTablePrefix: string;
begin
  Result := 'PH';
end;


procedure TDBPhoto.LoadBildFromFile(aFullFilename: string);
begin
  fBild.Clear;
  fBild.LoadFromFile(aFullFilename);
  fBild.Position := 0;
  fFeldList.FieldByName('PH_BILD').SaveToStream(fBild);
  fBild.Position := 0;
end;

procedure TDBPhoto.LoadByQuery(aQuery: TTBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fUID      := aQuery.FieldByName('PH_UID').AsString;
  fBildname := aQuery.FieldByName('PH_NAME').AsString;
  fPfad     := aQuery.FieldByName('PH_PFAD').AsString;
  //fBild     := aQuery.FieldByName('PH_BILD').AsString;
  fDateiname := aQuery.FieldByName('PH_DATEINAME').AsString;
  fDatum    := aQuery.FieldByName('PH_DATUM').AsDateTime;
  aQuery.LoadFromStream(fBild, TBlobField(aQuery.FieldByName('PH_BILD')));
  FuelleDBFelder;
end;


procedure TDBPhoto.SaveToDB;
begin
  inherited;

end;



procedure TDBPhoto.setBild(aStream: TMemoryStream);
begin
  fBild.Clear;
  fBild.Position := 0;
  aStream.Position := 0;
  fBild.LoadFromStream(aStream);
  fFeldList.FieldByName('PH_BILD').SaveToStream(fBild);
  fBild.Position := 0;
  aStream.Position := 0;
end;

procedure TDBPhoto.setBildname(const Value: string);
begin
  UpdateV(fBildname, Value);
  fFeldList.FieldByName('PH_NAME').AsString := fBildname;
end;

procedure TDBPhoto.setDateiname(const Value: string);
begin
  UpdateV(fDateiname, Value);
  fFeldList.FieldByName('PH_DATEINAME').AsString := fDateiname;
end;

procedure TDBPhoto.setDatum(const Value: TDateTime);
begin
  UpdateV(fDatum, Value);
  fFeldList.FieldByName('PH_DATUM').AsDateTime := fDatum;
end;

procedure TDBPhoto.setPfad(const Value: string);
begin
  UpdateV(fPfad, Value);
  fFeldList.FieldByName('PH_PFAD').AsString := fPfad;
end;

procedure TDBPhoto.setUId(const Value: string);
begin
  UpdateV(fUId, Value);
  fFeldList.FieldByName('PH_UID').AsString := fUId;
end;


procedure TDBPhoto.ReadFromDateiname(aPfad, aDateiname: string);
begin
  Init;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Trans := fTrans;
  fQuery.SQL.Text := 'select * from ' + getTableName +
                     ' where ph_delete != :del' +
                     ' and   ph_pfad = :pfad' +
                     ' and   ph_dateiname = :dateiname';
  fQuery.ParamByName('del').AsString := 'T';
  fQuery.ParamByName('pfad').AsString := aPfad;
  fQuery.ParamByName('dateiname').AsString := aDateiname;

  fQuery.OpenTrans;
  try
    fQuery.Open;
    LoadByQuery(fQuery);
  finally
    fQuery.CommitTrans;
  end;
end;



end.
