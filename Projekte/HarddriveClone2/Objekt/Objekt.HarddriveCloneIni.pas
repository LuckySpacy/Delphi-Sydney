unit Objekt.HarddriveCloneIni;

interface

uses
  SysUtils, Types, Registry, Variants, Windows, Classes, Objekt.Ini, Objekt.HarddriveCloneDBIni,
  Objekt.HarddriveCloneFormIni;

type
  THarddriveCloneIni = class
  private
    fIni: TIni;
    fDBIni: THarddriveCloneDBIni;
    fFormIni: THarddriveCloneFormIni;
    fFullFileName: string;
    procedure setFullFileName(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property FullFileName: string read fFullFileName write setFullFileName;
    property DBIni: THarddriveCloneDBIni read fDBIni;
    property FormIni: THarddriveCloneFormIni read fFormIni;
  end;

implementation

{ THarddriveCloneIni }

constructor THarddriveCloneIni.Create;
begin
  fFullFilename := '';
  fIni := TIni.Create;
  fDBIni   := THarddriveCloneDBIni.Create;
  fFormIni := THarddriveCloneFormIni.Create;
end;

destructor THarddriveCloneIni.Destroy;
begin
  FreeAndNil(fIni);
  FreeAndNil(fDBIni);
  FreeAndNil(fFormIni);
  inherited;
end;

procedure THarddriveCloneIni.setFullFileName(const Value: string);
begin
  fFullFileName := Value;
  fDBIni.FullFilename := Value;
  fFormIni.FullFilename := Value;
end;

end.
