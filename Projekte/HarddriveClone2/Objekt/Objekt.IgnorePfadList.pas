unit Objekt.IgnorePfadList;

interface

uses
  SysUtils, Classes, Objekt.Basislist, Objekt.IgnorePfad;

type
  TIgnorePfadList = class(TBasisList)
  private
    function getItem(Index: Integer): TIgnorePfad;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TIgnorePfad read getItem;
    function Add(aPfad: string; aExact: Boolean): TIgnorePfad;
  end;

implementation

{ TIgnorePfadList }


constructor TIgnorePfadList.Create;
begin
  inherited;
end;

destructor TIgnorePfadList.Destroy;
begin

  inherited;
end;

function TIgnorePfadList.getItem(Index: Integer): TIgnorePfad;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TIgnorePfad(fList.Items[Index]);
end;

function TIgnorePfadList.Add(aPfad: string; aExact: Boolean): TIgnorePfad;
begin
  Result := TIgnorePfad.Create;
  Result.Pfad  := aPfad;
  Result.Exact := aExact;
  fList.Add(Result);
end;


end.
