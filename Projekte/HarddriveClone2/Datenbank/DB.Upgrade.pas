unit DB.Upgrade;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, DB.Basis, IBX.IBQuery;

type
  TDBUpgrade = class(TDBBasis)
  private
    fId: Integer;
    fDatum: string;
    procedure setDatum(const Value: string);
  protected
    function getGeneratorName: string; override;
    function getTableName: string; override;
    function getTablePrefix: string; override;
    procedure FuelleDBFelder; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init;
    function Insert: Boolean;
    function Read(aId: Integer): Boolean;
    property Id: Integer read fId write fId;
    property Datum: string read fDatum write setDatum;
    procedure LoadByQuery(aQuery: TIBQuery); override;
    function LastUpdate: string;
  end;

implementation

{ TDBUpgrade }


constructor TDBUpgrade.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('up_datum', ftString);
  LegeHistorieFelderAn;
  Init;
end;

destructor TDBUpgrade.Destroy;
begin

  inherited;
end;

procedure TDBUpgrade.FuelleDBFelder;
begin
  fFeldList.FieldByName('UP_ID').AsInteger  := fID;
  fFeldList.FieldByName('UP_DATUM').AsString := fDatum;

  inherited;
end;

function TDBUpgrade.getGeneratorName: string;
begin
  Result := 'UP_ID';
end;

function TDBUpgrade.getTableName: string;
begin
  Result := 'upgrade';
end;

function TDBUpgrade.getTablePrefix: string;
begin
  Result := 'UP';
end;

procedure TDBUpgrade.Init;
begin
  fId    := 0;
  fDatum := '';
end;

function TDBUpgrade.Insert: Boolean;
var
  s: string;
begin
  Result := true;
  try
    s := 'insert into upgrade (up_datum) values (:datum)';
    fQuery.SQL.Text := s;
    fQuery.ParamByName('datum').AsString := fDatum;
    fQuery.ExecSQL;
  except
    on E: Exception do
    begin
      //BasCloud.Error := E.Message;
    end;
  end;
end;

procedure TDBUpgrade.LoadByQuery(aQuery: TIBQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fId          := aQuery.FieldByName('up_id').AsInteger;
  fDatum       := aQuery.FieldByName('up_datum').AsString;
  FuelleDBFelder;
end;

function TDBUpgrade.Read(aId: Integer): Boolean;
var
  s: string;
begin
  Result := false;
  s := 'select * from upgrade where up_id = :id';
  fQuery.Close;
  fQuery.SQL.Text := s;
  fQuery.ParamByName('id').AsInteger := aId;
  fQuery.Open;
  Init;
  if not fQuery.Eof then
  begin
    LoadByQuery(fQuery);
    Result := true;
  end;
end;

procedure TDBUpgrade.setDatum(const Value: string);
begin
  UpdateV(fDatum, Value);
  fFeldList.FieldByName('UP_DATUM').AsString := fDatum;
end;

function TDBUpgrade.LastUpdate: string;
var
  s: string;
begin
  Result := '';
  fQuery.Transaction := fTrans;
  s := 'select * from upgrade order by up_datum desc';
  fQuery.Close;
  fQuery.SQL.Text := s;
  fQuery.Open;
  Init;
  if not fQuery.Eof then
  begin
    LoadByQuery(fQuery);
    Result := fDatum;
  end;
end;


end.
