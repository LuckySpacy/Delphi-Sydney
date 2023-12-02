unit Objekt.InvestList;

interface

uses
  System.SysUtils, System.Classes, Objekt.Invest, Objekt.BasisList;

type
  TInvestList = class(TBasisList)
  private
    function getItem(Index: Integer): TInvest;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TInvest read getItem;
    function Add: TInvest;
    procedure SortProzDiff;
  end;


implementation

{ TInvestList }

function FloatSortierenAsc(Item1, Item2: Pointer): Integer;
var
  Val1: real;
  Val2: real;
begin
  Result := 0;
  Val1 := TInvest(Item1).ProzDiff;
  Val2 := TInvest(Item2).ProzDiff;
  if Val1 = Val2 then
    exit;
  if Val1 < Val2 then
    Result := -1
  else
    Result := 1;
end;



constructor TInvestList.Create;
begin
  inherited;

end;

destructor TInvestList.Destroy;
begin

  inherited;
end;

function TInvestList.getItem(Index: Integer): TInvest;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TInvest(fList.Items[Index]);
end;

function TInvestList.Add: TInvest;
begin
  Result := TInvest.Create;
  fList.Add(Result);
end;

procedure TInvestList.SortProzDiff;
begin
  fList.Sort(@FloatSortierenAsc)
end;


end.
