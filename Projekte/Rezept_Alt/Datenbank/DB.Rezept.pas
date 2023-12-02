unit DB.Rezept;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, FireDAC.Comp.Client, DB.Basis, Data.db;

type
  TDBRezept = class(TDBBasis)
  private
    fRezeptname: string;
    procedure setRezeptname(const Value: string);
 protected
    function getGeneratorName: string; override;
    function getTableName: string; override;
    function getTablePrefix: string; override;
    procedure FuelleDBFelder; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure LoadByQuery(aQuery: TFDQuery); override;
    procedure SaveToDB; override;
    property Rezeptname: string read fRezeptname write setRezeptname;
  end;


implementation

{ TDBRezept }

constructor TDBRezept.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('RZ_NAME', ftString);
end;

destructor TDBRezept.Destroy;
begin

  inherited;
end;

function TDBRezept.getGeneratorName: string;
begin
  Result := 'RZ_ID';
end;



function TDBRezept.getTableName: string;
begin
  Result := 'rezept';
end;

function TDBRezept.getTablePrefix: string;
begin
  Result := 'RZ';
end;

procedure TDBRezept.Init;
begin
  inherited;
  fRezeptname := '';
end;

procedure TDBRezept.FuelleDBFelder;
begin
  fFeldList.FieldByName('RZ_ID').AsInteger  := fID;
  fFeldList.FieldByName('RZ_NAME').AsString := fRezeptname;
  inherited;
end;


procedure TDBRezept.LoadByQuery(aQuery: TFDQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fRezeptname := aQuery.FieldByName('RZ_NAME').AsString;
  FuelleDBFelder;
end;

procedure TDBRezept.SaveToDB;
begin
  inherited;

end;

procedure TDBRezept.setRezeptname(const Value: string);
begin
  UpdateV(fRezeptname, Value);
  fFeldList.FieldByName('RZ_NAME').AsString := fRezeptname;
end;

end.
