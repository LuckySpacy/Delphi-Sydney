unit Objekt.CloneManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Objekt.ProzessBasis, Thread.FestplatteEinlesen, Objekt.DateiList,
  Objekt.FestplatteEinlesen, Thread.CopyFiles, VW.JobDateiList, db.JobDateiList,
  db.IgnorePfadList, Objekt.IgnorePfadList;

type
  TCloneManager = class(TProzessBasis)
  private
    fOnEnd: TNotifyEvent;
    fFestplatteEinlesen: TFestplatteEinlesen;
    fQuell: TDateiList;
    fCancel: Boolean;
    fThreadCopyFiles: TThreadCopyFiles;
    fStartZeit: TDateTime;
    fVWJobDateiList: TVWJobDateiList;
    fDBJobDateiList: TDBJobDateiList;
    fDBIgnorePfadList: TDBIgnorePfadList;
    fOnSyncZielPfadEnd: TNotifyEvent;
    fIgnorePathList: TIgnorePfadList;
    procedure Next(Sender: TObject);
    procedure  Info(aCaption, aProzessInfo: string; var aCancel: Boolean);
    procedure  InfoProzess(aProzessInfo: string; var aCancel: Boolean);
    procedure  ProgressStart(aCount: Integer; var aCancel: Boolean);
    procedure  ProgressInfo(aProgress: Integer; var aCancel: Boolean);
    procedure CopyFilesStart(aCaption: string; aCount: Integer);
    procedure CopyFilesProgress(aCaption: string; aProgress: Integer);
    procedure EndAktualNewFiles(Sender: TObject);
    procedure EndChangedFiles(Sender: TObject);
    procedure SyncZielPfadFinished(Sender: TObject);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Start;
    property OnEnd: TNotifyEvent read fOnEnd write fOnEnd;
    procedure setQuell(aQuell: TDateiList);
    procedure FestplatteEinlesenFinished(Sender: TObject);
    property Cancel: Boolean read fCancel write fCancel;
    procedure SyncZiel(aJoId: Integer);
    property OnSyncZielPfadEnd: TNotifyEvent read fOnSyncZielPfadEnd write fOnSyncZielPfadEnd;
  end;

implementation

{ TCloneManager }

uses
  Objekt.HarddriveClone2, dm.Datenbank, fmx.Types, system.UITypes;


constructor TCloneManager.Create;
begin
  inherited;
  fCancel := false;


  fFestplatteEinlesen := TFestplatteEinlesen.Create;
  fFestplatteEinlesen.OnFinished := FestplatteEinlesenFinished;
  fFestplatteEinlesen.OnInfo := Info;
  fFestplatteEinlesen.OnInfoProzess := InfoProzess;
  fFestplatteEinlesen.OnProgressInfo := ProgressInfo;
  fFestplatteEinlesen.OnProgressStart := ProgressStart;

  fThreadCopyFiles := TThreadCopyFiles.Create;
  fThreadCopyFiles.OnInfo := Info;
  fThreadCopyFiles.OnInfoProzess := InfoProzess;
  fThreadCopyFiles.OnProgressStart := ProgressStart;
  fThreadCopyFiles.OnProgressInfo  := ProgressInfo;
  fThreadCopyFiles.OnEndAktualNewFiles := EndAktualNewFiles;
  fThreadCopyFiles.OnEndChangedFiles   := EndChangedFiles;
//  fThreadCopyFiles.OnCopyFilesStart := CopyFilesStart;
 // fThreadCopyFiles.OnCopyFilesProgress := CopyFilesProgress;
 // fThreadCopyFiles.OnEndAktualNewFiles := EndAktualNewFiles;
 // fThreadCopyFiles.OnEndChangedFiles := EndChangedFiles;


  fVWJobDateiList := TVWJobDateiList.Create;
  fVWJobDateiList.Trans := dm_Datenbank.IBTrans_Read;

  fDBJobDateiList := TDBJobDateiList.Create;
  fDBJobDateiList.Trans := dm_Datenbank.IBTrans_Read;

  fDBIgnorePfadList := TDBIgnorePfadList.Create;
  fDBIgnorePfadList.Trans := dm_Datenbank.IBTrans_Read;

  fIgnorePathList := TIgnorePfadList.Create;

