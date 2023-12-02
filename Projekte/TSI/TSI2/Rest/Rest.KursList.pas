unit Rest.KursList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.Kurs,
  Rest.Basis;


type
  TRestKursList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestKurs;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestKurs read getItem;
    function Add: TRestKurs;
  end;

implementation

{ TRestKursList }


constructor TRestKursList.Create;
begin
  inherited;

end;

destructor TRestKursList.Destroy;
begin

  inherited;
end;

function TRestKursList.getItem(Index: Integer): TRestKurs;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestKurs(fList.Items[Index]);
end;




function TRestKursList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestKursList.Add: TRestKurs;
begin
  Result := TRestKurs.Create;
  fList.Add(Result);
end;


end.
