unit VW.JobDatei;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, VW.Basis, Data.db;

type
  TVWJobDatei = class(TVWBasis)
 private
 protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{ TVWJobDatei }

constructor TVWJobDatei.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TVWJobDatei.Destroy;
begin

  inherited;
end;

end.
