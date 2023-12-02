unit Rest.DepotnameList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.Depotname,
  Rest.Basis;

type
  TRestDepotnameList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestDepotname;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestDepotname read getItem;
    function Add: TRestDepotname;
  end;

implementation

{ TRestDepotnameList }

constructor TRestDepotnameList.Create;
begin
  inherited;

end;

destructor TRestDepotnameList.Destroy;
begin

  inherited;
end;


function TRestDepotnameList.Add: TRestDepotname;
begin
  Result := TRestDepotname.Create;
  fList.Add(Result);
end;

function TRestDepotnameList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestDepotnameList.getItem(Index: Integer): TRestDepotname;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestDepotname(fList.Items[Index]);
end;

end.
