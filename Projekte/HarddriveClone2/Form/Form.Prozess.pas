unit Form.Prozess;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Objekt.DateiList, Objekt.Dateisystem, Thread.FestplatteEinlesen,
  Objekt.Datei, DB.Datei, DB.JobDatei, Thread.CopyFiles, Objekt.FestplatteEinlesen,
  Objekt.CloneManager;

type
  Tfrm_Prozess = class(Tfrm_Base)
    pnl_Prozess: TPanel;
    lbl_Prozessname: TLabel;
    pg: TProgressBar;
    lbl_Caption: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    fDateisystem: TDateisystem;
    fQuell: TDateiList;
    fFestplatteEinlesen: TFestplatteEinlesen;
    fThreadCopyFiles: TThreadCopyFiles;
    fJobIndex: Integer;
    fDBDatei: TDBDatei;
    fDBJobDatei: TDBJobDatei;
    fCloneManager: TCloneManager;
    fCancel: Boolean;
    fOnEnd: TNotifyEvent;
    procedure EndQuellverzeichnisEinlesen(Sender: TObject);
    procedure setPnlProzessCenter;
    procedure CopyFilesStart(aCaption: string; aCount: Integer);
    procedure CopyFilesProgress(aCaption: string; aProgress: Integer);
    procedure EndAktualNewFiles(Sender: TObject);
    procedure EndChangedFiles(Sender: TObject);
    procedure  Info(aCaption, aProzessInfo: string; var aCancel: Boolean);
    procedure  InfoProzess(aProzessInfo: string; var aCancel: Boolean);
    procedure  ProgressStart(aCount: Integer; var aCancel: Boolean);
    procedure  ProgressInfo(aProgress: Integer; var aCancel: Boolean);
    procedure Finish(Sender: TObject);
  public
    procedure Start;
    procedure Stop;
    property OnEnd: TNotifyEvent read fOnEnd write fOnEnd;
    procedure SyncZielPfad(aJoId: Integer);
  end;

var
  frm_Prozess: Tfrm_Prozess;

implementation

{$R *.dfm}

uses
  Objekt.HarddriveClone2, dm.Datenbank, fmx.Types;

{ Tfrm_Prozess }




procedure Tfrm_Prozess.FormCreate(Sender: TObject);
begin
  inherited;
  fCancel := false;
  fDateisystem := TDateisystem.Create;
  fQuell := TDateiList.Create;
  fDBDatei := TDBDatei.Create(nil);
  fDBDatei.Trans := dm_Datenbank.IBTrans_Write;
  fDBJobDatei := TDBJobDatei.Create(nil);
  fDBJobDatei.Trans := dm_Datenbank.IBTrans_Write;

  fThreadCopyFiles := TThreadCopyFiles.Create;

  fFestplatteEinlesen := TFestplatteEinlesen.Create;
  fCloneManager := TCloneManager.Create;
  fCloneManager.OnInfo := Info;
  fCloneManager.OnInfoProzess := InfoProzess;
  fCloneManager.OnProgressStart := ProgressStart;
  fCloneManager.OnProgressInfo := ProgressInfo;
  fCloneManager.setQuell(fQuell);
  fCloneManager.OnEnd := Finish;


end;

procedure Tfrm_Prozess.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fQuell);
  FreeAndNil(fDateisystem);
  FreeAndNil(fDBDatei);
  FreeAndNil(fDBJobDatei);
  FreeAndNil(fThreadCopyFiles);
  FreeAndNil(fFestplatteEinlesen);
  FreeAndNil(fCloneManager);
  inherited;
end;

procedure Tfrm_Prozess.FormResize(Sender: TObject);
begin
  setPnlProzessCenter;
end;



procedure Tfrm_Prozess.setPnlProzessCenter;
var
  PanelHalfHeight: Integer;
  FormHalfHeight: Integer;
begin
  PanelHalfHeight := trunc(pnl_Prozess.Height / 2);
  FormHalfHeight  := trunc(Height / 2);
  pnl_Prozess.Top := FormHalfHeight - PanelHalfHeight;
  pnl_Prozess.Left := 20;
  pnl_Prozess.Width := Width - pnl_Prozess.Left - 20;
end;

procedure Tfrm_Prozess.CopyFilesProgress(aCaption: string; aProgress: Integer);
begin
  lbl_Prozessname.Caption := aCaption;
  pg.Position := aProgress;
  lbl_Prozessname.Refresh;
end;

procedure Tfrm_Prozess.CopyFilesStart(aCaption: string; aCount: Integer);
begin
  lbl_Caption.Caption := aCaption;
  pg.Max := aCount;
  pg.Position := 0;
end;




procedure Tfrm_Prozess.EndAktualNewFiles(Sender: TObject);
begin
  fThreadCopyFiles.ChangedFiles(HarddriveClone2.DBJobList.Item[fJobIndex].Id);
end;

procedure Tfrm_Prozess.EndChangedFiles(Sender: TObject);
begin

end;

procedure Tfrm_Prozess.EndQuellverzeichnisEinlesen(Sender: TObject);
begin  //

end;


procedure Tfrm_Prozess.Start;
begin
  fCancel := false;
  fQuell.Clear;
  fCloneManager.Start;
end;



procedure Tfrm_Prozess.Stop;
begin
  fCancel := true;
  fCloneManager.Cancel := true;
end;




procedure Tfrm_Prozess.SyncZielPfad(aJoId: Integer);
begin
  fCancel := false;
  fCloneManager.Cancel := false;
  fCloneManager.OnSyncZielPfadEnd := Finish;
  fCloneManager.SyncZiel(aJoId);
end;

procedure Tfrm_Prozess.Info(aCaption, aProzessInfo: string;
  var aCancel: Boolean);
begin
  aCancel := fCancel;
  if aCancel then
    log.d('true');
  lbl_Caption.Caption := aCaption;
  lbl_Prozessname.Caption := aProzessInfo;
  lbl_Prozessname.Invalidate;
  lbl_Caption.Invalidate;
  lbl_Prozessname.Refresh;
  lbl_Caption.Refresh;
  HarddriveClone2.Log.Info(aCaption);
end;

procedure Tfrm_Prozess.InfoProzess(aProzessInfo: string; var aCancel: Boolean);
begin
  aCancel := fCancel;
  if aCancel then
    log.d('true');
  lbl_Prozessname.Caption := aProzessInfo;
  lbl_Prozessname.Invalidate;
  lbl_Prozessname.Refresh;
  HarddriveClone2.Log.Info(aProzessInfo);
end;

procedure Tfrm_Prozess.ProgressInfo(aProgress: Integer; var aCancel: Boolean);
begin
  aCancel := fCancel;
  if aCancel then
    log.d('true');
  pg.Position := aProgress;
  Application.ProcessMessages;
end;

procedure Tfrm_Prozess.ProgressStart(aCount: Integer; var aCancel: Boolean);
begin
  aCancel := fCancel;
  if aCancel then
    log.d('true');
  pg.Position := 0;
  pg.Max := aCount;
end;


procedure Tfrm_Prozess.Finish(Sender: TObject);
begin
  if Assigned(fOnEnd) then
    fOnEnd(Self);
end;


end.
