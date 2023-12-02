unit Rest.ObjectList;

interface

uses
  System.Classes, System.SysUtils;

type
  TRestObjectList = class
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

  end;

implementation

{ TRestObjectList }



constructor TRestObjectList.Create;
begin
  fList := TList.Create;
end;


destructor TRestObjectList.Destroy;
begin
  Clear;
  FreeAndNil(fList);
  inherited;
end;


function TRestObjectList.Add(Item: Pointer): Integer;
begin
  Result := fList.Add(Item);
end;

procedure TRestObjectList.Clear;
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

procedure TRestObjectList.Delete(aIndex: Integer);
var
  x: TObject;
begin
  if aIndex > fList.Count -1 then
    exit;
   x := TObject(fList.Items[aIndex]);
  FreeAndNil(x);
  fList.Delete(aIndex);
end;

function TRestObjectList.Count: Integer;
begin
  Result := fList.Count;
end;


function TRestObjectList.Get(Index: Integer): Pointer;
begin
  Result := fList.Items[Index];
end;

procedure TRestObjectList.Put(Index: Integer; const Value: Pointer);
begin
  fList.Items[Index] := Value;
end;


end.
