unit Rest.ZutatenlistennameList;

interface

uses
  {$IFNDEF ANDROID}
  System.Contnrs,
  {$ENDIF}

  SysUtils, Classes, Objekt.BasisRestList, Rest.Zutatenlistenname,
  Rest.Basis;


type
  TRestZutatenlistennameList = class(TBasisRestList)
  private
    function getItem(Index: Integer): TRestZutatenlistenname;
  protected
    function AddNew: TRestBasis; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TRestZutatenlistenname read getItem;
    function Add: TRestZutatenlistenname;
  end;

implementation

{ TRestZutatenlistennameList }


{$IFDEF ANDROID}
uses
  Objekt.RestSchnittstelle;
{$ENDIF ANDROID}

constructor TRestZutatenlistennameList.Create;
begin
  inherited;

end;

destructor TRestZutatenlistennameList.Destroy;
begin

  inherited;
end;

function TRestZutatenlistennameList.getItem(Index: Integer): TRestZutatenlistenname;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TRestZutatenlistenname(fList.Items[Index]);
end;




function TRestZutatenlistennameList.AddNew: TRestBasis;
begin
  Result := TRestBasis(Add);
end;


function TRestZutatenlistennameList.Add: TRestZutatenlistenname;
begin
  Result := TRestZutatenlistenname.Create;
  fList.Add(Result);
end;

end.
