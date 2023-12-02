unit Form.Harddriveclone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Objekt.HarddriveClone,
  Vcl.ExtCtrls, Objekt.DateiSync, Objekt.Job, Objekt.DateiSyncList, Objekt.DateiList,
  Objekt.ProtokollList, System.ImageList, Vcl.ImgList, Vcl.Menus, Vcl.AppEvnts, Objekt.Protokoll;

type
  Tfrm_Harddrive = class(TForm)
    Panel1: TPanel;
    btn_Start: TButton;
    TrayIcon: TTrayIcon;
    img: TImageList;
    pop: TPopupMenu;
    mnu_Start: TMenuItem;
    mnu_Stop: TMenuItem;
    mnu_Close: TMenuItem;
    mnu_Show: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    lbl_Kopiere: TLabel;
    lbl_Quell: TLabel;
    lbl_nach: TLabel;
    lbl_Ziel: TLabel;
    lbl_Filenametext: TLabel;
    lbl_Filename: TLabel;
    tmr_Start: TTimer;
    btn_Stop: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure mnu_StartClick(Sender: TObject);
    procedure mnu_StopClick(Sender: TObject);
    procedure mnu_CloseClick(Sender: TObject);
    procedure mnu_ShowClick(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure tmr_StartTimer(Sender: TObject);
    procedure btn_StopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fDateiSyncList: TDateiSyncList;
    fDateiList: TDateiList;
    fProtokollList: TProtokollList;
    fIgnorePathList: TStringList;
    fStop: Boolean;
    procedure DoClone(aJob: TJob);
    procedure StartClone;
    procedure setStop(aProtokoll: TProtokoll);
    function InIgnorePathList(aPath: string): Boolean;
    procedure setTrayIconHint(aValue: string);
  public
  end;

var
  frm_Harddrive: Tfrm_Harddrive;

implementation

{$R *.dfm}

uses
  Objekt.Datei;


// TODO: Leere Verzeichnisse löschen




procedure Tfrm_Harddrive.FormCreate(Sender: TObject);
begin
  HarddriveClone := THarddriveClone.Create;
  fDateiSyncList := TDateiSyncList.Create;
  fDateiList     := TDateiList.Create;
  fProtokollList := TProtokollList.Create;
  TrayIcon.IconIndex := 3;
  tmr_Start.Interval := 60000; // 1 Minuten nach beenden;
  fIgnorePathList := TStringList.Create;
  fIgnorePathList.Duplicates := dupIgnore;
  fIgnorePathList.Sorted := true;

  fStop := false;
  HarddriveClone.Log.Info('Programmstart');
end;

procedure Tfrm_Harddrive.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  HarddriveClone.Log.Info('Programmende');
end;


procedure Tfrm_Harddrive.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDateiSyncList);
  FreeAndNil(fDateiList);
  FreeAndNil(fProtokollList);
  FreeAndNil(HarddriveClone);
end;



function Tfrm_Harddrive.InIgnorePathList(aPath: string): Boolean;
var
  i1: Integer;
begin
  Result := false;
  for i1 := 0 to fIgnorePathList.Count -1 do
  begin
    if aPath = fIgnorePathList.Strings[i1] then
    begin
      Result := true;
      exit;
    end;
  end;
  fIgnorePathList.Add(aPath);
end;

procedure Tfrm_Harddrive.ApplicationEventsMinimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrayIcon.Visible := True;
  //TrayIcon1.Animate := True;
end;

procedure Tfrm_Harddrive.btn_StartClick(Sender: TObject);
begin
 // HarddriveClone.sys.Disk.RemoveAllEmptyDirectories('d:\temp2');
  StartClone;
end;





procedure Tfrm_Harddrive.btn_StopClick(Sender: TObject);
begin
  fStop := true;
end;

procedure Tfrm_Harddrive.mnu_CloseClick(Sender: TObject);
begin
  fStop := true;
  close;
end;

procedure Tfrm_Harddrive.mnu_ShowClick(Sender: TObject);
begin
//  fStop := true;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure Tfrm_Harddrive.mnu_StartClick(Sender: TObject);
begin
  StartClone;
end;

procedure Tfrm_Harddrive.mnu_StopClick(Sender: TObject);
begin
  fStop := true;
end;


procedure Tfrm_Harddrive.StartClone;
var
  i1: Integer;
