unit Objekt.Dateien;

interface

{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}


uses
  Windows, SysUtils, Classes, FileCtrl, Dialogs, ShellApi, Forms, ClipBrd,
  System.UITypes;

type
  TDateien = class
  public
    function  Directory(aPath: String; const aSearchRec: TSearchRec): Boolean;
    procedure GetSubDirectory(aPath: String; aStrings: TStrings;const All: Boolean = true);
    procedure GetAllFiles(aPath: String; aStrings: TStrings;
                      const WithPathName: Boolean; const All: Boolean = true; const Mask: String = '*.*');
    function GetFileNameWithoutExt(const aFileName: string): string;
    function ChangeFileName(const aOldFileName, aNewFileName: string): string;
    function AppendFileName(const aFilename, aAppendName: string): string;
    function GetTempFullFilename: string;
    function GetNetworkPath(const aDriveChar: Char): string;
    function ConnectDrive(aDrvLetter: string; aNetPath: string;
                                aShowError: Boolean; aReconnect: Boolean): DWORD;
    function GetTempPath: String;
    function DoNetworkConnection(aDrive: Char; aShowError: Boolean): Boolean;
    function FileExist(aFilename: string): Integer;
    function DirExist(aPath: string): Integer;
    function GetShellFolder(aCSIDL: Integer): string;
  end;


implementation

{ TDateien }

uses
  Objekt.Folderlocation;

function TDateien.AppendFileName(const aFilename, aAppendName: string): string;
var
  Path    : string;
  Ext     : string;
  FileName: string;
begin
  Path     := Trim(ExtractFilePath(aFilename));
  Ext      := ExtractFileExt(aFilename);
  FileName := ExtractFileName(aFileName);
  FileName := GetFileNameWithoutExt(FileName);
  Result   := Path + Filename + aAppendName + Ext;
end;

function TDateien.ChangeFileName(const aOldFileName,
  aNewFileName: string): string;
var
  Path: string;
  Ext : string;
begin
  Path := Trim(ExtractFilePath(aOldFileName));
  Ext  := ExtractFileExt(aOldFileName);
  Result := Path + aNewFileName + Ext;
end;

function TDateien.ConnectDrive(aDrvLetter, aNetPath: string; aShowError,
  aReconnect: Boolean): DWORD;
var
  nRes: TNetResource;
  errCode: DWORD;
  dwFlags: DWORD;
