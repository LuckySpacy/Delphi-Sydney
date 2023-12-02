unit Objekt.GridAktieList;

interface

uses
  sysUtils, Classes, Mobil.ObjectList, Objekt.GridAktie, Mobil.BasisList;

type
  TGridAktieList = class(TMobilBasisList)
  private
    function getGridAktie(Index: Integer): TGridAktie;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TGridAktie;
    property Item[Index: Integer]: TGridAktie read getGridAktie;
    procedure StringSortAktie(const aAsc: Boolean = true);
    procedure setDepotToAllFalse;
  end;

implementation

{ TGridAktieList }


function SortStringAktie(Item1, Item2: Pointer): Integer;
begin
  Result := AnsiCompareText(TGridAktie(Item1).Aktie, TGridAktie(Item2).Aktie);
end;



constructor TGridAktieList.Create;
begin
  inherited;
end;

destructor TGridAktieList.Destroy;
begin

  inherited;
end;

function TGridAktieList.getGridAktie(Index: Integer): TGridAktie;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TGridAktie(fList.Items[Index]);
end;

procedure TGridAktieList.setDepotToAllFalse;
var
  i1: Integer;
begin
  for i1 := 0 to fList.Count -1 do
    TGridAktie(fList.Items[i1]).Depot := false;
end;

function TGridAktieList.Add: TGridAktie;
begin
  Result := TGridAktie.Create;
  fList.Add(Result);
end;


procedure TGridAktieList.StringSortAktie(const aAsc: Boolean = true);
begin
  if aAsc then
    fList.Sort(@SortStringAktie)
  else
    fList.Sort(@SortStringAktie)
end;


end.