end;

destructor TCloneManager.Destroy;
begin
  FreeAndNil(fVWJobDateiList);
  FreeAndNil(fDBJobDateiList);
  FreeAndNil(fFestplatteEinlesen);
  FreeAndNil(fThreadCopyFiles);
  FreeAndNil(fIgnorePathList);
  FreeAndNil(fDBIgnorePfadList);
  inherited;
end;


procedure TCloneManager.EndAktualNewFiles(Sender: TObject);
begin
  if fCancel then
  begin
    if Assigned(fOnEnd) then
      fOnEnd(nil);
    exit;
  end;

  fThreadCopyFiles.ChangedFiles(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Id);
end;

procedure TCloneManager.EndChangedFiles(Sender: TObject);
begin
  if fCancel then
  begin
    if Assigned(fOnEnd) then
      fOnEnd(Self);
    exit;
  end;
  next(nil);
end;

procedure TCloneManager.FestplatteEinlesenFinished(Sender: TObject);
var
  AnzahlZuLoeschenden: Integer;
  AnzahlDateienGesamt: Integer;
  s: string;
begin
  if fCancel then
  begin
    if Assigned(fOnEnd) then
      fOnEnd(nil);
    exit;
  end;

  if dm_Datenbank.IBTrans_Write.InTransaction then
    HarddriveClone2.Log.Info('FestplatteEinlesenFinished: InTransaction');


  AnzahlZuLoeschenden := fVWJobDateiList.AnzahlDeletedFiles(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Id, fStartZeit);
  AnzahlDateienGesamt := fDBJobDateiList.AnzahlDateien(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Id);
//  AnzahlZuLoeschenden := 10000;
  if AnzahlZuLoeschenden > (AnzahlDateienGesamt / 2) then
  begin
    s := 'Mehr als die Hälfte der Dateien im Zielpfad sollen gelöscht werden.' + sLineBreak + sLineBreak +
         'Quellpfad: "' + HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Quellpfad + '"' + sLineBreak +
         'Zielpfad: "' + HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Zielpfad + '" ' +  sLineBreak + sLineBreak +
         'Möchtest du das wirklich?';
    if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    begin
      if Assigned(fOnEnd) then
        fOnEnd(nil);
      exit;
    end;
  end;

  if AnzahlZuLoeschenden > (AnzahlDateienGesamt / 2) then
  begin
    s := 'Bist du dir da ganz sicher?';
    if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    begin
      if Assigned(fOnEnd) then
        fOnEnd(nil);
      exit;
    end;
  end;

  fThreadCopyFiles.AktualNewFiles(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Id);
end;


procedure TCloneManager.Start;
begin
  fCancel := false;
  HarddriveClone2.DBJobList.Trans := dm_Datenbank.IBTrans_Write;
  HarddriveClone2.DBJobList.ReadAll_Aktiv;
  if HarddriveClone2.DBJobList.Count = 0 then
    exit;
  HarddriveClone2.JobIndex := -1;
  fStartZeit := now;
  Next(nil);
end;


procedure TCloneManager.SyncZiel(aJoId: Integer);
begin
  fCancel := false;
  HarddriveClone2.DBJobList.Trans := dm_Datenbank.IBTrans_Write;
  HarddriveClone2.DBJobList.ReadAll;
  if HarddriveClone2.DBJobList.Count = 0 then
    exit;
  fFestplatteEinlesen.OnSyncZielPfadEnd := SyncZielPfadFinished;
  fFestplatteEinlesen.SyncZiel(aJoId);
end;


procedure TCloneManager.SyncZielPfadFinished(Sender: TObject);
begin
  if Assigned(fOnSyncZielPfadEnd) then
    fOnSyncZielPfadEnd(Self);
