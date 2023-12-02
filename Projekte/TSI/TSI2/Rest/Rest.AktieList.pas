unit Rest.AktieList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.Aktie,
  Rest.Basis;


type
  TRestAktieList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestAktie;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestAktie read getItem;
    function Add: TRestAktie;
  end;

implementation

{ TRestRezeptList }





constructor TRestAktieList.Create;
begin
  inherited;

end;

destructor TRestAktieList.Destroy;
begin

  inherited;
end;

function TRestAktieList.getItem(Index: Integer): TRestAktie;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestAktie(fList.Items[Index]);
end;




function TRestAktieList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestAktieList.Add: TRestAktie;
begin
  Result := TRestAktie.Create;
  fList.Add(Result);
end;


end.