begin
  fStop := false;
  TrayIcon.IconIndex := 2;
  HarddriveClone.JobList.LoadFromFile;
  HarddriveClone.JobList.PrioSort;
  for i1 := 0 to HarddriveClone.JobList.Count -1  do
  begin
    DoClone(HarddriveClone.JobList.Item[i1]);
    if fStop then
      break;
    //lsb.Items.Add(HarddriveClone.JobList.Item[i1].Ziel);
  end;
  TrayIcon.IconIndex := 3;
end;


procedure Tfrm_Harddrive.tmr_StartTimer(Sender: TObject);
begin
  tmr_Start.Enabled := false;
  HarddriveClone.Log.Info('Timer start');
  StartClone;
end;

procedure Tfrm_Harddrive.DoClone(aJob: TJob);
var
  ZielDatei: TDatei;
  QuellDatei: TDatei;
  DateiSync: TDateiSync;
  i1: Integer;
  Filename: string;
  Zielpfad: string;
  Protokoll: TProtokoll;
  ProtokollFilename: string;
begin
  try
    try
      ProtokollFilename := HarddriveClone.ProtokollPfad + HarddriveClone.sys.Disk.getFilenameWithoutExt(aJob.FullFilename) + '_' + FormatDateTime('yyyy-mm-dd', now) + '.txt';
      Protokoll := fProtokollList.ProtokollByFilename(ProtokollFilename);
      if Protokoll = nil then
      begin
        Protokoll := fProtokollList.Add;
        Protokoll.FullFilename := ProtokollFilename;
      end;
      Protokoll.open;

      Application.ProcessMessages;
      if fStop then
      begin
        setStop(Protokoll);
        exit;
      end;

      if not DirectoryExists(aJob.Ziel) then
      begin
        HarddriveClone.Log.Info('Das Zielverzeichnis "' + aJob.Ziel + '" existiert nicht.');
        Protokoll.write('Das Zielverzeichnis "' + aJob.Ziel + '" existiert nicht.');
        exit;
      end;

      if not DirectoryExists(aJob.Quell) then
      begin
        HarddriveClone.Log.Info('Das Quellverzeichnis "' + aJob.Quell + '" existiert nicht.');
        Protokoll.write('Das Quellverzeichnis "' + aJob.Quell + '" existiert nicht.');
        exit;
      end;


      //caption := HarddriveClone.sys.Disk.getFilenameWithoutExt(aJob.FullFilename);
      setTrayIconHint('Verzeichnisstruktur lesen');
      TrayIcon.IconIndex := 4;
      DateiSync := fDateiSyncList.getDateiSyncByPfad(aJob.Ziel, aJob.Quell);
      if DateiSync = nil then
      begin
        DateiSync := fDateiSyncList.Add;
        DateiSync.Zielpfad  := aJob.Ziel;
        DateiSync.Quellpfad := aJob.Quell;
        lbl_Kopiere.Caption := 'Lese Ziel-Verzeichnisstruktur';
        lbl_nach.Caption := aJob.Ziel;
        Application.ProcessMessages;
        DateiSync.Ziel.LoadFromPath(aJob.Ziel);
      end;
      lbl_Kopiere.Caption := 'Lese Quell-Verzeichnisstruktur';
      lbl_nach.Caption := aJob.Quell;
      Application.ProcessMessages;
      DateiSync.Quell.LoadFromPath(aJob.Quell);

      lbl_Kopiere.Caption := 'Lösche';
      lbl_nach.Caption := '';
      lbl_Filenametext.Caption := 'Filename:';
      TrayIcon.IconIndex := 2;


      if DateiSync.Quell.Count = 0 then
      begin
        Protokoll.write('Quellpfad ist leer "' + aJOb.Quell + '"');
        Protokoll.write('Verarbeitung wurde abgebrochen');
        exit;
      end;

      // Dateien die gelöscht werden können
      setTrayIconHint('Überprüfe, ob Dateien gelöscht werden können');
      for i1 := DateiSync.Ziel.Count -1 downto 0 do
      begin
        Application.ProcessMessages;
        if fStop then
        begin
          setStop(Protokoll);
          exit;
        end;
        ZielDatei  := DateiSync.Ziel.Item[i1];
        Filename   := ZielDatei.ZielFullFilename(DateiSync.Zielpfad, DateiSync.Quellpfad);
        QuellDatei := DateiSync.Quell.getDateiByFilename(Filename);
        if QuellDatei = nil then
        begin
          lbl_Quell.Caption := ZielDatei.FullFilename;
          lbl_Filename.Caption := ExtractFileName(ZielDatei.FullFilename);
          Application.ProcessMessages;
          Filename := ZielDatei.FullFilename;
          DeleteFile(Filename);
          Protokoll.write('Gelöscht: ' + Filename);
          RemoveDir(ZielDatei.FilePath); // Wird nur gelöscht, wenn Ordner Leer ist.
          DateiSync.Ziel.Delete(i1);
        end;
      end;

      setTrayIconHint('Kopiere Dateien');
      lbl_Kopiere.Caption := 'Kopiere';
      lbl_nach.Caption := 'nach';

      // Dateien kopieren
      for i1 := 0 to DateiSync.Quell.Count -1 do
      begin
        Application.ProcessMessages;
        if fStop then
        begin
          setStop(Protokoll);
          exit;
        end;

        QuellDatei := DateiSync.Quell.Item[i1];

        if aJob.IsIgnoreFolder(ExtractFilePath(QuellDatei.FullFilename)) then
        begin
          if not InIgnorePathList(ExtractFilePath(QuellDatei.FullFilename)) then
            Protokoll.write('Ordner wird ignoriert "' + ExtractFilePath(QuellDatei.FullFilename) + '"');
          continue;
        end;

        Zielpfad := QuellDatei.ZielPfad(DateiSync.Quellpfad, DateiSync.Zielpfad);
        if not DirectoryExists(Zielpfad) then
          ForceDirectories(ZielPfad);
        Filename := QuellDatei.ZielFullFilename(DateiSync.Quellpfad, DateiSync.Zielpfad);
        ZielDatei := DateiSync.Ziel.getDateiByFilename(Filename);
        lbl_Quell.Caption := QuellDatei.FullFilename;
        lbl_Filename.Caption := ExtractFileName(Filename);
        lbl_Ziel.Caption  := Filename;
        Application.ProcessMessages;
        if ZielDatei = nil then
        begin
          Application.ProcessMessages;
          CopyFile(PWideChar(QuellDatei.FullFilename), PWideChar(Filename), false);
          Protokoll.write('Kopiert (Neu): "' + QuellDatei.FullFilename + '" nach "' + Filename + '"');
          continue;
        end;
        if QuellDatei.FileDate > Zieldatei.FileDate then
        begin
          CopyFile(PWideChar(QuellDatei.FullFilename), PWideChar(Filename), false);
          ZielDatei.FileDate := now;
          Protokoll.write('Kopiert (Alt): "' + QuellDatei.FullFilename + '" nach "' + Filename + '"');
        end;
      end;

      setTrayIconHint('Fertig');
      lbl_Kopiere.Caption := 'Fertig';
      lbl_nach.Caption := '';
      lbl_Quell.Caption := '';
      lbl_Ziel.Caption := '';
      lbl_Filenametext.Caption := '';
      lbl_Filename.Caption := '';

      Protokoll.write('Fertig');
      Protokoll.write('------------------------------------------------------------------------------------------------------------');
      Protokoll.Close;
      tmr_Start.Interval := 600000; // 10 Minuten nach beenden;
    finally
      tmr_Start.Enabled := true;
    end;
  except
    on E: Exception do
    begin
      HarddriveClone.Log.Info('Fehler: ' + e.Message);
      tmr_Start.Enabled := true;
    end;
  end;

end;

procedure Tfrm_Harddrive.setStop(aProtokoll: TProtokoll);
begin
  lbl_Kopiere.Caption := 'Gestoppt';
  lbl_nach.Caption := '';
  lbl_Quell.Caption := '';
  lbl_Ziel.Caption := '';
  lbl_Filenametext.Caption := '';
  lbl_Filename.Caption := '';
  aProtokoll.write('Gestoppt');
  aProtokoll.Close;
  Invalidate;
  Repaint;
  Refresh;
end;




procedure Tfrm_Harddrive.setTrayIconHint(aValue: string);
begin
  TrayIcon.Hint := aValue;
  TrayIcon.BalloonHint := aValue;
end;

end.
