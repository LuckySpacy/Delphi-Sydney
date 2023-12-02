unit Rest.TSIList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.TSI,
  Rest.Basis;


type
  TRestTSIList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestTSI;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestTSI read getItem;
    function Add: TRestTSI;
  end;

implementation


constructor TRestTSIList.Create;
begin
  inherited;

end;

destructor TRestTSIList.Destroy;
begin

  inherited;
end;

function TRestTSIList.getItem(Index: Integer): TRestTSI;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestTSI(fList.Items[Index]);
end;




function TRestTSIList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestTSIList.Add: TRestTSI;
begin
  Result := TRestTSI.Create;
  fList.Add(Result);
end;

end.
