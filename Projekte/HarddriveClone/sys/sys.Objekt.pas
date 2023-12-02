unit sys.Objekt;

interface

uses
  System.SysUtils, System.Variants, System.Classes, sys.Disk;

type
  TSys = class
  private
    fDisk: TDisk;
  public
    constructor Create;
    destructor Destroy; override;
    function Disk: TDisk;
  end;

var
  MyFunc: TSys;

implementation

{ TSys }

constructor TSys.Create;
begin
  fDisk := TDisk.Create;
end;

destructor TSys.Destroy;
begin
  FreeAndNil(fDisk);
  inherited;
end;

function TSys.Disk: TDisk;
begin
  Result := fDisk;
end;

end.