end;

procedure TCloneManager.Next(Sender: TObject);
var
  i1: Integer;
  List: TStringList;
  Tempdatei: string;
begin
  if fCancel then
  begin
    if Assigned(fOnEnd) then
      fOnEnd(Self);
    exit;
  end;
  //inc(HarddriveClone2.JobIndex);
  HarddriveClone2.JobIndex := HarddriveClone2.JobIndex + 1;
  if HarddriveClone2.JobIndex >= HarddriveClone2.DBJobList.Count then
  begin
    if Assigned(fOnEnd) then
      fOnEnd(Self);
    exit;
  end;
  fFestplatteEinlesen.StartZeit := fStartZeit;
  fThreadCopyFiles.StartZeit    := fStartZeit;

  HarddriveClone2.Log.Info('');
  HarddriveClone2.Log.Info('---------------------------------------------------------------------------------------------');
  HarddriveClone2.Log.Info('Start Job: ' + IntToStr(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Id));
  HarddriveClone2.Log.Info('Quelle: ' + HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Quellpfad);
  HarddriveClone2.Log.Info('Ziel: ' + HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Zielpfad);

  List := TStringList.Create;
  try
    try
      TempDatei := IncludeTrailingPathDelimiter(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Zielpfad) + '\x_' + FormatDateTime('yyyymmdd', now) + '.txt';
      List.Text := 'Test';
      List.SaveToFile(TempDatei);
      DeleteFile(TempDatei);
      except
        on E: Exception do
        begin
          HarddriveClone2.Log.Info('Das Zielverzeichnis ist nicht beschreibbar: ' + HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Zielpfad);
          HarddriveClone2.Log.Info(E.Message);
          Next(nil);
          exit;
        end;
    end;
  finally
    FreeAndNil(List);
  end;

  fDBIgnorePfadList.ReadAll(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Id);
  fIgnorePathList.Clear;
  for i1 := 0 to fDBIgnorePfadList.Count -1 do
    fIgnorePathList.Add(fDBIgnorePfadList.Item[i1].Pfad, fDBIgnorePfadList.Item[i1].Exakt);

  fFestplatteEinlesen.IgnorePfadList := fIgnorePathList;
  {
  if fIgnorePathList.Count > 0 then
    fFestplatteEinlesen.IgnorePfadList := fIgnorePathList
  else
    fFestplatteEinlesen.IgnorePfadList := nil;
  }

  fFestplatteEinlesen.Cancel := false;
  fFestplatteEinlesen.Read(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Quellpfad,
                           HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Id);

  if dm_Datenbank.IBTrans_Write.InTransaction then
    HarddriveClone2.Log.Info('Next: InTransaction');


end;


procedure TCloneManager.setQuell(aQuell: TDateiList);
begin
  fQuell := aQuell;
  fFestplatteEinlesen.setQuell(fQuell);
end;


procedure TCloneManager.Info(aCaption, aProzessInfo: string;
  var aCancel: Boolean);
begin
  if Assigned(fOnInfo) then
    fOnInfo(aCaption, aProzessInfo, aCancel);
end;

procedure TCloneManager.InfoProzess(aProzessInfo: string; var aCancel: Boolean);
begin
  if Assigned(fOnInfoProzess) then
    fOnInfoProzess(aProzessInfo, aCancel);
end;

procedure TCloneManager.ProgressInfo(aProgress: Integer; var aCancel: Boolean);
begin
  if Assigned(fOnProgressInfo) then
    fOnProgressInfo(aProgress, aCancel);
end;

procedure TCloneManager.ProgressStart(aCount: Integer; var aCancel: Boolean);
begin
  if Assigned(fOnProgressStart) then
    fOnProgressStart(aCount, aCancel);
end;


procedure TCloneManager.CopyFilesProgress(aCaption: string; aProgress: Integer);
begin

end;

procedure TCloneManager.CopyFilesStart(aCaption: string; aCount: Integer);
begin

end;


end.
