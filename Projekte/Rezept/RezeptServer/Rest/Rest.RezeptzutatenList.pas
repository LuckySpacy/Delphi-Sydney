unit Rest.RezeptzutatenList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.RezeptZutaten,
  Rest.Basis;


type
  TRestRezeptZutatenList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestRezeptzutaten;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestRezeptzutaten read getItem;
    function Add: TRestRezeptzutaten;
  end;

implementation

{ TRestRezeptZutatenList }


constructor TRestRezeptZutatenList.Create;
begin
  inherited;

end;

destructor TRestRezeptZutatenList.Destroy;
begin

  inherited;
end;

function TRestRezeptZutatenList.getItem(Index: Integer): TRestRezeptzutaten;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestRezeptzutaten(fList.Items[Index]);
end;




function TRestRezeptZutatenList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestRezeptZutatenList.Add: TRestRezeptzutaten;
begin
  Result := TRestRezeptzutaten.Create;
  fList.Add(Result);
end;

end.
