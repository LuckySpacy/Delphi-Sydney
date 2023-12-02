unit Rest.DepotwerteList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.Depotwerte,
  Rest.Basis;


type
  TRestDepotwerteList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestDepotwerte;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestDepotwerte read getItem;
    function Add: TRestDepotwerte;
    function getItemIndex(aAkId: Integer): Integer;
    procedure CopyList(aRestDepotwerteList: TRestDepotwerteList);
    function AktieInDepot(aAkId, aDpId: Integer): Boolean;
  end;

implementation

{ TRestDepotwerteList }


constructor TRestDepotwerteList.Create;
begin
  inherited;

end;

destructor TRestDepotwerteList.Destroy;
begin

  inherited;
end;

function TRestDepotwerteList.getItem(Index: Integer): TRestDepotwerte;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestDepotwerte(fList.Items[Index]);
end;

function TRestDepotwerteList.getItemIndex(aAkId: Integer): Integer;
var
  i1: Integer;
begin
  Result := -1;
  for i1 := 0 to fList.count -1 do
  begin
    if TRestDepotwerte(fList.Items[i1]).FeldList.FieldByName('AK_ID').AsInteger = aAkId then
    begin
      Result := i1;
      exit;
    end;
  end;
end;

function TRestDepotwerteList.Add: TRestDepotwerte;
begin
  Result := TRestDepotwerte.Create;
  fList.Add(Result);
end;

function TRestDepotwerteList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;

function TRestDepotwerteList.AktieInDepot(aAkId, aDpId: Integer): Boolean;
var
  i1: Integer;
begin
  Result := false;
  for i1 := 0 to fList.Count -1 do
  begin
    if TRestDepotwerte(fList.Items[i1]).FeldList.FieldByName('DW_DP_ID').AsInteger <> aDpId then
      continue;
    if TRestDepotwerte(fList.Items[i1]).FeldList.FieldByName('DW_AK_ID').AsInteger = aAkId then
    begin
      Result := true;
      break;
    end;
  end;

end;

procedure TRestDepotwerteList.CopyList(
  aRestDepotwerteList: TRestDepotwerteList);
var
  i1, i2: Integer;
  NeuRestDepotwerte: TRestDepotwerte;
  AltRestDepotwerte: TRestDepotwerte;
begin
  aRestDepotwerteList.Clear;
  for i1 := 0 to fList.Count -1 do
  begin
    AltRestDepotwerte := TRestDepotwerte(fList.Items[i1]);
    NeuRestDepotwerte := aRestDepotwerteList.Add;
    for i2 := 0 to AltRestDepotwerte.FeldList.Count -1 do
      NeuRestDepotwerte.FeldList.Feld[i2].AsString := AltRestDepotwerte.FeldList.Feld[i2].AsString;
  end;
end;


end.