begin
  { NetRessource mit #0 füllen => Keine unitialisierte Werte }
  FillChar(NRes, SizeOf(NRes), #0);
  nRes.dwType := RESOURCETYPE_DISK;
  { Laufwerkbuchstabe und Netzwerkpfad setzen }
  nRes.lpLocalName  := PChar(aDrvLetter);
  nRes.lpRemoteName := PChar(aNetPath); { Beispiel: \\Test\C }
  { Überprüfung, ob gespeichert werden soll }
  if aReconnect then
    dwFlags := CONNECT_UPDATE_PROFILE and CONNECT_INTERACTIVE
  else
    dwFlags := CONNECT_INTERACTIVE;

  //errCode := WNetAddConnection3(Form1.Handle, nRes, nil, nil, dwFlags);
  errCode := WNetAddConnection3(0, nRes, nil, nil, dwFlags);
  { Fehlernachricht aneigen }
  if (errCode <> NO_ERROR) and (aShowError) then
  begin
    Application.MessageBox(PChar('An error occured while connecting:' + #13#10 +
      SysErrorMessage(GetLastError)),
      'Error while connecting!',
      MB_OK);
  end;
  Result := errCode; { NO_ERROR }
end;

function TDateien.Directory(aPath: String;
  const aSearchRec: TSearchRec): Boolean;
begin
  Result := false;
  if (aSearchRec.Attr = faArchive)
  or (aSearchRec.Attr < 16) then
    exit;

  if (aSearchRec.Name = '.')
  or (aSearchRec.Name = '..') then
    exit;
  aPath := IncludeTrailingPathDelimiter(aPath) + aSearchRec.Name;
  Result := SysUtils.DirectoryExists(aPath);
end;


function TDateien.DirExist(aPath: string): Integer;
begin
  // Result = 0  / Pfad existiert.
  // Result = -1 / Pfad existiert nicht
  // Result = -2 / Netzwerkverbindung konnte nicht hergestellt werden.
  try
    Result := 0;
    if not SysUtils.DirectoryExists(aPath) then
    begin
      if not DoNetworkConnection(aPath[1], false) then
        Result := -2;
      if not SysUtils.DirectoryExists(aPath) then
      begin
        if Result <> -2 then
          Result := -1;
      end;
    end;
  except
    Result := -3;
  end;
end;

function TDateien.DoNetworkConnection(aDrive: Char;
  aShowError: Boolean): Boolean;
var
  NetworkPath: string;
  Error: Integer;
begin
  Result := false;
  try
    Networkpath := GetNetworkPath(aDrive);
    Error       := ConnectDrive(aDrive + ':', Networkpath, aShowError, true);
    Result      := Error = 0;
  except
    on E: Exception do
    begin
      if aShowError then
        MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

function TDateien.FileExist(aFilename: string): Integer;
begin
  // Result = 0  / Datei existiert.
  // Result = -1 / Datei existiert nicht
  // Result = -2 / Netzwerkverbindung konnte nicht hergestellt werden.
  try
    Result := 0;
    if not FileExists(aFilename) then
    begin
      if not DoNetworkConnection(aFilename[1], false) then
        Result := -2;
      if not FileExists(aFilename) then
      begin
        if Result <> -2 then
          Result := -1;
      end;
    end;
  except
    Result := -3;
  end;
end;

procedure TDateien.GetAllFiles(aPath: String; aStrings: TStrings;
  const WithPathName, All: Boolean; const Mask: String);
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
      FindFirst(aPath + Mask, faAnyFile, Search);
      repeat
        Application.ProcessMessages;
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
        Application.ProcessMessages;
        aPath := Trim(sList.Strings[i1]);
        aPath := IncludeTrailingPathDelimiter(aPath);
        FindFirst(aPath + Mask, faAnyFile, Search);
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
        FindClose(Search);
      end;
      sList.Assign(aStrings);
      sList.Sort;
      aStrings.Assign(sList);
    except
      on E: Exception do
      begin
        MessageDlg('Error in (sySystem.pas) procedure syGetAllFiles(aPath: String; aStrings: TStrings;',
          mtError, [mbOk], 0);
        MessageDlg(E.Message, mtError, [mbOk], 0);
        raise;
      end;
    end;
  finally
    FreeAndNil(sList);
    FindClose(Search);
  end;
end;

function TDateien.GetFileNameWithoutExt(const aFileName: string): string;
var
  ext: string;
begin
  ext := ExtractFileExt(aFilename);
  Result := copy(aFileName, 1, Length(aFileName) - Length(ext));
end;

function TDateien.GetNetworkPath(const aDriveChar: Char): string;
const
  MaxVolSize = 260;
var
  Path : array [0..3] of Char;
  NU, VolSize : DWord;
  Vol : PChar;
  Error: DWord;
begin
  Path[0] := aDriveChar;
  Path[1] := ':';
  Path[2] := #0;
  VolSize := MaxVolSize;
  GetMem(Vol, MaxVolSize);
  Vol[0] := #0;
  Result := '';
  try
    Error := WNetGetConnection(Path, Vol, VolSize);
    if (Error = WN_SUCCESS) or (Error = 1201) then
      Result := StrPas(Vol)
    else
    begin
      if GetVolumeInformation(PChar(aDriveChar + ':\'),
        Vol, MAX_PATH, nil, NU, NU, nil, 0) then
        Result := Vol;
      Result := Format('[%s]',[Result]);
    end;
  finally
    FreeMem(Vol, MaxVolSize);
  end;
end;

function TDateien.GetShellFolder(aCSIDL: Integer): string;
var
  ShellFolder: TSysFolderLocation;
begin
  ShellFolder := TSysFolderLocation.Create(aCSIDL);
  try
    Result := ShellFolder.GetShellFolder;
  finally
    FreeAndNil(ShellFolder);
  end;
end;

procedure TDateien.GetSubDirectory(aPath: String; aStrings: TStrings;
  const All: Boolean);
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
    FindClose(Search);
  finally
    FreeAndNil(sList1);
    FreeAndNil(sList2);
  end;

end;

function TDateien.GetTempFullFilename: string;
var
  buffer: array[0..MAX_PATH] of Char;
  s: string;
begin
  Result := '';
  s := GetTempPath;
  if s = '' then
    exit;
  GetTempFileName(PWideChar(s), '~', 0, buffer);
  //GetTempFileName(PWideChar(GetTempPath), '~', 0, buffer);
  Result := string(buffer);
end;


function TDateien.GetTempPath: String;
var
  s  : string;
  Len: Integer;
begin
  Len := Windows.GetTempPath(0, nil);
  if Len > 0 then
  begin
    SetLength(S, Len);
    Len := Windows.GetTempPath(Len, PChar(S));
    SetLength(S, Len);
    Result := s;
  end
  else
    Result := '';
end;

end.
