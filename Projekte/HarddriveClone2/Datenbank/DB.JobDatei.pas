unit DB.JobDatei;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db;

type
  TDBJobDatei = class(TDBBasis)
 private
    fDatei: string;
    fChangeDatum: TDateTime;
    fDateidatum: TDateTime;
    fDaId: Integer;
    fJoId: Integer;
    procedure setChangeDatum(const Value: TDateTime);
    procedure setDatei(const Value: string);
    procedure setDateiDatum(const Value: TDateTime);
    procedure setDaId(const Value: Integer);
    procedure setJoId(const Value: Integer);
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
    property DaId: Integer read fDaId write setDaId;
    property Datei: string read fDatei write setDatei;
    property Dateidatum: TDateTime read fDateidatum write setDateiDatum;
    property ChangeDatum: TDateTime read fChangeDatum write setChangeDatum;
    procedure ReadJobDatei(aJoId, aDaId: Integer);
    procedure ReadJobDateiname(aJoId: Integer; aDatei: string);
  end;

implementation

{ TDBDatei }

constructor TDBJobDatei.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('JD_JO_ID', ftInteger);
  FFeldList.Add('JD_DA_ID', ftInteger);
  FFeldList.Add('JD_DATEI', ftString);
  FFeldList.Add('JD_DATEIDATUM', ftDate);
  FFeldList.Add('JD_CHANGEDATUM', ftDate);
  LegeHistorieFelderAn;
  Init;
  DBDelete.MeinName := 'TDBJobDatei';
end;

destructor TDBJobDatei.Destroy;
begin

  inherited;
end;

procedure TDBJobDatei.Init;
begin
  inherited;
  fDatei       := '';
  fChangeDatum := 0;
  fDateidatum  := 0;
  fDaId        := 0;
  fJoId        := 0;
end;

function TDBJobDatei.getTableName: string;
begin
  Result := 'JobDatei';
end;

function TDBJobDatei.getTablePrefix: string;
begin
  Result := 'JD';
end;


function TDBJobDatei.getGeneratorName: string;
begin
  Result := 'JD_ID';
end;


procedure TDBJobDatei.FuelleDBFelder;
begin
  fFeldList.FieldByName('JD_ID').AsInteger           := fID;
  fFeldList.FieldByName('JD_JO_ID').AsInteger        := fJoId;
  fFeldList.FieldByName('JD_DA_ID').AsInteger        := fDaId;
  fFeldList.FieldByName('JD_DATEI').AsString         := fDatei;
  fFeldList.FieldByName('JD_DATEIDATUM').AsDateTime  := fDateidatum;
  fFeldList.FieldByName('JD_CHANGEDATUM').AsDateTime := fChangeDatum;
  inherited;
end;


procedure TDBJobDatei.LoadByQuery(aQuery: TIBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fJoId        := aQuery.FieldByName('JD_JO_ID').AsInteger;
  fDaId        := aQuery.FieldByName('JD_DA_ID').AsInteger;
  fDatei       := aQuery.FieldByName('JD_DATEI').AsString;
  fDateidatum  := aQuery.FieldByName('JD_DATEIDATUM').AsDateTime;
  fChangeDatum := aQuery.FieldByName('JD_CHANGEDATUM').AsDateTime;
  FuelleDBFelder;
end;

procedure TDBJobDatei.SaveToDB;
begin
  inherited;

end;

procedure TDBJobDatei.setChangeDatum(const Value: TDateTime);
begin
  UpdateV(fChangeDatum, Value);
  fFeldList.FieldByName('JD_CHANGEDATUM').AsDateTime := fChangeDatum;
end;

procedure TDBJobDatei.setDaId(const Value: Integer);
begin
  UpdateV(fDaId, Value);
  fFeldList.FieldByName('JD_DA_ID').AsInteger := fDaId;
end;

procedure TDBJobDatei.setDatei(const Value: string);
begin
  UpdateV(fDatei, Value);
  fFeldList.FieldByName('JD_DATEI').AsString := fDatei;
end;

procedure TDBJobDatei.setDateiDatum(const Value: TDateTime);
begin
  UpdateV(fDateiDatum, Value);
  fFeldList.FieldByName('JD_DATEIDATUM').AsDateTime := fDateiDatum;
end;

procedure TDBJobDatei.setJoId(const Value: Integer);
begin
  UpdateV(fJoId, Value);
  fFeldList.FieldByName('JD_JO_ID').AsInteger := fJoId;
end;


procedure TDBJobDatei.ReadJobDatei(aJoId, aDaId: Integer);
begin
  Init;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Transaction := fTrans;
  fQuery.SQL.Text := 'select * from ' + getTableName +
                     ' where jd_jo_id = ' + IntToStr(aJoId) +
                     ' and   jd_da_id = ' + IntToStr(aDaId);
  OpenTrans;
  try
    fQuery.Open;
    LoadByQuery(fQuery);
  finally
    CommitTrans;
  end;
end;

procedure TDBJobDatei.ReadJobDateiname(aJoId: Integer; aDatei: string);
begin
  Init;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Transaction := fTrans;
  fQuery.SQL.Text := 'select * from ' + getTableName +
                     ' where jd_jo_id = ' + IntToStr(aJoId) +
                     ' and   jd_datei = ' + QuotedStr(aDatei);
  OpenTrans;
  try
    fQuery.Open;
    LoadByQuery(fQuery);
  finally
    CommitTrans;
  end;
end;

end.
