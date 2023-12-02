unit Mobil.BasisList;

interface

uses
  System.Classes, System.SysUtils, Mobil.ObjectList;

type
  TMobilBasisList = class
  private
    function GetCount: Integer;
  protected
    fList: TMobilObjectList;
    fId: Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    procedure Clear; virtual;
    property Id: Integer read fId write fId;
    procedure Delete(aIndex: Integer);
    function List: TMobilObjectList;
  end;
implementation

{ TMobilBasisList }

constructor TMobilBasisList.Create;
begin
  fList := TMobilObjectList.Create;
  fId := 0;
end;

destructor TMobilBasisList.Destroy;
begin
  FreeAndNil(fList);
  inherited;
end;



procedure TMobilBasisList.Clear;
begin
  fList.Clear;
  fId := 0;
end;


procedure TMobilBasisList.Delete(aIndex: Integer);
begin
  fList.Delete(aIndex);
end;


function TMobilBasisList.GetCount: Integer;
begin
   Result := fList.Count;
end;

function TMobilBasisList.List: TMobilObjectList;
begin
  Result := fList;
end;

end.
