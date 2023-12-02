unit Objekt.VergleichList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Objekt.Vergleich;

type
  TVergleichList = class(TBasisList)
  private
    function getVergleich(Index: Integer): TVergleich;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TVergleich;
    property Item[Index: Integer]: TVergleich read getVergleich;
    function getItemBySortId(aId: Integer): TVergleich;
    function getItemById(aId: Integer): TVergleich;
    procedure DeleteById(aId: Integer);
    procedure SortBez;
  end;

implementation

{ TVergleichList }


function IdSort(Item1, Item2: Pointer): Integer;
var
  Value1, Value2: Integer;
begin
  Value1 := TVergleich(Item1).id;
  Value2 := TVergleich(Item2).Id;
  if Value1 < Value2 then
    Result := -1
  else if Value2 < Value1 then
    Result := 1
  else
    Result := 0;
end;


function BezSortieren(Item1, Item2: Pointer): Integer;
begin
  Result := AnsiCompareText(TVergleich(Item1).Bez, TVergleich(Item2).Bez);
end;


constructor TVergleichList.Create;
begin
  inherited;
end;


destructor TVergleichList.Destroy;
begin

  inherited;
end;


function TVergleichList.getItemById(aId: Integer): TVergleich;
var
  i1: Integer;
begin
  Result := nil;
  for i1 := 0 to fList.Count -1 do
  begin
    if TVergleich(fList.Items[i1]).Id = aId then
    begin
      Result := TVergleich(fList.Items[i1]);
      exit;
    end;
  end;
end;

procedure TVergleichList.DeleteById(aId: Integer);
var
  i1: Integer;
begin
  for i1 := fList.Count -1 downto 0 do
  begin
    if TVergleich(fList.Items[i1]).Id = aId then
    begin
      fList.Delete(i1);
      exit;
    end;
  end;
end;


function TVergleichList.getItemBySortId(aId: Integer): TVergleich;
var
  L, R, M : Integer;
  AktId: Integer;
begin
  Result := nil;

  L := 0;
  R := fList.Count;

  while (L <= R) and (Result = nil) do
  begin
    M := (L+R) div 2;
    if M > fList.Count -1 then
    begin
      Result := nil;
      exit;
    end;
    AktId := TVergleich(fList.Items[M]).Id;
    if aId < AktId then
      R := M - 1;
    if aId > AktId then
      L := M + 1;
    if aId = AktId then
      Result := TVergleich(fList.Items[M]);
  end;

end;

function TVergleichList.getVergleich(Index: Integer): TVergleich;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TVergleich(fList[Index]);
end;

procedure TVergleichList.SortBez;
begin
  fList.Sort(@BezSortieren);
end;

function TVergleichList.Add: TVergleich;
begin
  Result := TVergleich.Create;
  fList.Add(Result);
end;


end.
