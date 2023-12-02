unit Objekt.DateiList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Vcl.Controls,
  Objekt.Datei, sys.Disk;


type
  TDateiList = class(TBasisList)
  private
    fDisk: TDisk;
    function getDatei(Index: Integer): TDatei;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TDatei;
    property Item[Index: Integer]: TDatei read getDatei;
    procedure LoadFromPath(aPath: string);
    function getFileAge(aFullFilename: string): TDateTime;
    function getDateiByFilename(aFullFilename: string): TDatei;
  end;

implementation

{ TDateiList }


constructor TDateiList.Create;
begin
  inherited;
  fDisk := TDisk.Create;
end;

destructor TDateiList.Destroy;
begin
  FreeAndNil(fDisk);
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



procedure TDateiList.LoadFromPath(aPath: string);
var
  List: TStringList;
  i1: Integer;
  Datei: TDatei;
  Datum: TDateTime;
begin
  List := TStringList.Create;
  try
    Clear;
    fDisk.GetAllFiles(aPath, List, true, true);
    for i1 := 0 to List.Count -1 do
    begin
      Datei := add;
      Datei.Filename := ExtractFileName(List.Strings[i1]);
      Datei.FilePath := IncludeTrailingPathDelimiter(ExtractFilePath(List.Strings[i1]));
      FileAge(Datei.FullFilename, Datum);
      Datei.FileDate := Datum;
    end;
  finally
    FreeAndNil(List);
  end;
end;


function TDateiList.getDateiByFilename(aFullFilename: string): TDatei;
var
  i1: Integer;
begin
  Result := nil;
  for i1 := 0 to fList.Count -1 do
  begin
    if SameText(getDatei(i1).FullFilename, aFullFilename) then
    begin
      Result := getDatei(i1);
      exit;
    end;
  end;
end;


function TDateiList.getFileAge(aFullFilename: string): TDateTime;
var
  i1: Integer;
begin
  Result := 0;
  for i1 := 0 to fList.Count -1 do
  begin
    if SameText(getDatei(i1).FullFilename, aFullFilename) then
    begin
      Result := getDatei(i1).FileDate;
      exit;
    end;
  end;
end;

end.
