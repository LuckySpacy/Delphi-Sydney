unit Objekt.HarddriveClone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Objekt.Logger, sys.Objekt, Objekt.ObjektList,
  Objekt.JobList;

type
  THarddriveClone = class
  private
    fRoamingPfad: string;
  public
    Log: TLogger;
    sys: TSys;
    JobList: TJobList;
    constructor Create;
    destructor Destroy; override;
    function ProgrammPfad: string;
    property RoamingPfad: string read fRoamingPfad;
  end;

var
  HarddriveClone: THarddriveClone;

implementation

{ THarddriveClone }

constructor THarddriveClone.Create;
begin
  Log := TLogger.Create;
  sys := TSys.Create;
  JobList := TJobList.Create;
  fRoamingPfad := sys.Disk.RaomingPath + 'Harddriveclone\';
  if not DirectoryExists(fRoamingPfad) then
    ForceDirectories(fRoamingPfad);
  JobList.FilePath := fRoamingPfad;
end;

destructor THarddriveClone.Destroy;
begin
  FreeAndNil(Log);
  FreeAndNil(sys);
  FreeAndNil(JobList);
  inherited;
end;

function THarddriveClone.ProgrammPfad: string;
begin
  Result :=  IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

end.
