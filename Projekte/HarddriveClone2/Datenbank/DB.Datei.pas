unit DB.Datei;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db;

type
  TDBDatei = class(TDBBasis)
 private
    fDatei: string;
    fChangeDatum: TDateTime;
    fDateidatum: TDateTime;
    procedure setChangeDatum(const Value: TDateTime);
    procedure setDatei(const Value: string);
    procedure setDateiDatum(const Value: TDateTime);
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
    property Datei: string read fDatei write setDatei;
    property Dateidatum: TDateTime read fDateidatum write setDateiDatum;
    property ChangeDatum: TDateTime read fChangeDatum write setChangeDatum;
    procedure ReadDateiname(aDateiname: string);
  end;


implementation

{ TDBDatei }

constructor TDBDatei.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('DA_DATEI', ftString);
  FFeldList.Add('DA_DATEIDATUM', ftDate);
  FFeldList.Add('DA_CHANGEDATUM', ftDate);
  LegeHistorieFelderAn;
  Init;
  DBDelete.MeinName := 'TDBDatei';
end;


destructor TDBDatei.Destroy;
begin

  inherited;
end;


procedure TDBDatei.Init;
begin
  inherited;
  fDatei       := '';
  fChangeDatum := 0;
  fDateidatum  := 0;
end;

function TDBDatei.getTableName: string;
begin
  Result := 'Datei';
end;

function TDBDatei.getTablePrefix: string;
begin
  Result := 'DA';
end;


function TDBDatei.getGeneratorName: string;
begin
  Result := 'DA_ID';
end;



procedure TDBDatei.FuelleDBFelder;
begin
  fFeldList.FieldByName('DA_ID').AsInteger           := fID;
  fFeldList.FieldByName('DA_DATEI').AsString         := fDatei;
  fFeldList.FieldByName('DA_DATEIDATUM').AsDateTime  := fDateidatum;
  fFeldList.FieldByName('DA_CHANGEDATUM').AsDateTime := fChangeDatum;
  inherited;
end;



procedure TDBDatei.LoadByQuery(aQuery: TIBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fDatei       := aQuery.FieldByName('DA_DATEI').AsString;
  fDateidatum  := aQuery.FieldByName('DA_DATEIDATUM').AsDateTime;
  fChangeDatum := aQuery.FieldByName('DA_CHANGEDATUM').AsDateTime;
  FuelleDBFelder;
end;


procedure TDBDatei.ReadDateiname(aDateiname: string);
begin
  Init;
  if not Assigned(fTrans) then
    exit;
  fQuery.Close;
  fQuery.Transaction := fTrans;
  fQuery.SQL.Text := 'select * from ' + getTableName + ' where da_datei = ' +QuotedStr(aDateiname);
  OpenTrans;
  try
    fQuery.Open;
    LoadByQuery(fQuery);
  finally
    CommitTrans;
  end;
end;

procedure TDBDatei.SaveToDB;
begin
  inherited;

end;

procedure TDBDatei.setChangeDatum(const Value: TDateTime);
begin
  UpdateV(fChangeDatum, Value);
  fFeldList.FieldByName('DA_CHANGEDATUM').AsDateTime := fChangeDatum;
end;

procedure TDBDatei.setDatei(const Value: string);
begin
  UpdateV(fDatei, Value);
  fFeldList.FieldByName('DA_DATEI').AsString := fDatei;
end;

procedure TDBDatei.setDateiDatum(const Value: TDateTime);
begin
  UpdateV(fDateidatum, Value);
  fFeldList.FieldByName('DA_DATEIDATUM').AsDateTime := fDateidatum;
end;




end.
