unit Thread.CopyFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, VW.JobDateiList, DB.JobDatei, DB.Datei, Objekt.Dateisystem, DB.Job;

type
  TInfoEvent = procedure(aCaption, aProzessInfo: string; var aCancel: Boolean) of object;
  TInfoProzessEvent = procedure(aProzessInfo: string; var aCancel: Boolean) of object;
  TProgressStartEvent = procedure(aCount: Integer; var aCancel: Boolean) of object;
  TProgressInfoEvent = procedure(aProgress: Integer; var aCancel: Boolean) of object;
  TThreadCopyFiles = class
  private
    fCancel: Boolean;
    fOnEndAktualNewFiles: TNotifyEvent;
    fOnEndChangedFiles: TNotifyEvent;
    fOnInfo: TInfoEvent;
    fOnInfoProzess: TInfoProzessEvent;
    fOnProgressStart: TProgressStartEvent;
    fOnProgressInfo: TProgressInfoEvent;
    fStartZeit: TDateTime;
    fDateisystem: TDateisystem;
  public
    fVWJobDateiList: TVWJobDateiList;
    fDBJobDatei: TDBJobDatei;
    fDBDatei: TDBDatei;
    fDBJob: TDBJob;
    constructor Create;
    destructor Destroy; override;
    property Cancel: Boolean read fCancel write fCancel;
    procedure AktualNewFiles(aJoId: Integer);
    procedure ChangedFiles(aJoId: Integer);
    procedure EndAktualNewFiles(Sender: TObject);
    procedure EndChangedFiles(Sender: TObject);
    property OnEndAktualNewFiles: TNotifyEvent read fOnEndAktualNewFiles write fOnEndAktualNewFiles;
    property OnEndChangedFiles: TNotifyEvent read fOnEndChangedFiles write fOnEndChangedFiles;
    property OnInfo: TInfoEvent read fOnInfo write fOnInfo;
    property OnInfoProzess: TInfoProzessEvent read fOnInfoProzess write fOnInfoProzess;
    property OnProgressInfo: TProgressInfoEvent read fOnProgressInfo write fOnProgressInfo;
    property OnProgressStart: TProgressStartEvent read fOnProgressStart write fOnProgressStart;
    property StartZeit: TDateTime read fStartZeit write fStartZeit;
  end;

implementation

{ TThreadCopyFiles }

uses
  dm.Datenbank, VW.JobDatei, Objekt.HarddriveClone2;


constructor TThreadCopyFiles.Create;
begin
  fCancel := false;
  fVWJobDateiList := TVWJobDateiList.Create;
  fVWJobDateiList.Trans := dm_Datenbank.IBTrans_Read;
  fDBJobDatei := TDBJobDatei.Create(nil);
  fDBJobDatei.Trans := dm_Datenbank.IBTrans_Write;
  fDBJobDatei.DBDelete.Trans := dm_Datenbank.IBTrans_Write;
  fDBDatei := TDBDatei.Create(nil);
  fDBDatei.Trans := dm_Datenbank.IBTrans_Write;
  fDBDatei.DBDelete.Trans := dm_Datenbank.IBTrans_Write;
  fDateisystem := TDateisystem.Create;
  fDBJob := TDBJob.Create(nil);
  fDBJob.Trans := dm_Datenbank.IBTrans_Read;
end;

destructor TThreadCopyFiles.Destroy;
begin
  FreeAndNil(fVWJobDateiList);
  FreeAndNil(fDBJobDatei);
  FreeAndNil(fDBDatei);
  FreeAndNil(fDateisystem);
  FreeAndNil(fDBJob);
  inherited;
end;


procedure TThreadCopyFiles.EndAktualNewFiles(Sender: TObject);
begin
  if Assigned(fOnEndAktualNewFiles) then
    fOnEndAktualNewFiles(Self);
end;


