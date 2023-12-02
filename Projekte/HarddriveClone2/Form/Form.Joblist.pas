unit Form.Joblist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, DB.JobList, Objekt.ObjektList, Form.JobItem, db.Job, db.JobDateiList,
  db.DateiList;

type
  TSyncZielEvent = procedure(aJoId: Integer) of object;
  Tfrm_Joblist = class(Tfrm_Base)
    Panel1: TPanel;
    btn_Neu: TButton;
    btn_Zurueck: TButton;
    scb: TScrollBox;
    btn_Delete: TButton;
    btn_SyncZielpfad: TButton;
    btn_ResetChangeDatumForJob: TButton;
    btn_ResetChangedatumForAll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_NeuClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_ZurueckClick(Sender: TObject);
    procedure btn_SyncZielpfadClick(Sender: TObject);
    procedure btn_ResetChangeDatumForJobClick(Sender: TObject);
    procedure btn_ResetChangedatumForAllClick(Sender: TObject);
  private
    fDBJobList: TDBJobList;
    fJobItemList: TObjektList;
    fOnShowJobItemEdit: TNotifyEvent;
    fSelectJoId: Integer;
    fOnSyncZiel: TSyncZielEvent;
    fDBJobDateiList: TDBJobDateiList;
    fDBDateiList: TDBDateiList;
    procedure AktualGrid;
    procedure ShowJobItemEdit(aDBJob: TDBJob);
    procedure JobItemClick(Sender: TObject);
    procedure UnSelectAllJobItems;
    procedure JobItemDblClick(Sender: TObject);
    function getSelectedJobItem: Tfrm_JobItem;
    procedure JobDelete;
  protected
  public
    property OnShowJobItemEdit: TNotifyEvent read fOnShowJobItemEdit write fOnShowJobItemEdit;
    property OnSyncZiel: TSyncZielEvent read fOnSyncZiel write fOnSyncZiel;
    procedure AktualForm; override;
  end;

var
  frm_Joblist: Tfrm_Joblist;

implementation

{$R *.dfm}

uses
  dm.Datenbank, Form.JobItemEdit, System.UITypes;



procedure Tfrm_Joblist.FormCreate(Sender: TObject);
begin
  inherited;
  fDBJobList := TDBJobList.Create;
  fDBJobList.Trans := dm_Datenbank.IBTrans_Write;
  fJobItemList := TObjektList.Create;
  fSelectJoId := 0;

  fDBJobDateiList := TDBJobDateiList.Create;
  fDBJobDateiList.Trans := dm_Datenbank.IBTrans_Write;
  fDBDateiList    := TDBDateiList.Create;
  fDBDateiList.Trans := dm_Datenbank.IBTrans_Write;

end;

procedure Tfrm_Joblist.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDBJobDateiList);
  FreeAndNil(fDBDateiList);
  FreeAndNil(fDBJobList);
  FreeAndNil(fJobItemList);
  inherited;
end;

procedure Tfrm_Joblist.FormShow(Sender: TObject);
begin
  inherited;
  AktualGrid;
end;



procedure Tfrm_Joblist.AktualForm;
begin
  AktualGrid;
end;

procedure Tfrm_Joblist.AktualGrid;
var
  i1: Integer;
  JobItem: Tfrm_JobItem;
  s: string;
begin
  fJobItemList.Clear;
  FDBJobList.ReadAll;
  for i1 := 0 to fDBJobList.Count -1 do
  begin
    JobItem := Tfrm_JobItem.Create(scb);
    JobItem.Parent := scb;
    JobItem.Align := alTop;
    JobItem.Tag   := fDBJobList.Item[i1].Id;
    JobItem.Objects := fDBJobList.Item[i1];
    JobItem.lbl_Quelle.Caption := fDBJobList.Item[i1].Quellpfad;
    JobItem.lbl_Ziel.Caption := fDBJobList.Item[i1].Zielpfad;

    s := 'Priorität ' + IntToStr(fDBJobList.Item[i1].Prio);
    if fDBJobList.Item[i1].Aktiv then
      s := s + '  / Aktiv'
    else
      s := s + '  / Inaktiv';

    JobItem.lbl_Prio.Caption := s;
    JobItem.OnSelected := JobItemClick;
    JobItem.OnJobItemDblClick := JobItemDblClick;
    JobItem.Show;
    fJobItemList.Add(JobItem);
  end;
end;


procedure Tfrm_Joblist.btn_DeleteClick(Sender: TObject);
begin
  JobDelete;
end;

procedure Tfrm_Joblist.btn_NeuClick(Sender: TObject);
begin
  ShowJobItemEdit(nil);
end;


