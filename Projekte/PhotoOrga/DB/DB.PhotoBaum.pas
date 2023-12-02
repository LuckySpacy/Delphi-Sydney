unit DB.PhotoBaum;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db, DB.TBQuery;

type
  TDBPhotoBaum = class(TDBBasis)
  private
    fBez: string;
    fParent_UId: string;
    fUID: string;
    fParentId: Integer;
    procedure setBez(const Value: string);
    procedure setParent_UId(const Value: string);
    procedure setParentId(const Value: Integer);
    procedure setUID(const Value: string);
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
    property ParentId: Integer read fParentId write setParentId;
    property UID: string read fUID write setUID;
    property Parent_UId: string read fParent_UId write setParent_UId;
    property Bez: string read fBez write setBez;
    procedure ReadUId(aUId: string);
  end;

implementation

{ TDBPhotoBaum }

constructor TDBPhotoBaum.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('PB_PARENT_ID', ftInteger);
  FFeldList.Add('PB_UID', ftString);
  FFeldList.Add('PB_PARENT_UID', ftString);
  FFeldList.Add('PB_BEZ', ftString);
  Init;
end;

destructor TDBPhotoBaum.Destroy;
begin

  inherited;
end;

procedure TDBPhotoBaum.Init;
begin
  inherited;
  fBez        := '';
  fParent_UId := '';
  fUID        := ErzeugeGuid;
  fParentId   := 0;
  FuelleDBFelder;
end;


procedure TDBPhotoBaum.FuelleDBFelder;
begin
  fFeldList.FieldByName('PB_ID').AsInteger         := fID;
  fFeldList.FieldByName('PB_PARENT_ID').AsInteger  := fParentId;
  fFeldList.FieldByName('PB_UID').AsString         := fUID;
  fFeldList.FieldByName('PB_PARENT_UID').AsString  := fParent_UId;
  fFeldList.FieldByName('PB_BEZ').AsString         := fBez;
  inherited;
end;

function TDBPhotoBaum.getGeneratorName: string;
begin
  Result := 'PB_ID';
end;

function TDBPhotoBaum.getTableName: string;
begin
  Result := 'PhotoBaum';
end;

function TDBPhotoBaum.getTablePrefix: string;
begin
  Result := 'PB';
end;


procedure TDBPhotoBaum.LoadByQuery(aQuery: TTBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fParentId   := aQuery.FieldByName('PB_PARENT_ID').AsInteger;
  fUID        := aQuery.FieldByName('PB_UID').AsString;
  fParent_UId := aQuery.FieldByName('PB_PARENT_UID').AsString;
  fBez        := aQuery.FieldByName('PB_BEZ').AsString;
  FuelleDBFelder;
end;


procedure TDBPhotoBaum.SaveToDB;
begin
  inherited;

end;

procedure TDBPhotoBaum.setBez(const Value: string);
begin
  UpdateV(fBez, Value);
  fFeldList.FieldByName('PB_BEZ').AsString := Value;
end;

procedure TDBPhotoBaum.setParentId(const Value: Integer);
begin
  UpdateV(fParentId, Value);
  fFeldList.FieldByName('PB_PARENT_ID').AsInteger := Value;
end;

procedure TDBPhotoBaum.setParent_UId(const Value: string);
begin
  UpdateV(fParent_UId, Value);
  fFeldList.FieldByName('PB_PARENT_UID').AsString := Value;
end;

procedure TDBPhotoBaum.setUID(const Value: string);
begin
  UpdateV(fUID, Value);
  fFeldList.FieldByName('PB_UID').AsString := Value;
end;

procedure TDBPhotoBaum.ReadUId(aUId: string);
begin
  Init;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Trans := fTrans;
  fQuery.SQL.Text := 'select * from ' + getTableName +
                     ' where pb_uid = :uid' +
                     ' and   pb_delete != :del';
  fQuery.ParamByName('uid').AsString := aUId;
  fQuery.ParamByName('del').AsString := 'T';
  fQuery.OpenTrans;
  try
    fQuery.Open;
    LoadByQuery(fQuery);
  finally
    fQuery.CommitTrans;
  end;
end;


end.
