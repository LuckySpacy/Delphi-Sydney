unit Rest.BenutzerList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.Benutzer,
  Rest.Basis;

type
  TRestBenutzerList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestBenutzer;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestBenutzer read getItem;
    function Add: TRestBenutzer;
  end;

implementation

{ TRestBenutzerList }


constructor TRestBenutzerList.Create;
begin
  inherited;

end;

destructor TRestBenutzerList.Destroy;
begin

  inherited;
end;


function TRestBenutzerList.Add: TRestBenutzer;
begin
  Result := TRestBenutzer.Create;
  fList.Add(Result);
end;

function TRestBenutzerList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestBenutzerList.getItem(Index: Integer): TRestBenutzer;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestBenutzer(fList.Items[Index]);
end;

end.