procedure Tfrm_Joblist.btn_ResetChangedatumForAllClick(Sender: TObject);
begin
  fDBDateiList.ResetChangeDatumForAll;
  fDBJobDateiList.ResetChangeDatumForAll;
  ShowMessage('Erledigt');
end;

procedure Tfrm_Joblist.btn_ResetChangeDatumForJobClick(Sender: TObject);
var
  s: string;
begin
  if fSelectJoId = 0 then
  begin
    s := 'Kein Job ausgewählt';
    MessageDlg(s, TMsgDlgType.mtInformation, [mbOk], 0);
    exit;
  end;
  fDBDateiList.ResetChangeDatumFor(fSelectJoId);
  fDBJobDateiList.ResetChangeDatumFor(fSelectJoId);
  ShowMessage('Erledigt');
end;

procedure Tfrm_Joblist.btn_SyncZielpfadClick(Sender: TObject);
var
  s: string;
begin
  if fSelectJoId = 0 then
  begin
    s := 'Kein Job ausgewählt';
    MessageDlg(s, TMsgDlgType.mtInformation, [mbOk], 0);
    exit;
  end;

  s := 'Das Zielverzeichnis zu synchronisieren kann mehrere Stunden dauern' + sLineBreak +
       'Möchtest du jetzt wirklich synchronisieren?';
  if MessageDlg(s, TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;


  close;
  if Assigned(fOnSyncZiel) then
    fOnSyncZiel(fSelectJoId);

end;

procedure Tfrm_Joblist.btn_ZurueckClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_Joblist.ShowJobItemEdit(aDBJob: TDBJob);
var
  Form: Tfrm_JobItemEdit;
begin
  if aDBJob = nil then
    aDBJob := fDBJobList.Add;

  if Assigned(fOnShowJobItemEdit) then
    fOnShowJobItemEdit(aDBJob);
  exit;


  Form := Tfrm_JobItemEdit.Create(Self);
  try
    if aDBJob <> nil then
    begin
      Form.edt_Quellverzeichnis.Text := aDBJob.Quellpfad;
      Form.edt_Zielverzeichnis.Text  := aDBJob.Zielpfad;
      Form.edt_Prio.Value            := aDBJob.Prio;
    end;

    Form.ShowModal;
    if Form.Cancel then
      exit;
    if aDBJob = nil then
      aDBJob := fDBJobList.Add;

    aDBJOb.Quellpfad := IncludeTrailingPathDelimiter(Form.edt_Quellverzeichnis.Text);
    aDBJob.Zielpfad  := IncludeTrailingPathDelimiter(Form.edt_Zielverzeichnis.Text);
    aDBJOb.Prio      := Form.edt_Prio.Value;
    aDBJob.SaveToDB;
    AktualGrid;
  finally
    FreeAndNil(Form);
  end;

end;


procedure Tfrm_Joblist.UnSelectAllJobItems;
var
  i1: Integer;
begin
  for i1 := 0 to fJobItemList.Count -1 do
    Tfrm_JobItem(fJobItemList.Items[i1]).setSelect(false);
  fSelectJoId := 0;
end;


function Tfrm_Joblist.getSelectedJobItem: Tfrm_JobItem;
var
  i1: Integer;
begin
  Result := nil;
  for i1 := 0 to fJobItemList.Count -1 do
  begin
    if Tfrm_JobItem(fJobItemList.Items[i1]).Shape1.Visible then
    begin
      Result := Tfrm_JobItem(fJobItemList.Items[i1]);
      exit;
    end;
  end;
end;

procedure Tfrm_Joblist.JobItemClick(Sender: TObject);
begin  //
  UnSelectAllJobItems;
  Tfrm_JobItem(Sender).setSelect(true);
  if Tfrm_JobItem(Sender).Objects <> nil then
    fSelectJoId := TDBJob(Tfrm_JobItem(Sender).Objects).Id;
end;



procedure Tfrm_Joblist.JobItemDblClick(Sender: TObject);
var
  aDBJob: TDBJob;
begin
  aDBJob := TDBJob(Tfrm_JobItem(Sender).Objects);
  ShowJobItemEdit(aDBJob);
end;


procedure Tfrm_Joblist.JobDelete;
var
  JobItem: Tfrm_JobItem;
begin
  JobItem := getSelectedJobItem;
  if JobItem = nil then
  begin
    MessageDlg('Bitte den zu löschenden Job auswählen', TMsgDlgType.mtInformation, [mbOk], 0);
    exit;
  end;
  if MessageDlg('Job wirklich löschen?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], mrNo) <> mrYes then
    exit;
  if JobItem.Objects = nil then
    exit;
  TDBJob(JobItem.Objects).Delete;
  AktualGrid;
end;


end.
