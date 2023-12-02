unit Objekt.HarddriveClone2;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Objekt.Logger, Objekt.HarddriveCloneIni, DB.JobList;

type
  THarddriveClone2 = class
  private
    fIni: THarddriveCloneIni;
    fDBJobList: TDBJobList;
    fJobIndex: Integer;
  public
    Log: TLogger;
    constructor Create;
    destructor Destroy; override;
    function ProgrammPfad: string;
    property Ini: THarddriveCloneIni read fIni;
    function DBJobList: TDBJobList;
    property JobIndex: Integer read fJobIndex write fJobIndex;
  end;


var
  HarddriveClone2: THarddriveClone2;

implementation


{ THarddriveClone2 }

constructor THarddriveClone2.Create;
begin
  Log := TLogger.Create;
  fIni := THarddriveCloneIni.Create;
  fIni.FullFileName := Programmpfad + 'HarddriveClone2.Ini';
  fDBJobList := TDBJobList.Create;
end;

function THarddriveClone2.DBJobList: TDBJobList;
begin
  Result := fDBJobList;
end;

destructor THarddriveClone2.Destroy;
begin
  FreeAndNil(fIni);
  FreeAndNil(Log);
  FreeAndNil(fDBJobList);
  inherited;
end;

function THarddriveClone2.ProgrammPfad: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

end.