procedure TThreadCopyFiles.AktualNewFiles(aJoId: Integer);
var
  t: TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  var
    i1: Integer;
    JobDatei: TVWJobDatei;
    Zielpfad: string;
  begin
    fCancel := false;

    fDBJob.Read(aJoId);
    fVWJobDateiList.ReadDeletedFiles(aJoId, fStartZeit);
    if not dm_Datenbank.IBTrans_Write.InTransaction then
      dm_Datenbank.IBTrans_Write.StartTransaction;
    fDBJobDatei.DBDelete.Prepare;
    fDBDatei.DBDelete.Prepare;
    try
      if (Assigned(fOnProgressStart) and (fVWJobDateiList.Count > 0)) then
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          fOnProgressStart(fVWJobDateiList.Count, fCancel);
          if Assigned(fOnInfo) then
            fOnInfo('Lösche Dateien: ' + IntToStr(fVWJobDateiList.Count) , '', fCancel);
        end);
      end;

      for i1 := 0 to fVWJobDateiList.Count -1 do
      begin
        JobDatei := fVWJobDateiList.Item[i1];
        if Assigned(fOnProgressInfo) then
        begin
          TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            if Assigned(fOnInfoProzess) then
              fOnInfoProzess(JobDatei.FeldList.FieldByName('jd_datei').AsString, fCancel);
            if Assigned(fOnProgressInfo) then
              fOnProgressInfo(i1+1, fCancel);

            if fCancel then
              exit;

            if not FileExists(JobDatei.FeldList.FieldByName('da_datei').AsString) then
            begin
              DeleteFile(JobDatei.FeldList.FieldByName('jd_datei').AsString);
              HarddriveClone2.Log.Info('Gelöschte Datei: ' + JobDatei.FeldList.FieldByName('jd_datei').AsString);
              fDateisystem.RemoveAllEmptyDir(JobDatei.FeldList.FieldByName('jd_datei').AsString, fDBJob.Zielpfad);
              fDBJobDatei.DBDelete.Execute(JobDatei.FeldList.FieldByName('jd_id').AsInteger);
              fDBDatei.DBDelete.Execute(JobDatei.FeldList.FieldByName('da_id').AsInteger);
              //JobDatei.delete;
            end;

          end);
        end;
      end;
    finally
      fDBDatei.DBDelete.UnPrepare;
      fDBJobDatei.DBDelete.UnPrepare;
      if dm_Datenbank.IBTrans_Write.InTransaction then
        dm_Datenbank.IBTrans_Write.Commit;
    end;


    if dm_Datenbank.IBTrans_Write.InTransaction then
      HarddriveClone2.Log.Info('TThreadCopyFiles.AktualNewFiles: InTransaction ');

    fVWJobDateiList.ReadNewFiles(aJoId);

    if Assigned(fOnProgressStart) then
    begin
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        fOnProgressStart(fVWJobDateiList.Count, fCancel);
        if Assigned(fOnInfo) then
          fOnInfo('Kopiere neue Dateien', '', fCancel);
        if fCancel then
          exit;
        //fOnCopyFilesStart(fVWJobDateiList.Count, fCancel);
        //fOnCopyFilesStart('Kopiere neue Dateien', fVWJobDateiList.Count);
      end);
    end;

    if dm_Datenbank.IBTrans_Write.InTransaction then
      HarddriveClone2.Log.Info('TThreadCopyFiles.AktualNewFiles: InTransaction ');


    for i1 := 0 to fVWJobDateiList.Count -1 do
    begin
      JobDatei := fVWJobDateiList.Item[i1];
      if Assigned(fOnProgressInfo) then
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          if Assigned(fOnInfoProzess) then
            fOnInfoProzess(JobDatei.FeldList.FieldByName('jd_datei').AsString, fCancel);
          if Assigned(fOnProgressInfo) then
            fOnProgressInfo(i1+1, fCancel);

          if fCancel then
            exit;

          if dm_Datenbank.IBTrans_Write.InTransaction then
            HarddriveClone2.Log.Info('TThreadCopyFiles.AktualNewFiles: InTransaction ' + IntToStr(i1));


          ZielPfad := ExtractFilePath(JobDatei.FeldList.FieldByName('jd_datei').AsString);
          if not DirectoryExists(ZielPfad) then
            ForceDirectories(ZielPfad);
          CopyFile(PWideChar(JobDatei.FeldList.FieldByName('da_datei').AsString), PWideChar(JobDatei.FeldList.FieldByName('jd_datei').AsString), false);

          fDBJobDatei.Read(JobDatei.FeldList.FieldByName('jd_id').AsInteger);
          if fDBJobDatei.Gefunden then
          begin
            fDBJobDatei.Dateidatum  := JobDatei.FeldList.FieldByName('da_dateidatum').AsDateTime;
            fDBJobDatei.changedatum := fStartZeit;
            fDBJobDatei.savetodb;
          end;

         // Sleep(1000);
        end);
      end;
    end;
    if dm_Datenbank.IBTrans_Write.InTransaction then
      HarddriveClone2.Log.Info('TThreadCopyFiles.AktualNewFiles: InTransaction ' + IntToStr(i1));
  end
  );
  t.OnTerminate := EndAktualNewFiles;
  t.Start;

