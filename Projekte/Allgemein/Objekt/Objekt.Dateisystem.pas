unit Objekt.Dateisystem;


interface

uses
  SysUtils, Classes, Objekt.DateiDatum, Objekt.Datei, Objekt.DateiList,
  Winapi.Windows, Vcl.Dialogs;


type
  TDeleteFileEvent = procedure(aDeleteFile: string) of object;

type
  TReadFileEvent = procedure(aFilename: string; var aCancel: Boolean) of object;
  TReadPathEvent = procedure(aPath: string; var aCanRead: Boolean) of object;
  TDateisystem = class
  private
    fDateiList: TDateiList;
    fOnDeleteFile: TDeleteFileEvent;
    fOnReadFile: TReadFileEvent;
    fOnCancel: TNotifyEvent;
    fOnReadPath: TReadPathEvent;
    fCancel: Boolean;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    function DateiList: TDateiList;
    procedure ReadFiles(aPath: String; aDateiList: TDateiList; const All: Boolean = true; const Mask: String = '*.*');
    procedure DeleteFilesAusserDieErstenAnzahl(aDateiList: TDateiList; aAnzahl: Integer);
    property OnDeleteFile: TDeleteFileEvent read fOnDeleteFile write fOnDeleteFile;
    property OnReadFile: TReadFileEvent read fOnReadFile write fOnReadFile;
    property OnCancel: TNotifyEvent read fOnCancel write fOnCancel;
    property OnReadPath: TReadPathEvent read fOnReadPath write fOnReadPath;
    property Cancel: Boolean read fCancel write fCancel;
    procedure RemoveAllEmptyDir(aDir: string; const aStopByDir: string = '');
  end;

implementation

{ TDateisystem }

constructor TDateisystem.Create;
begin
  fDateiList := TDateiList.Create;
  Init;
end;



destructor TDateisystem.Destroy;
begin
  FreeAndNil(fDateiList);
  inherited;
end;

procedure TDateisystem.Init;
begin
  fCancel := false;
end;


function TDateisystem.DateiList: TDateiList;
begin
  Result := fDateiList;
end;


procedure TDateisystem.ReadFiles(aPath: String; aDateiList: TDateiList; const All: Boolean = true; const Mask: String = '*.*');
var
  SR: TSearchRec;
  CanReadPath: Boolean;
  IsCancel: Boolean;
begin
  //aDateiList.Clear;
  if fCancel then
  begin
    isCancel := true;
    exit;
  end;
  if aPath = '' then
    exit;
  if AnsiLastChar(aPath)^ <> '\' then
    aPath := aPath + '\';
  if All then
    if FindFirst(aPath + '*.*', faAnyFile, SR) = 0 then
    try
      repeat
        if SR.Attr and faDirectory = faDirectory then
            // --> ein Verzeichnis wurde gefunden
            //   der Verzeichnisname steht in SR.Name
            //   der vollständige Verzeichnisname (inkl. darüberliegender Pfade) ist
            //       RootFolder + SR.Name
          if (SR.Name <> '.') and (SR.Name <> '..') then
          begin
            CanReadPath := true;
            if Assigned(fOnReadPath) then
              fOnReadPath(aPath + SR.Name, CanReadPath);
            if CanReadPath then
              ReadFiles(aPath + SR.Name, aDateiList, All, Mask);
          end;
      until FindNext(SR) <> 0;
    finally
      System.SysUtils.FindClose(SR);
    end;
  if FindFirst(aPath + Mask, faAnyFile, SR) = 0 then
  try
    repeat
      if SR.Attr and faDirectory <> faDirectory then
      begin
          // --> eine Datei wurde gefunden
          //   der Dateiname steht in SR.Name
          //   der vollständige Dateiname (inkl. Pfadangabe) ist
          //       RootFolder + SR.Name
        if Assigned(fOnReadFile) then
          fOnReadFile(aPath + SR.Name, fCancel);
        //if IsCancel then
        //  fCancel := true;
        aDateiList.Add(aPath + SR.Name);
        if Assigned(fOnCancel) then
          fOnCancel(Self);
        if fCancel then
          exit;
      end;
    until FindNext(SR) <> 0;
  finally
    System.SysUtils.FindClose(SR);
  end;
end;


procedure TDateisystem.DeleteFilesAusserDieErstenAnzahl(aDateiList: TDateiList;
  aAnzahl: Integer);
var
  i1 : Integer;
  AnzGeloescht: Integer;
  AnzZuLoeschen: Integer;
begin
  if aDateiList.Count <= aAnzahl then
    exit;
  AnzGeloescht := 0;
  AnzZuLoeschen := aDateiList.Count - aAnzahl;
  for i1 := aDateiList.Count -1 downto 0 do
  begin
    if AnzGeloescht >= AnzZuLoeschen then
      exit;
    if Assigned(fOnDeleteFile) then
      fOnDeleteFile(aDateiList.Item[i1].FullDateiname);
    DeleteFile(PWideChar(aDateiList.Item[i1].FullDateiname));
    aDateiList.delete(i1);
    inc(AnzGeloescht);
  end;
end;

procedure TDateisystem.RemoveAllEmptyDir(aDir: string; const aStopByDir: string = '');
var
  i1: Integer;
  Pfad: string;
  iPos: Integer;
  StopDir: string;
begin
  StopDir := '';
  if aStopByDir > ''  then
  begin
    StopDir := aStopByDir;
    if StopDir[Length(StopDir)] = '\' then
      StopDir := copy(StopDir, 1, Length(StopDir)-1);
  end;
  Pfad := ExtractFilePath(aDir);
  RemoveDir(Pfad);
  if DirectoryExists(Pfad) then
    exit;
  iPos := LastDelimiter('\', Pfad);
  while iPos > 0 do
  begin
    Pfad := copy(Pfad, 1, iPos-1);
    if LastDelimiter('\', Pfad) <= 0 then
      break;
    if SameText(Pfad, StopDir) then
      break;
    RemoveDir(Pfad);
    if DirectoryExists(Pfad) then
      break;
    iPos := LastDelimiter('\', Pfad);
  end;
end;





end.
