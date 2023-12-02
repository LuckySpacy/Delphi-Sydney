unit Objekt.VergleichRezeptZutatList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Objekt.VergleichRezeptZutat;

type
  TVergleichRezeptZutatList = class(TBasisList)
  private
    function getVergleichRezeptZutat(Index: Integer): TVergleichRezeptZutat;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TVergleichRezeptZutat;
    property Item[Index: Integer]: TVergleichRezeptZutat read getVergleichRezeptZutat;
    procedure DeleteById(aId: Integer);
    function getItemById(aId: Integer): TVergleichRezeptZutat;
  end;

implementation

{ TVergleichRezeptZutatList }



constructor TVergleichRezeptZutatList.Create;
begin
  inherited;
end;


destructor TVergleichRezeptZutatList.Destroy;
begin

  inherited;
end;


function TVergleichRezeptZutatList.getItemById(aId: Integer): TVergleichRezeptZutat;
var
  i1: Integer;
begin
  Result := nil;
  for i1 := 0 to fList.Count -1 do
  begin
    if TVergleichRezeptZutat(fList.Items[i1]).Id = aId then
    begin
      Result := TVergleichRezeptZutat(fList.Items[i1]);
      exit;
    end;
  end;
end;

procedure TVergleichRezeptZutatList.DeleteById(aId: Integer);
var
  i1: Integer;
begin
  for i1 := fList.Count -1 downto 0 do
  begin
    if TVergleichRezeptZutat(fList.Items[i1]).Id = aId then
    begin
      fList.Delete(i1);
      exit;
    end;
  end;
end;



function TVergleichRezeptZutatList.getVergleichRezeptZutat(Index: Integer): TVergleichRezeptZutat;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TVergleichRezeptZutat(fList[Index]);
end;

function TVergleichRezeptZutatList.Add: TVergleichRezeptZutat;
begin
  Result := TVergleichRezeptZutat.Create;
  fList.Add(Result);
end;

end.
