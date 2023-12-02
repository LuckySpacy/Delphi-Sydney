unit Mobil.ObjectList;

interface

uses
  System.Classes, System.SysUtils;

type
  TMobilObjectList = class
  private
    fList: TList;
    function Get(Index: Integer): Pointer;
    procedure Put(Index: Integer; const Value: Pointer);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Delete(aIndex: Integer);
    function Count: Integer;
    property Items[Index: Integer]: Pointer read Get write Put;
    function Add(Item: Pointer): Integer;
    procedure Sort(Compare: TListSortCompare);
    procedure Move(CurIndex, NewIndex: Integer);
  end;

implementation

{ TMobilObjectList }


constructor TMobilObjectList.Create;
begin
  fList := TList.Create;
  inherited;
end;


destructor TMobilObjectList.Destroy;
begin
  Clear;
  FreeAndNil(fList);
  inherited;
end;



procedure TMobilObjectList.Clear;
var
  x: TObject;
  i1: Integer;
begin
  for i1 := fList.Count -1 downto 0 do
  begin
    x := TObject(fList.Items[i1]);
    FreeAndNil(x);
  end;
  fList.Clear;
end;



function TMobilObjectList.Add(Item: Pointer): Integer;
begin
  Result := fList.Add(Item);
end;


function TMobilObjectList.Count: Integer;
begin
  Result := fList.Count;
end;



procedure TMobilObjectList.Delete(aIndex: Integer);
var
  x: TObject;
begin
  if aIndex > fList.Count -1 then
    exit;
   x := TObject(fList.Items[aIndex]);
  FreeAndNil(x);
  fList.Delete(aIndex);
end;


function TMobilObjectList.Get(Index: Integer): Pointer;
begin
  Result := fList.Items[Index];
end;

procedure TMobilObjectList.Move(CurIndex, NewIndex: Integer);
begin
  fList.Move(CurIndex, NewIndex);
end;

procedure TMobilObjectList.Put(Index: Integer; const Value: Pointer);
begin
  fList.Items[Index] := Value;
end;

procedure TMobilObjectList.Sort(Compare: TListSortCompare);
begin
  fList.Sort(Compare);
end;

end.
