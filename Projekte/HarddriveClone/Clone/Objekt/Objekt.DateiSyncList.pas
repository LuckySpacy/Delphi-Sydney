unit Objekt.DateiSyncList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Vcl.Controls,
  Objekt.DateiSync;


type
  TDateiSyncList = class(TBasisList)
  private
    function getDateiSync(Index: Integer): TDateiSync;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TDateiSync;
    property Item[Index: Integer]: TDateiSync read getDateiSync;
    function getDateiSyncByPfad(aZielpfad, aQuellPfad: string): TDateiSync;
  end;

implementation

{ TDateiSyncList }


constructor TDateiSyncList.Create;
begin
  inherited;

end;

destructor TDateiSyncList.Destroy;
begin

  inherited;
end;


function TDateiSyncList.Add: TDateiSync;
begin
  Result := TDateiSync.Create;
  fList.Add(Result);
end;

function TDateiSyncList.getDateiSync(Index: Integer): TDateiSync;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDateiSync(fList[Index]);
end;

function TDateiSyncList.getDateiSyncByPfad(aZielpfad, aQuellPfad: string): TDateiSync;
var
  i1: Integer;
  DateiSync: TDateiSync;
begin
  Result := nil;
  for i1 := 0 to fList.Count -1 do
  begin
    DateiSync := getDateiSync(i1);
    if (SameText(aZielpfad, DateiSync.Zielpfad)) and (SameText(aQuellPfad, DateiSync.Quellpfad)) then
    begin
      Result := DateiSync;
      exit;
    end;
  end;
end;

end.
