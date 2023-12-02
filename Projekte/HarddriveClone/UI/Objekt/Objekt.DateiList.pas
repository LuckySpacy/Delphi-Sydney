unit Objekt.DateiList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Form.JobView, Vcl.Controls,
  Objekt.Datei;


type
  TDateiList = class(TBasisList)
  private
    function getDatei(Index: Integer): TDatei;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TDatei;
    property Item[Index: Integer]: TDatei read getDatei;
  end;

implementation

{ TDateiList }


constructor TDateiList.Create;
begin
  inherited;

end;

destructor TDateiList.Destroy;
begin

  inherited;
end;

function TDateiList.Add: TDatei;
begin
  Result := TDatei.Create;
  fList.Add(Result);
end;


function TDateiList.getDatei(Index: Integer): TDatei;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDatei(fList[Index]);
end;
end.
