unit Mobil.FeldList;

interface

uses
  SysUtils, Classes, Mobil.Feld, Data.DB, Mobil.BasisList;
type
  TMobilFeldList = class(TMobilBasisList)
  private
    function getFeld(aIndex: Integer): TMobilFeld;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add(aName: string; aDataType: TFieldType): TMobilFeld;
    function FieldByName(aName: string): TMobilFeld;
    property Feld[aIndex: Integer]: TMobilFeld read getFeld;
    procedure SetChangedToAll(aChanged: Boolean);
  end;

implementation

{ TMobilFeldList }

constructor TMobilFeldList.Create;
begin
  inherited;

end;

destructor TMobilFeldList.Destroy;
begin

  inherited;
end;


function TMobilFeldList.Add(aName: string; aDataType: TFieldType): TMobilFeld;
begin
  Result := TMobilFeld.Create(nil);
  Result.Feldname := aName;
  Result.DataType := aDataType;
  fList.Add(Result);
end;


function TMobilFeldList.FieldByName(aName: string): TMobilFeld;
var
  i1: Integer;
begin
  Result := nil;
  for i1 := 0 to fList.Count -1 do
  begin
    if SameText(Feld[i1].Feldname, aName) then
    begin
      Result := Feld[i1];
      exit;
    end;
  end;
end;


function TMobilFeldList.getFeld(aIndex: Integer): TMobilFeld;
begin
  Result := nil;
  if aIndex > fList.Count then
    exit;
  Result := TMobilFeld(fList.Items[aIndex]);
end;

procedure TMobilFeldList.SetChangedToAll(aChanged: Boolean);
var
  i1: Integer;
begin
  for i1 := 0 to fList.Count -1 do
    Feld[i1].Changed := aChanged;
end;

end.
