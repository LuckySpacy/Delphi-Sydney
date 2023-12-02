unit Rest.RezeptList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.Rezept,
  Rest.Basis;


type
  TRestRezeptList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestRezept;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestRezept read getItem;
    function Add: TRestRezept;
  end;

implementation

{ TRestRezeptList }





constructor TRestRezeptList.Create;
begin
  inherited;

end;

destructor TRestRezeptList.Destroy;
begin

  inherited;
end;

function TRestRezeptList.getItem(Index: Integer): TRestRezept;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestRezept(fList.Items[Index]);
end;




function TRestRezeptList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestRezeptList.Add: TRestRezept;
begin
  Result := TRestRezept.Create;
  fList.Add(Result);
end;


end.
