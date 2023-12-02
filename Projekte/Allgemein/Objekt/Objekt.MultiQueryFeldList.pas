unit Objekt.MultiQueryFeldList;

interface

uses
  SysUtils, Classes, Objekt.BasisList, Objekt.MultiQueryFeld, Data.DB, System.Contnrs,
  FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TMultiQueryFeldList = class(TBasisList)
  private
    function getFeld(aIndex: Integer): TMultiQueryFeld;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function AddIB(aParam: TParam): TMultiQueryFeld;
    function AddFD(aParam: TFDParam): TMultiQueryFeld;
    function FieldByName(aName: string): TMultiQueryFeld;
    property Feld[aIndex: Integer]: TMultiQueryFeld read getFeld;
  end;


implementation

{ TMultiQueryFeldList }

constructor TMultiQueryFeldList.Create;
begin
  inherited;

end;

destructor TMultiQueryFeldList.Destroy;
begin

  inherited;
end;


function TMultiQueryFeldList.AddFD(aParam: TFDParam): TMultiQueryFeld;
begin
  Result := TMultiQueryFeld.Create(nil);
  Result.FDParam := aParam;
  fList.Add(Result);
end;

function TMultiQueryFeldList.AddIB(aParam: TParam): TMultiQueryFeld;
begin
  Result := TMultiQueryFeld.Create(nil);
  Result.IBParam := aParam;
  fList.Add(Result);
end;


function TMultiQueryFeldList.FieldByName(aName: string): TMultiQueryFeld;
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

function TMultiQueryFeldList.getFeld(aIndex: Integer): TMultiQueryFeld;
begin
  Result := nil;
  if aIndex > fList.Count then
    exit;
  Result := TMultiQueryFeld(fList.Items[aIndex]);
end;

end.
