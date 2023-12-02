unit DB.IgnorePfad;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db;

type
  TDBIgnorePfad = class(TDBBasis)
 private
    fJoId: Integer;
    fPfad: string;
    fExakt: Boolean;
    procedure setJoId(const Value: Integer);
    procedure setPfad(const Value: string);
    procedure setExakt(const Value: Boolean);
 protected
    function getGeneratorName: string; override;
    function getTableName: string; override;
    function getTablePrefix: string; override;
    procedure FuelleDBFelder; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure LoadByQuery(aQuery: TIBQuery); override;
    procedure SaveToDB; override;
    property JoId: Integer read fJoId write setJoId;
    property Pfad: string read fPfad write setPfad;
    property Exakt: Boolean read fExakt write setExakt;
  end;


implementation

{ TDBIgnorePfad }

constructor TDBIgnorePfad.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('IG_JO_ID', ftInteger);
  FFeldList.Add('IG_PFADNAME', ftString);
  FFeldList.Add('IG_EXAKTPFAD', ftBoolean);
  LegeHistorieFelderAn;
  Init;
end;

destructor TDBIgnorePfad.Destroy;
begin

  inherited;
end;

procedure TDBIgnorePfad.Init;
begin
  inherited;
  fJoId := 0;
  fPfad := '';
  fExakt := false;
end;

function TDBIgnorePfad.getTableName: string;
begin
  Result := 'IgnorePfad';
end;

function TDBIgnorePfad.getTablePrefix: string;
begin
  Result := 'IG';
end;

function TDBIgnorePfad.getGeneratorName: string;
begin
  Result := 'IG_ID';
end;



procedure TDBIgnorePfad.FuelleDBFelder;
begin
  fFeldList.FieldByName('IG_ID').AsInteger      := fID;
  fFeldList.FieldByName('IG_JO_ID').AsInteger   := fJoId;
  fFeldList.FieldByName('IG_PFADNAME').AsString := fPfad;
  fFeldList.FieldByName('IG_EXAKTPFAD').AsString    := BoolToStr(fExakt);
  inherited;
end;

procedure TDBIgnorePfad.LoadByQuery(aQuery: TIBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fJoId   := aQuery.FieldByName('IG_JO_ID').AsInteger;
  fPfad   := aQuery.FieldByName('IG_PFADNAME').AsString;
  fExakt  := Trim(aQuery.FieldByName('IG_EXAKTPFAD').AsString) = 'T';
  FuelleDBFelder;
end;

procedure TDBIgnorePfad.SaveToDB;
begin
  inherited;

end;

procedure TDBIgnorePfad.setExakt(const Value: Boolean);
begin
  UpdateV(fExakt, Value);
  fFeldList.FieldByName('IG_EXAKTPFAD').AsString :=  BoolToStr(fExakt);
end;

procedure TDBIgnorePfad.setJoId(const Value: Integer);
begin
  UpdateV(fJoId, Value);
  fFeldList.FieldByName('IG_JO_ID').AsInteger := fJoId;
end;

procedure TDBIgnorePfad.setPfad(const Value: string);
begin
  UpdateV(fPfad, Value);
  fFeldList.FieldByName('IG_PFADNAME').AsString := fPfad;
end;

end.
