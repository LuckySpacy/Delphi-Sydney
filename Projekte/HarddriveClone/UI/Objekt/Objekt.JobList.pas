unit Objekt.JobList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Objekt.Job, sys.Disk;


type
  TJobList = class(TBasisList)
  private
    fFilePath: string;
    fDisk: TDisk;
    function getJob(Index: Integer): TJob;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TJob;
    property Item[Index: Integer]: TJob read getJob;
    property FilePath: string read fFilePath write fFilePath;
    procedure LoadFromFile;
    procedure DeleteByFilename(aFullFilename: string);
    procedure PrioSort;
  end;

implementation

{ TJobList }


function PrioSortieren(Item1, Item2: Pointer): Integer;
begin
  Result := 0;
  if TJob(Item1).Prio > TJob(Item2).Prio then
  begin
    Result := -1;
    exit;
  end;
  if TJob(Item1).Prio < TJob(Item2).Prio then
    Result := 1;
end;


constructor TJobList.Create;
begin
  inherited;
  fFilePath := '';
  fDisk := TDisk.Create;

end;


destructor TJobList.Destroy;
begin
  FreeAndNil(fDisk);
  inherited;
end;

function TJobList.getJob(Index: Integer): TJob;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TJob(fList[Index]);
end;


procedure TJobList.LoadFromFile;
var
  List: TStringList;
  i1: Integer;
  Job: TJob;
begin
  List := TStringList.Create;
  try
    fDisk.GetAllFiles(fFilePath, List, true, false, 'Job*.txt');
    for i1 := 0 to List.Count -1 do
    begin
      Job := Add;
      Job.Filename := ExtractFileName(List.Strings[i1]);
      Job.LoadFromFile;
    end;
  finally
    FreeAndNil(List);
  end;
end;


function TJobList.Add: TJob;
begin
  Result := TJob.Create;
  TJob(Result).FilePath := fFilePath;
  fList.Add(Result);
end;


procedure TJobList.DeleteByFilename(aFullFilename: string);
var
  i1: Integer;
begin
  for i1 := 0 to fList.Count -1 do
  begin
    if TJob(fList.Items[i1]).FullFilename = aFullFilename then
    begin
      Delete(i1);
      DeleteFile(aFullFilename);
      exit;
    end;
  end;
end;


procedure TJobList.PrioSort;
begin
  List.Sort(@PrioSortieren);
end;


end.
