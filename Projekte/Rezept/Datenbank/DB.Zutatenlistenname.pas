unit DB.Zutatenlistenname;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, DB.Basis, Data.db,
  DB.RezeptZutatenList, Objekt.MultiQuery;

type
  TDBZutatenlistenname = class(TDBBasis)
  private
    fZutatenname: string;
    fDBRezeptzutatenList: TDBRezeptzutatenList;
    procedure setZutatenname(const Value: string);
  protected
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
    property ZutatenName: string read fZutatenname write setZutatenname;
    function Delete: Boolean; override;
  end;

implementation

{ TDBZutatenliste }

constructor TDBZutatenlistenname.Create(AOwner: TComponent);
begin
  inherited;
  FFeldList.Add('ZL_NAME', ftString);
  LegeHistorieFelderAn;
  fDBRezeptzutatenList := TDBRezeptzutatenList.Create;
  Init;
end;

function TDBZutatenlistenname.Delete: Boolean;
var
  i1: Integer;
begin
  Result := inherited;
  fDBRezeptzutatenList.Trans := fTrans;
  fDBRezeptzutatenList.ReadAllVonZlId(fId);
  for i1 := 0 to fDBRezeptzutatenList.Count -1 do
  begin
    fDBRezeptzutatenList.Item[i1].Delete;
  end;
end;

destructor TDBZutatenlistenname.Destroy;
begin
  FreeAndNil(fDBRezeptzutatenList);
  inherited;
end;


procedure TDBZutatenlistenname.Init;
begin
  inherited;
  fZutatenname := '';
  FuelleDBFelder;
end;


function TDBZutatenlistenname.getGeneratorName: string;
begin
  Result := 'ZL_ID';
end;

function TDBZutatenlistenname.getTableName: string;
begin
  Result := 'ZUTATENLISTENNAME';
end;

function TDBZutatenlistenname.getTablePrefix: string;
begin
  Result := 'ZL';
end;



procedure TDBZutatenlistenname.FuelleDBFelder;
begin
  fFeldList.FieldByName('ZL_ID').AsInteger  := fID;
  fFeldList.FieldByName('ZL_NAME').AsString := fZutatenname;
  inherited;
end;



procedure TDBZutatenlistenname.LoadByQuery(aQuery: TMultiQuery);
begin
  inherited;
  if aQuery.Eof then
    exit;
  fZutatenname   := aQuery.FieldByName('ZL_NAME').AsString;
  FuelleDBFelder;
end;

procedure TDBZutatenlistenname.SaveToDB;
begin
  inherited;

end;

procedure TDBZutatenlistenname.setZutatenname(const Value: string);
begin
  UpdateV(fZutatenname, Value);
  fFeldList.FieldByName('ZL_NAME').AsString := Value;
end;

end.
