unit DB.Job;

interface


uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db;

type
  TDBJob = class(TDBBasis)
  private
    fQuellpfad: string;
    fPrio: Integer;
    fZielpfad: string;
    fAktiv: Boolean;
    procedure setAktiv(const Value: Boolean);
 protected
    function getGeneratorName: string; override;
    function getTableName: string; override;
    function getTablePrefix: string; override;
    procedure FuelleDBFelder; override;
    procedure setPrio(const Value: Integer);
    procedure setQuellpfad(const Value: string);
    procedure setZielpfad(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure LoadByQuery(aQuery: TIBQuery); override;
    procedure SaveToDB; override;
    property Quellpfad: string read fQuellpfad write setQuellpfad;
    property Zielpfad: string read fZielpfad write setZielpfad;
    property Prio: Integer read fPrio write setPrio;
    property Aktiv: Boolean read fAktiv write setAktiv;
  end;


implementation

{ TDBJob }

constructor TDBJob.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('JO_QUELLPFAD', ftString);
  FFeldList.Add('JO_ZIELPFAD', ftString);
  FFeldList.Add('JO_PRIO', ftInteger);
  FFeldList.Add('JO_AKTIV', ftString);
  LegeHistorieFelderAn;
  Init;
end;

destructor TDBJob.Destroy;
begin

  inherited;
end;

procedure TDBJob.Init;
begin
  inherited;
  fQuellpfad := '';
  fPrio      := 0;
  fZielpfad  := '';
end;

function TDBJob.getTableName: string;
begin
  Result := 'Job';
end;

function TDBJob.getTablePrefix: string;
begin
  Result := 'JO';
end;

function TDBJob.getGeneratorName: string;
begin
  Result := 'JO_ID';
end;


procedure TDBJob.FuelleDBFelder;
begin
  fFeldList.FieldByName('JO_ID').AsInteger  := fID;
  fFeldList.FieldByName('JO_QUELLPFAD').AsString  := fQuellpfad;
  fFeldList.FieldByName('JO_ZIELPFAD').AsString   := fZielpfad;
  fFeldList.FieldByName('JO_PRIO').AsInteger      := fPrio;
  fFeldList.FieldByName('JO_AKTIV').AsBoolean     := fAktiv;
  inherited;
end;


procedure TDBJob.LoadByQuery(aQuery: TIBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fQuellpfad   := aQuery.FieldByName('JO_QUELLPFAD').AsString;
  fZielpfad    := aQuery.FieldByName('JO_ZIELPFAD').AsString;
  fPrio        := aQuery.FieldByName('JO_PRIO').AsInteger;
  fAktiv       := Trim(aQuery.FieldByName('JO_AKTIV').AsString) = 'T';
  FuelleDBFelder;
end;

procedure TDBJob.SaveToDB;
begin
  inherited;

end;

procedure TDBJob.setAktiv(const Value: Boolean);
begin
  UpdateV(fAktiv, Value);
  fFeldList.FieldByName('JO_AKTIV').AsBoolean := fAktiv;
end;

procedure TDBJob.setPrio(const Value: Integer);
begin
  UpdateV(fPrio, Value);
  fFeldList.FieldByName('JO_PRIO').AsInteger := Value;
end;

procedure TDBJob.setQuellpfad(const Value: string);
begin
  UpdateV(fQuellpfad, Value);
  fFeldList.FieldByName('JO_QUELLPFAD').AsString := Value;
end;

procedure TDBJob.setZielpfad(const Value: string);
begin
  UpdateV(fZielpfad, Value);
  fFeldList.FieldByName('JO_ZIELPFAD').AsString := Value;
end;

end.
