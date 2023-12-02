unit DB.PhotoUndBaum;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db, DB.TBQuery;

type
  TDBPhotoUndBaum = class(TDBBasis)
  private
    fPHUId: string;
    fPHId: Integer;
    fPBUId: string;
    fUId: string;
    fPBId: Integer;
    fPosNr: Integer;
    procedure setPBId(const Value: Integer);
    procedure setPBUId(const Value: string);
    procedure setPHId(const Value: Integer);
    procedure setPHUId(const Value: string);
    procedure setUId(const Value: string);
    procedure setPosNr(const Value: Integer);
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
    property PHId: Integer read fPHId write setPHId;
    property PHUId: string read fPHUId write setPHUId;
    property PBId: Integer read fPBId write setPBId;
    property PBUId: string read fPBUId write setPBUId;
    property PosNr: Integer read fPosNr write setPosNr;
  end;

implementation

{ TDBPhotoUndBaum }

constructor TDBPhotoUndBaum.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('PU_UID', ftString);
  FFeldList.Add('PU_PHID', ftInteger);
  FFeldList.Add('PU_PHUID', ftString);
  FFeldList.Add('PU_PBID', ftInteger);
  FFeldList.Add('PU_PBUID', ftString);
  FFeldList.Add('PU_POSNR', ftInteger);
  Init;
end;

destructor TDBPhotoUndBaum.Destroy;
begin

  inherited;
end;

procedure TDBPhotoUndBaum.Init;
begin
  inherited;
  fPHUId := '';
  fPHId  := 0;
  fPBUId := '';
  fUId   := ErzeugeGuid;
  fPBId  := 0;
  fPosNr := 0;
  FuelleDBFelder;
end;


procedure TDBPhotoUndBaum.FuelleDBFelder;
begin

  fFeldList.FieldByName('PU_ID').AsInteger     := fID;
  fFeldList.FieldByName('PU_UID').AsString     := fUId;
  fFeldList.FieldByName('PU_PHID').AsInteger   := fPHId;
  fFeldList.FieldByName('PU_PHUID').AsString   := fPHUId;
  fFeldList.FieldByName('PU_PBID').AsInteger   := fPBId;
  fFeldList.FieldByName('PU_PBUID').AsString   := fPBUId;
  fFeldList.FieldByName('PU_POSNR').AsInteger   := fPosNr;

  inherited;
end;

function TDBPhotoUndBaum.getGeneratorName: string;
begin
  Result := 'PU_ID';
end;

function TDBPhotoUndBaum.getTableName: string;
begin
  Result := 'PhotoUndBaum';
end;

function TDBPhotoUndBaum.getTablePrefix: string;
begin
  Result := 'PU';
end;


procedure TDBPhotoUndBaum.LoadByQuery(aQuery: TTBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fUId   := aQuery.FieldByName('PU_UID').AsString;
  fPHId  := aQuery.FieldByName('PU_PHID').AsInteger;
  fPHUId := aQuery.FieldByName('PU_PHUID').AsString;
  fPBId  := aQuery.FieldByName('PU_PBID').AsInteger;
  fPBUId := aQuery.FieldByName('PU_PBUID').AsString;
  fPosNr := aQuery.FieldByName('PU_POSNR').AsInteger;
  FuelleDBFelder;
end;

procedure TDBPhotoUndBaum.SaveToDB;
begin
  inherited;

end;

procedure TDBPhotoUndBaum.setPBId(const Value: Integer);
begin
  UpdateV(fPBId, Value);
  fFeldList.FieldByName('PU_PBID').AsInteger := Value;
end;

procedure TDBPhotoUndBaum.setPBUId(const Value: string);
begin
  UpdateV(fPBUId, Value);
  fFeldList.FieldByName('PU_PBUID').AsString := Value;
end;

procedure TDBPhotoUndBaum.setPHId(const Value: Integer);
begin
  UpdateV(fPHId, Value);
  fFeldList.FieldByName('PU_PHID').AsInteger := Value;
end;

procedure TDBPhotoUndBaum.setPHUId(const Value: string);
begin
  UpdateV(fPHUId, Value);
  fFeldList.FieldByName('PU_PHUID').AsString := Value;
end;

procedure TDBPhotoUndBaum.setPosNr(const Value: Integer);
begin
  UpdateV(fPosNr, Value);
  fFeldList.FieldByName('PU_POSNR').AsInteger := Value;
end;

procedure TDBPhotoUndBaum.setUId(const Value: string);
begin
  UpdateV(fUId, Value);
  fFeldList.FieldByName('PU_UID').AsString := fUId;
end;

end.
