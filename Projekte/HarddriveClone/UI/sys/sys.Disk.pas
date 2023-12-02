unit sys.Disk;

interface

uses
  System.SysUtils, System.Variants, System.Classes, sys.Folderlocation;

type
  TDisk = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetAllFiles(aPath: String; aStrings: TStrings; const WithPathName: Boolean; const All: Boolean = true; const Mask: String = '*.*');
    procedure GetSubDirectory(aPath: String; aStrings: TStrings;const All: Boolean = true);
    function Directory(aPath: String; const aSearchRec: TSearchRec): Boolean;
    function RaomingPath: string;
  end;
implementation

{ TDisk }

uses
  types.Folder;

constructor TDisk.Create;
begin

end;

destructor TDisk.Destroy;
begin
  inherited;
end;



function TDisk.Directory(aPath: String; const aSearchRec: TSearchRec): Boolean;
begin
  Result := false;
  if (aSearchRec.Attr = faArchive)
  or (aSearchRec.Attr < 16) then
    exit;

  if (aSearchRec.Name = '.')
  or (aSearchRec.Name = '..') then
    exit;
  aPath := IncludeTrailingPathDelimiter(aPath) + aSearchRec.Name;
  Result := System.SysUtils.DirectoryExists(aPath);
end;


procedure TDisk.GetSubDirectory(aPath: String; aStrings: TStrings;const All: Boolean = true);
var
  Search: TSearchRec;
  sList1: TStringList;
  sList2: TStringList;
  i1    : Integer;
begin
  aStrings.Clear;
  aPath := Trim(aPath);
  aPath := IncludeTrailingPathDelimiter(aPath);

  FindFirst(aPath + '*.*', faAnyFile, Search);
  repeat
    if Directory(aPath, Search) then
      aStrings.Add(Lowercase(aPath + Search.Name));
  until FindNext(Search) <> 0;

  if not All then
    exit;

  sList1 := TStringList.Create;
  sList2 := TStringList.Create;
  try
    sList1.Clear;
    sList1.Assign(aStrings);
    while sList1.Count > 0 do
    begin
      sList2.Clear;
      for i1 := 0 to sList1.Count -1 do
      begin
        aPath := IncludeTrailingPathDelimiter(sList1.Strings[i1]);
        FindFirst(aPath + '*.*', faAnyFile, Search);
        repeat
          if Directory(aPath, Search) then
            sList2.Add(Lowercase(aPath + Search.Name));
        until FindNext(Search) <> 0;
      end;
      sList1.Assign(sList2);
      for i1 := 0 to sList2.Count -1 do
        aStrings.Add(sList2.Strings[i1]);
    end;
    sList1.Assign(aStrings);
    sList1.Sort;
    aStrings.Assign(sList1);
    System.SysUtils.FindClose(Search);
  finally
    FreeAndNil(sList1);
    FreeAndNil(sList2);
  end;

end;

function TDisk.RaomingPath: string;
var
  Folder: TFolderlocation;
begin
  Folder := TFolderlocation.Create(cCSIDL_APPDATA);
  Result := IncludeTrailingPathDelimiter(Folder.GetFolder(cCSIDL_APPDATA));
  FreeAndNil(Folder);
end;

// Liest alle Dateien im angegebenem Pfad (aPath) in eine StringList.
// WithPathName = true = Der Pfadname wird mit in die Stringliste geschrieben
// All = true = Es wird auch in Unterverzeichnisse gesucht
// Mask = Filtereinstellung für die Dateien, die Eingelesen werden sollen.
procedure TDisk.GetAllFiles(aPath: String; aStrings: TStrings;
  const WithPathName: Boolean; const All: Boolean = true; const Mask: String = '*.*');
var
  Search: TSearchRec;
  i1    : Integer;
  sList : TStringList;
begin
  sList := TStringList.Create;
  try
    aStrings.Clear;
    try
      if All then
        GetSubDirectory(aPath, sList);
      aPath := Trim(aPath);
      aPath := IncludeTrailingPathDelimiter(aPath);
      if FindFirst(aPath + Mask, faAnyFile, Search) = 0 then
      begin
        repeat
          //Application.ProcessMessages;
          if not Directory(aPath, Search) then
          begin
            if  (Search.Name <> '.') and (Search.Name <> '..')
            and (Search.Name > '') then
            begin
              if WithPathName then
                aStrings.Add(Lowercase(aPath + Search.Name))
              else
                aStrings.Add(Lowercase(Search.Name));
            end;
          end;
          if Trim(Search.Name) = '' then
            break; // Dieser Break ist wichtig, da unter WINNT beim nächsten FindNext ein Fehler auftritt (tb 05.03.2008)
        until FindNext(Search) <> 0;
      end;
      FindClose(Search);
      if not All then
      begin
        sList.Assign(aStrings);
        sList.Sort;
        aStrings.Assign(sList);
        exit;
      end;
      for i1 := 0 to sList.Count -1 do
      begin
        //Application.ProcessMessages;
        aPath := Trim(sList.Strings[i1]);
        aPath := IncludeTrailingPathDelimiter(aPath);
        if FindFirst(aPath + Mask, faAnyFile, Search) = 0 then
        begin
          repeat
            if not Directory(aPath, Search) then
            begin
              if  (Search.Name <> '.') and (Search.Name <> '..')
              and (Search.Name > '') then
              begin
                if WithPathName then
                  aStrings.Add(Lowercase(aPath + Search.Name))
                else
                  aStrings.Add(Lowercase(Search.Name));
              end;
            end;
            if Trim(Search.Name) = '' then
              break; // Dieser Break ist wichtig, da unter WINNT beim nächsten FindNext ein Fehler auftritt (tb 05.03.2008)
          until FindNext(Search) <> 0;
        end;
        FindClose(Search);
      end;
      sList.Assign(aStrings);
      sList.Sort;
      aStrings.Assign(sList);
    except
      on E: Exception do
      begin
        //MessageDlg('Error in (sySystem.pas) procedure syGetAllFiles(aPath: String; aStrings: TStrings;', mtError, [mbOk], 0);
        //MessageDlg(E.Message, mtError, [mbOk], 0);
        raise;
      end;
    end;
  finally
    FreeAndNil(sList);
    FindClose(Search);
  end;
end;

end.
