unit Objekt.FeldList;

interface

uses
  SysUtils, Classes, Objekt.BasisList, Objekt.Feld, Data.DB, System.Contnrs;

type
  TFeldList = class(TBasisList)
  private
    function getFeld(aIndex: Integer): TFeld;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add(aName: string; aDataType: TFieldType): TFeld;
    function FieldByName(aName: string): TFeld;
    property Feld[aIndex: Integer]: TFeld read getFeld;
    procedure SetChangedToAll(aChanged: Boolean);
  end;

implementation

constructor TFeldList.Create;
begin
  inherited;

end;

destructor TFeldList.Destroy;
begin

  inherited;
end;



function TFeldList.Add(aName: string; aDataType: TFieldType): TFeld;
begin
  Result := TFeld.Create(nil);
  Result.Feldname := aName;
  Result.DataType := aDataType;
  fList.Add(Result);
end;


function TFeldList.FieldByName(aName: string): TFeld;
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

function TFeldList.getFeld(aIndex: Integer): TFeld;
begin
  Result := nil;
  if aIndex > fList.Count then
    exit;
  Result := TFeld(fList.Items[aIndex]);
end;



procedure TFeldList.SetChangedToAll(aChanged: Boolean);
var
  i1: Integer;
begin
  for i1 := 0 to fList.Count -1 do
    Feld[i1].Changed := aChanged;
end;

end.