end;


procedure TThreadCopyFiles.EndChangedFiles(Sender: TObject);
begin
  if dm_Datenbank.IBTrans_Write.InTransaction then
    HarddriveClone2.Log.Info('TThreadCopyFiles.EndChangedFiles: InTransaction ');
  if Assigned(fOnEndChangedFiles) then
    fOnEndChangedFiles(Self);
end;


procedure TThreadCopyFiles.ChangedFiles(aJoId: Integer);
var
  t: TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  var
    i1: Integer;
    JobDatei: TVWJobDatei;
    Zielpfad: string;
  begin
    fCancel := false;
    fVWJobDateiList.ReadChangedFiles(aJoId);

    if Assigned(fOnProgressStart) then
    begin
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        fOnProgressStart(fVWJobDateiList.Count, fCancel);
        if Assigned(fOnInfo) then
          fOnInfo('Kopiere geänderte Dateien', '', fCancel);
        if fCancel then
          exit;
        //fOnCopyFilesStart('Kopiere geänderte Dateien', fVWJobDateiList.Count);
      end);
    end;

    for i1 := 0 to fVWJobDateiList.Count -1 do
    begin
      JobDatei := fVWJobDateiList.Item[i1];
      if Assigned(fOnProgressInfo) then
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          if Assigned(fOnInfoProzess) then
            fOnInfoProzess(JobDatei.FeldList.FieldByName('jd_datei').AsString, fCancel);
          if Assigned(fOnProgressInfo) then
            fOnProgressInfo(i1+1, fCancel);
          if fCancel then
            exit;

          if dm_Datenbank.IBTrans_Write.InTransaction then
            HarddriveClone2.Log.Info('TThreadCopyFiles.ChangedFiles: InTransaction ' + IntToStr(i1));

          ZielPfad := ExtractFilePath(JobDatei.FeldList.FieldByName('jd_datei').AsString);
          if not DirectoryExists(ZielPfad) then
            ForceDirectories(ZielPfad);
          CopyFile(PWideChar(JobDatei.FeldList.FieldByName('da_datei').AsString), PWideChar(JobDatei.FeldList.FieldByName('jd_datei').AsString), false);

          fDBJobDatei.Read(JobDatei.FeldList.FieldByName('jd_id').AsInteger);
          if fDBJobDatei.Gefunden then
          begin
            fDBJobDatei.Dateidatum  := JobDatei.FeldList.FieldByName('da_dateidatum').AsDateTime;
            fDBJobDatei.changedatum := fStartZeit;
            fDBJobDatei.savetodb;
          end;

          if dm_Datenbank.IBTrans_Write.InTransaction then
            HarddriveClone2.Log.Info('TThreadCopyFiles.ChangedFiles: InTransaction ' + IntToStr(i1));

         // Sleep(1000);
        end);
      end;
    end;

  end
  );
  t.OnTerminate := EndChangedFiles;
  t.Start;

end;



end.
