unit Objekt.FormPointerList;

interface

uses
  SysUtils, Classes, System.Contnrs, Objekt.BasisList, Objekt.FormPointer;

type
  TFormPointerList = class(TBasisList)
  private
    function getItem(Index: Integer): TFormPointer;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index: Integer]: TFormPointer read getItem;
    function Add: TFormPointer;
  end;

implementation

{ TFormPointerList }


constructor TFormPointerList.Create;
begin
  inherited;

end;

destructor TFormPointerList.Destroy;
begin

  inherited;
end;

function TFormPointerList.getItem(Index: Integer): TFormPointer;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TFormPointer(fList.Items[Index]);
end;

function TFormPointerList.Add: TFormPointer;
begin
  Result := TFormPointer.Create;
  fList.Add(Result);
end;


end.
