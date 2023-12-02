unit Objekt.Job;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TJob = class
  private
    fZiel: string;
    fJobname: string;
    fQuell: string;
    fFilename: string;
    fFilePath: string;
    fPrio: Integer;
    fIgnoreFolderList: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    property Quell: string read fQuell write fQuell;
    property Ziel: string read fZiel write fZiel;
    property Jobname: string read fJobname write fJobname;
    procedure Init;
    property Filename: string read fFilename write fFilename;
    property FilePath: string read fFilePath write fFilePath;
    property Prio: Integer read fPrio write fPrio;
    procedure SaveToFile;
    procedure LoadFromFile;
    function FullFilename: string;
    procedure LoadIgnoreFolder(aStrings: TStrings);
    procedure SaveIgnoreFolder(aStrings: TStrings);
    function IsIgnoreFolder(aValue: string): Boolean;
  end;

implementation

{ TJob }

constructor TJob.Create;
begin
  fIgnoreFolderList := nil;
  Init;
end;

destructor TJob.Destroy;
begin
  if fIgnoreFolderList <> nil then
    FreeAndNil(fIgnoreFolderList);
  inherited;
end;


procedure TJob.Init;
begin
  fZiel    := '';
  fJobname := '';
  fQuell   := '';
  fFilename := '';
  fFilePath := '';
  fPrio     := 0;
end;


function TJob.FullFilename: string;
begin
  Result := IncludeTrailingPathDelimiter(fFilePath) + fFilename;
end;


procedure TJob.LoadFromFile;
var
  List: TStringList;
  DelimiterList: TStringList;
  s: string;
begin
  if (fFilename = '') or (not FileExists(FullFilename)) then
    exit;
  DelimiterList := TStringList.Create;
  List := TStringList.Create;
  try
    List.LoadFromFile(FullFilename);
    if List.Count = 0 then
      exit;
    s := List.Strings[0];
    DelimiterList.Delimiter := ';';
    DelimiterList.StrictDelimiter := true;
    DelimiterList.DelimitedText := s;
    if DelimiterList.Count >= 1 then
    begin
      fQuell := DelimiterList.Strings[0];
      fZiel  := DelimiterList.Strings[1];
      fPrio := 0;
      if DelimiterList.Count > 2 then
      begin
        if not TryStrToInt(DelimiterList.Strings[2], fPrio) then
          fPrio := 0;
      end;
    end;
  finally
    FreeAndNil(List);
    FreeAndNil(DelimiterList);
  end;

end;

procedure TJob.LoadIgnoreFolder(aStrings: TStrings);
var
  i1: Integer;
  List: TStringList;
begin
  aStrings.Clear;
  List := TStringList.Create;
  try
    List.LoadFromFile(FullFilename);
    if List.Count <= 1 then
      exit;
    for i1 := 1 to List.Count -1 do
      aStrings.Add(List.Strings[i1]);
  finally
    FreeAndNil(List);
  end;
end;

procedure TJob.SaveIgnoreFolder(aStrings: TStrings);
var
  i1: Integer;
  List: TStringList;
  s: string;
begin
  List := TStringList.Create;
  try
    List.LoadFromFile(FullFilename);
    if List.Count < 1 then
      exit;
    s := List.Strings[0];
    List.Clear;
    List.Add(s);
    for i1 := 0 to aStrings.Count -1 do
      List.Add(aStrings.Strings[i1]);
    List.SaveToFile(FullFileName);
  finally
    FreeAndNil(List);
  end;
end;

procedure TJob.SaveToFile;
var
  List: TStringList;
  FullFilename: string;
begin
  if fFilename = '' then
    fFilename := 'Job' + FormatDateTime('yyyymmddhhnnsszzz', now) + '.txt';
  FullFilename := IncludeTrailingPathDelimiter(fFilePath) + fFilename;
  List := TStringList.Create;
  try
    List.Add(fQuell + ';' + fZiel + ';' + IntToStr(Prio));
    List.SaveToFile(FullFilename);
  finally
    FreeAndNil(List);
  end;
end;

function TJob.IsIgnoreFolder(aValue: string): Boolean;
var
  i1: Integer;
  CheckValue: string;
begin
  Result := false;
  if fIgnoreFolderList = nil then
  begin
    fIgnoreFolderList := TStringList.Create;
    LoadIgnoreFolder(fIgnoreFolderList);
  end;

  for i1 := 0 to fIgnoreFolderList.Count -1 do
  begin
    CheckValue := LowerCase('\' + fIgnoreFolderList.Strings[i1] + '\');
    if Pos(CheckValue, LowerCase(aValue)) > 0 then
      Result := true;
  end;
end;


end.
