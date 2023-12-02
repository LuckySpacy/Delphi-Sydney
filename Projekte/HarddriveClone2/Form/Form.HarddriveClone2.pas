unit Form.HarddriveClone2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Objekt.FormList, Form.JobList, Form.JobItemEdit,
  Form.IgnorePfad, Form.Main, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.Menus, Vcl.AppEvnts;

type
  Tfrm_Harddriveclone2 = class(TForm)
    TrayIcon: TTrayIcon;
    img: TImageList;
    pop: TPopupMenu;
    mnu_Start: TMenuItem;
    mnu_Stop: TMenuItem;
    mnu_Close: TMenuItem;
    mnu_Show: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    tmr_Autostart: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnu_ShowClick(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure mnu_CloseClick(Sender: TObject);
    procedure tmr_AutostartTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fFormJobList: Tfrm_JobList;
    fFormJobItemEdit: Tfrm_JobItemEdit;
    fFormIgnorePfad: Tfrm_IgnorePfad;
    fFormMain: Tfrm_Main;
    fFormList: TFormList;
    fFirstStart: Boolean;
    procedure ShowJobItemEdit(Sender: TObject);
    procedure ShowIgnorePfad(Sender: TObject);
    procedure CloseForm(Sender: TObject);
    procedure ShowJobList(Sender: TObject);
    procedure SyncZielPfad(aJoId: Integer);
    procedure BevorStart(Sender: TObject);
    procedure AfterStart(Sender: TObject);
  public
  end;

var
  frm_Harddriveclone2: Tfrm_Harddriveclone2;

implementation

{$R *.dfm}

uses
  Objekt.HarddriveClone2, dm.Datenbank, system.UITypes, DB.Job;



procedure Tfrm_Harddriveclone2.FormCreate(Sender: TObject);
begin
  HarddriveClone2 := THarddriveClone2.Create;

  fFormMain := Tfrm_Main.Create(Self);
  fFormMain.OnCloseForm := CloseForm;
  fFormMain.OnEinstellungClick := ShowJobList;
  fFormMain.OnBevorStart := BevorStart;
  fFormMain.OnAfterStart := AfterStart;

  fFormJobList     := Tfrm_JobList.Create(Self);
  fFormJobList.OnShowJobItemEdit  := ShowJobItemEdit;
  FFormJobList.OnCloseForm := CloseForm;
  fFormJobList.OnSyncZiel  := SyncZielPfad;

  fFormJobItemEdit := Tfrm_JobItemEdit.Create(Self);
  fFormJobItemEdit.BorderStyle := bsNone;
  fFormJobItemEdit.OnCloseForm := CloseForm;
  fFormJobItemEdit.OnShowPfadeIgnorieren := ShowIgnorePfad;

  fFormIgnorePfad := Tfrm_IgnorePfad.Create(Self);
  fFormIgnorePfad.OnCloseForm := CloseForm;


  fFormList := TFormList.Create;
  fFormList.ParentForm := Self;
  fFormList.AddToAllForms(fFormJobList);
  fFormList.AddToAllForms(fFormJobItemEdit);
  fFormList.AddToAllForms(fFormIgnorePfad);
  fFormList.AddToAllForms(fFormMain);

  TrayIcon.IconIndex := 3;
  TrayIcon.Visible := True;

  if not dm_Datenbank.Connect then
  begin
    MessageDlg('Fehler beim Verbinden zur Datenbank', TMsgDlgType.mtError, [mbOk], 0);
    Close;
    exit;
  end;
  fFirstStart := true;
  fFormList.ShowForm(fFormMain.Name);
  fFormMain.btn_Start.Enabled := true;
end;

procedure Tfrm_Harddriveclone2.FormDestroy(Sender: TObject);
begin
  FreeAndNil(HarddriveClone2);
  FreeAndNil(fFormList);
end;

procedure Tfrm_Harddriveclone2.FormShow(Sender: TObject);
begin
  {
  if not dm_Datenbank.Connect then
  begin
    MessageDlg('Fehler beim Verbinden zur Datenbank', TMsgDlgType.mtError, [mbOk], 0);
    Close;
    exit;
  end;
  fFormList.ShowForm(fFormMain.Name);
  }
  if fFirstStart then
  begin
    //tmr_Autostart.Enabled := true;
    Width  :=  HarddriveClone2.Ini.FormIni.FormWidth;
    Height := HarddriveClone2.Ini.FormIni.FormHeight;
  end;
  fFirstStart := false;
end;

procedure Tfrm_Harddriveclone2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  HarddriveClone2.Ini.FormIni.FormWidth  := Width;
  HarddriveClone2.Ini.FormIni.FormHeight := Height;
end;


procedure Tfrm_Harddriveclone2.mnu_CloseClick(Sender: TObject);
begin
  fFormMain.btn_StopClick(nil);
  close;
end;

procedure Tfrm_Harddriveclone2.mnu_ShowClick(Sender: TObject);
begin
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure Tfrm_Harddriveclone2.AfterStart(Sender: TObject);
begin
  TrayIcon.IconIndex := 1;
  fFormMain.btn_Start.Enabled := true;
end;

procedure Tfrm_Harddriveclone2.ApplicationEventsMinimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrayIcon.Visible := True;
end;

procedure Tfrm_Harddriveclone2.BevorStart(Sender: TObject);
begin
  TrayIcon.IconIndex := 0;
  fFormMain.btn_Start.Enabled := false;
end;

procedure Tfrm_Harddriveclone2.CloseForm(Sender: TObject);
begin
  fFormList.CloseForm;
end;


procedure Tfrm_Harddriveclone2.ShowIgnorePfad(Sender: TObject);
begin
  fFormIgnorePfad.setJob(TDBJob(Sender));
  fFormList.ShowForm(fFormIgnorePfad.Name);
end;

procedure Tfrm_Harddriveclone2.ShowJobItemEdit(Sender: TObject);
begin
  fFormJobItemEdit.setJob(TDBJob(Sender));
  fFormList.ShowForm(fFormJobItemEdit.Name);
end;



procedure Tfrm_Harddriveclone2.ShowJobList(Sender: TObject);
begin
  fFormList.ShowForm(fFormJobList.Name);

end;

procedure Tfrm_Harddriveclone2.SyncZielPfad(aJoId: Integer);
begin
  fFormMain.SyncZielPfad(aJoId);
end;

procedure Tfrm_Harddriveclone2.tmr_AutostartTimer(Sender: TObject);
begin
  exit;
  tmr_Autostart.Enabled := false;
  fFormMain.btn_Start.Click;
end;

end.
