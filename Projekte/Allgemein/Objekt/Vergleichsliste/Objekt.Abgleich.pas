unit Objekt.Abgleich;

interface

uses
  SysUtils, Classes, Objekt.VergleichList, Objekt.Vergleich;

type
  TChangeListEvent = procedure(aId: Integer) of object;
  TAbgleich = class
  private
    fZielList: TVergleichList;
    fQuellList: TVergleichList;
    fOnChangeList: TChangeListEvent;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function Ziellist: TVergleichList;
    function QuellList: TVergleichList;
    function AddZiellist(aId: Integer; aBez: string; aObjects: TObject): Integer;
    function AddQuellList(aId: Integer; aBez: string; aObjects: TObject): Integer;
    procedure FromQuellToZiel(aId: Integer; const aObject: TObject = nil);
    procedure FromZielToQuell(aId: Integer);
    function IdInZielList(aId: Integer): Boolean;
    property OnChangeList: TChangeListEvent read fOnChangeList write fOnChangeList;
  end;

implementation

{ TAbgleich }


constructor TAbgleich.Create;
begin
  fZielList  := TVergleichList.Create;
  fQuellList := TVergleichList.Create;
end;

destructor TAbgleich.Destroy;
begin
  FreeAndNil(fZielList);
  FreeAndNil(fQuellList);
  inherited;
end;



function TAbgleich.QuellList: TVergleichList;
begin
  Result := fQuellList;
end;

function TAbgleich.Ziellist: TVergleichList;
begin
  Result := fZiellist;
end;


function TAbgleich.AddZiellist(aId: Integer; aBez: string; aObjects: TObject): Integer;
var
  Vergleich: TVergleich;
begin
  Result := 0;
  if fZiellist.getItemById(aId) <> nil then
  begin
    Result := -1;
    exit;
  end;
  Vergleich := fZiellist.Add;
  Vergleich.Id := aId;
  Vergleich.Bez := aBez;
  Vergleich.Objects := aObjects;
end;


function TAbgleich.AddQuelllist(aId: Integer; aBez: string; aObjects: TObject): Integer;
var
  Vergleich: TVergleich;
begin
  Result := 0;
  if fQuellList.getItemById(aId) <> nil then
  begin
    Result := -1;
    exit;
  end;
  Vergleich := fQuellList.Add;
  Vergleich.Id := aId;
  Vergleich.Bez := aBez;
  Vergleich.Objects := aObjects;
end;

procedure TAbgleich.FromQuellToZiel(aId: Integer; const aObject: TObject = nil);
var
  Vergleich: TVergleich;
begin
  Vergleich := fQuellList.getItemById(aId);
  if Vergleich = nil then
    exit;
  AddZiellist(aId, Vergleich.Bez, aObject);
  fQuellList.DeleteById(aId);
  if Assigned(fOnChangeList) then
    fOnChangeList(aId);
end;


procedure TAbgleich.FromZielToQuell(aId: Integer);
var
  Vergleich: TVergleich;
begin
  Vergleich := fZielList.getItemById(aId);
  if Vergleich = nil then
    exit;
  AddQuellList(aId, Vergleich.Bez, Vergleich);
  fZielList.DeleteById(aId);
  if Assigned(fOnChangeList) then
    fOnChangeList(aId);
end;

function TAbgleich.IdInZielList(aId: Integer): Boolean;
var
  i1: Integer;
begin
  Result := false;
  for i1 := 0 to fZielList.Count -1 do
  begin
    if fZielList.Item[i1].Id = aId then
    begin
      Result := true;
      exit;
    end;
  end;
end;

end.
