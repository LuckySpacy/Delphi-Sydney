unit Objekt.ProtokollList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Vcl.Controls,
  Objekt.Protokoll;


type
  TProtokollList = class(TBasisList)
  private
    function getProtokoll(Index: Integer): TProtokoll;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TProtokoll;
    property Item[Index: Integer]: TProtokoll read getProtokoll;
    function ProtokollByFilename(aFullFilename: string): TProtokoll;
  end;

implementation

{ TProtokollList }


constructor TProtokollList.Create;
begin
  inherited;

end;

destructor TProtokollList.Destroy;
begin

  inherited;
end;

function TProtokollList.getProtokoll(Index: Integer): TProtokoll;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TProtokoll(fList[Index]);
end;

function TProtokollList.ProtokollByFilename(aFullFilename: string): TProtokoll;
var
  i1: Integer;
begin
  Result := nil;
  for i1 := 0 to fList.Count -1  do
  begin
    if SameText(aFullFilename, getProtokoll(i1).FullFilename) then
    begin
      Result := getProtokoll(i1);
      exit;
    end;
  end;
end;

function TProtokollList.Add: TProtokoll;
begin
  Result := TProtokoll.Create;
  fList.Add(Result);
end;


end.
