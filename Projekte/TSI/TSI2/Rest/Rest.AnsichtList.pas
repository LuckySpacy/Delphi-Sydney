unit Rest.AnsichtList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.Ansicht,
  Rest.Basis;


type
  TRestAnsichtList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestAnsicht;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestAnsicht read getItem;
    function Add: TRestAnsicht;
    procedure FloatSort(aFieldname: string; const aAsc: Boolean = true);
    procedure StringSort(aFieldname: string; const aAsc: Boolean = true);
    procedure DateSort(aFieldname: string; const aAsc: Boolean = true);
    procedure CopyList(aRestAnsichtList: TRestAnsichtList);
    function getItemIndex(aAkId: Integer): Integer;
  end;

implementation

{ TRestRezeptList }

uses
  System.DateUtils;

var
  SortFieldname: string;



function SortStringAsc(Item1, Item2: Pointer): Integer;
begin
  Result := AnsiCompareText(TRestAnsicht(Item1).FeldList.FieldByName(SortFieldname).AsString, TRestAnsicht(Item2).FeldList.FieldByName(SortFieldname).AsString);
end;

function SortStringDesc(Item1, Item2: Pointer): Integer;
begin
  Result := AnsiCompareText(TRestAnsicht(Item2).FeldList.FieldByName(SortFieldname).AsString, TRestAnsicht(Item1).FeldList.FieldByName(SortFieldname).AsString);
end;


function SortDateAsc(Item1, Item2: Pointer): Integer;
begin
  Result := CompareDate(TRestAnsicht(Item1).FeldList.FieldByName(SortFieldname).AsDateTime, TRestAnsicht(Item2).FeldList.FieldByName(SortFieldname).AsDateTime);
end;

function SortDateDesc(Item1, Item2: Pointer): Integer;
begin
  Result := CompareDate(TRestAnsicht(Item2).FeldList.FieldByName(SortFieldname).AsDateTime, TRestAnsicht(Item1).FeldList.FieldByName(SortFieldname).AsDateTime);
end;


function FloatSortierenAsc(Item1, Item2: Pointer): Integer;
var
  Val1: real;
  Val2: real;
begin
  Result := 0;
  Val1 := TRestAnsicht(Item1).Runden(TRestAnsicht(Item1).FeldList.FieldByName(SortFieldname).AsFloat, 4);
  Val2 := TRestAnsicht(Item2).Runden(TRestAnsicht(Item2).FeldList.FieldByName(SortFieldname).AsFloat, 4);
  if Val1 = Val2 then
    exit;
  if Val1 < Val2 then
    Result := -1
  else
    Result := 1;
end;

function FloatSortierenDesc(Item1, Item2: Pointer): Integer;
var
  Val1: real;
  Val2: real;
begin
  Result := 0;
  Val1 := TRestAnsicht(Item1).Runden(TRestAnsicht(Item1).FeldList.FieldByName(SortFieldname).AsFloat, 4);
  Val2 := TRestAnsicht(Item2).Runden(TRestAnsicht(Item2).FeldList.FieldByName(SortFieldname).AsFloat, 4);
  if Val1 = Val2 then
    exit;
  if Val1 < Val2 then
    Result := 1
  else
    Result := -1;
end;


constructor TRestAnsichtList.Create;
begin
  inherited;

end;

destructor TRestAnsichtList.Destroy;
begin

  inherited;
end;

function TRestAnsichtList.getItem(Index: Integer): TRestAnsicht;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestAnsicht(fList.Items[Index]);
end;





function TRestAnsichtList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestAnsichtList.Add: TRestAnsicht;
begin
  Result := TRestAnsicht.Create;
  fList.Add(Result);
end;


procedure TRestAnsichtList.FloatSort(aFieldname: string; const aAsc: Boolean = true);
begin
  SortFieldname := aFieldname;
  if aAsc then
    fList.Sort(@FloatSortierenAsc)
  else
    fList.Sort(@FloatSortierenDesc)
end;


procedure TRestAnsichtList.StringSort(aFieldname: string; const aAsc: Boolean = true);
begin
  SortFieldname := aFieldname;
  if aAsc then
    fList.Sort(@SortStringAsc)
  else
    fList.Sort(@SortStringDesc)
end;


procedure TRestAnsichtList.DateSort(aFieldname: string; const aAsc: Boolean = true);
begin
  SortFieldname := aFieldname;
  if aAsc then
    fList.Sort(@SortDateAsc)
  else
    fList.Sort(@SortDateDesc)
end;




procedure TRestAnsichtList.CopyList(aRestAnsichtList: TRestAnsichtList);
var
  i1, i2: Integer;
  NeuRestAnsicht: TRestAnsicht;
  AltRestAnsicht: TRestAnsicht;
  //CountList1, CountList2: Integer;
begin
  aRestAnsichtList.Clear;
  for i1 := 0 to fList.Count -1 do
  begin
    AltRestAnsicht := TRestAnsicht(fList.Items[i1]);
    if AltRestAnsicht.FieldByName('AK_AKTIV').AsString <> 'T' then
      continue;
    NeuRestAnsicht := aRestAnsichtList.Add;
    //CountList1 := AltRestAnsicht.FeldList.Count;
    //CountList2 := NeuRestAnsicht.FeldList.Count;
    //if CountList1 <> CountList2 then
    //  exit;
    for i2 := 0 to AltRestAnsicht.FeldList.Count -1 do
      NeuRestAnsicht.FeldList.Feld[i2].AsString := AltRestAnsicht.FeldList.Feld[i2].AsString;
  end;
end;


function TRestAnsichtList.getItemIndex(aAkId: Integer): Integer;
var
  i1: Integer;
begin
  Result := -1;
  for i1 := 0 to fList.count -1 do
  begin
    if TRestAnsicht(fList.Items[i1]).FeldList.FieldByName('AK_ID').AsInteger = aAkId then
    begin
      Result := i1;
      exit;
    end;
  end;
end;


end.

