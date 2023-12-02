unit Rest.GuVJahreList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.GuVJahre,
  Rest.Basis;


type
  TRestGuVJahreList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestGuVJahre;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestGuVJahre read getItem;
    function Add: TRestGuVJahre;
    function getItemIndex(aAkId: Integer): Integer;
    procedure CopyList(aRestGuVJahreList: TRestGuVJahreList);
    procedure FloatSort(aFieldname: string; const aAsc: Boolean = true);
    procedure StringSort(aFieldname: string; const aAsc: Boolean = true);
  end;

implementation

{ TRestGuVJahreList }


var
  SortFieldname: string;


function SortStringAsc(Item1, Item2: Pointer): Integer;
begin
  Result := AnsiCompareText(TRestGuVJahre(Item1).FeldList.FieldByName(SortFieldname).AsString, TRestGuVJahre(Item2).FeldList.FieldByName(SortFieldname).AsString);
end;

function SortStringDesc(Item1, Item2: Pointer): Integer;
begin
  Result := AnsiCompareText(TRestGuVJahre(Item2).FeldList.FieldByName(SortFieldname).AsString, TRestGuVJahre(Item1).FeldList.FieldByName(SortFieldname).AsString);
end;

function FloatSortierenAsc(Item1, Item2: Pointer): Integer;
var
  Val1: real;
  Val2: real;
begin
  Result := 0;
  Val1 := TRestGuVJahre(Item1).Runden(TRestGuVJahre(Item1).FeldList.FieldByName(SortFieldname).AsFloat, 4);
  Val2 := TRestGuVJahre(Item2).Runden(TRestGuVJahre(Item2).FeldList.FieldByName(SortFieldname).AsFloat, 4);
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
  Val1 := TRestGuVJahre(Item1).Runden(TRestGuVJahre(Item1).FeldList.FieldByName(SortFieldname).AsFloat, 4);
  Val2 := TRestGuVJahre(Item2).Runden(TRestGuVJahre(Item2).FeldList.FieldByName(SortFieldname).AsFloat, 4);
  if Val1 = Val2 then
    exit;
  if Val1 < Val2 then
    Result := 1
  else
    Result := -1;
end;



constructor TRestGuVJahreList.Create;
begin
  inherited;

end;

destructor TRestGuVJahreList.Destroy;
begin

  inherited;
end;


function TRestGuVJahreList.Add: TRestGuVJahre;
begin
  Result := TRestGuVJahre.Create;
  fList.Add(Result);
end;

function TRestGuVJahreList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestGuVJahreList.getItem(Index: Integer): TRestGuVJahre;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestGuVJahre(fList.Items[Index]);
end;

function TRestGuVJahreList.getItemIndex(aAkId: Integer): Integer;
var
  i1: Integer;
begin
  Result := -1;
  for i1 := 0 to fList.count -1 do
  begin
    if TRestGuVJahre(fList.Items[i1]).FeldList.FieldByName('AK_ID').AsInteger = aAkId then
    begin
      Result := i1;
      exit;
    end;
  end;
end;

procedure TRestGuVJahreList.CopyList(aRestGuVJahreList: TRestGuVJahreList);
var
  i1, i2: Integer;
  NeuRestGuVJahre: TRestGuVJahre;
  AltRestGuVJahre: TRestGuVJahre;
begin
  aRestGuVJahreList.Clear;
  for i1 := 0 to fList.Count -1 do
  begin
    AltRestGuVJahre := TRestGuVJahre(fList.Items[i1]);
    NeuRestGuVJahre := aRestGuVJahreList.Add;
    for i2 := 0 to AltRestGuVJahre.FeldList.Count -1 do
      NeuRestGuVJahre.FeldList.Feld[i2].AsString := AltRestGuVJahre.FeldList.Feld[i2].AsString;
  end;
end;


procedure TRestGuVJahreList.FloatSort(aFieldname: string; const aAsc: Boolean = true);
begin
  SortFieldname := aFieldname;
  if aAsc then
    fList.Sort(@FloatSortierenAsc)
  else
    fList.Sort(@FloatSortierenDesc)
end;


procedure TRestGuVJahreList.StringSort(aFieldname: string; const aAsc: Boolean = true);
begin
  SortFieldname := aFieldname;
  if aAsc then
    fList.Sort(@SortStringAsc)
  else
    fList.Sort(@SortStringDesc)
end;


end.
