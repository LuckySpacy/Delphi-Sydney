unit Form.Job;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Objekt.JobViewList;

type
  Tfrm_Job = class(TForm)
    pnl_Toolbar: TPanel;
    btn_Neu: TButton;
    btn_Delete: TButton;
    ScrollBox1: TScrollBox;
    tmr_ScrollboxRepaint: TTimer;
    procedure btn_NeuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmr_ScrollboxRepaintTimer(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
  private
    fJobViewList: TJobViewList;
    fOnJobDblClick: TNotifyEvent;
    procedure ShowQuellZiel;
    procedure AktualGrid;
    procedure JobViewSelect(Sender: TObject);
    procedure JobDblClick(Sender: TObject);
    procedure JobDelete;
  public
    property OnJobDblClick: TNotifyEvent read fOnJobDblClick write fOnJobDblClick;
  end;

var
  frm_Job: Tfrm_Job;

implementation

{$R *.dfm}

uses
  System.UITypes, Form.QuellZiel, Form.JobView, Objekt.HarddriveClone, Objekt.Job;

{ Tfrm_Job }


procedure Tfrm_Job.FormCreate(Sender: TObject);
begin//
  fJobViewList := TJobViewList.Create;
  fJobViewList.ParentJobView := ScrollBox1;
  HarddriveClone.JobList.LoadFromFile;
  HarddriveClone.JobList.PrioSort;
end;

procedure Tfrm_Job.FormDestroy(Sender: TObject);
begin//
  FreeAndNil(fJobViewList);
end;


procedure Tfrm_Job.FormShow(Sender: TObject);
begin
  AktualGrid;
end;

procedure Tfrm_Job.JobDblClick(Sender: TObject);
var
  JobView: Tfrm_JobView;
begin  //
  if Assigned(fOnJobDblClick) then
  begin
    JobView := fJobViewList.getSelected;
    if JobView = nil then
      exit;
    fOnJobDblClick(JobView.Job);
  end;
end;

procedure Tfrm_Job.JobDelete;
var
  JobView: Tfrm_JobView;
  FullFilename: string;
begin
  if MessageDlg('Diesen Job wirklich löschen?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], mrNo) <> mrYes then
    exit;
  JobView := fJobViewList.getSelected;
  FullFilename := JobView.FullFilename;
  if fJobViewList.DeleteSelected then
  begin
    HarddriveClone.JobList.DeleteByFilename(FullFilename);
    AktualGrid;
  end;
end;

procedure Tfrm_Job.JobViewSelect(Sender: TObject);
begin
  fJobViewList.setSelect(Tfrm_JobView(Sender));
end;

procedure Tfrm_Job.AktualGrid;
var
  i1: Integer;
  Job: TJob;
  JobView: Tfrm_JobView;
begin
  fJobViewList.Clear;
  for i1 := 0 to HarddriveClone.JobList.Count -1 do
  begin
    Job := HarddriveClone.JobList.Item[i1];
    JobView := fJobViewList.Add;
    JobView.lbl_Ziel.Caption  := Job.Ziel;
    JobView.lbl_Quelle.Caption := Job.Quell;
    JobView.lbl_Prio.Caption := 'Priorität: ' + IntToStr(Job.Prio);
    JobView.OnSelected := JobViewSelect;
    JobView.OnJobDblClick := JobDblClick;
    JobView.FullFilename := Job.FullFilename;
    JobView.Job := Job;
  end;
  ScrollBox1.Visible := false;
  tmr_ScrollboxRepaint.Enabled := true;

end;

procedure Tfrm_Job.btn_DeleteClick(Sender: TObject);
begin
  JobDelete;
end;

procedure Tfrm_Job.btn_NeuClick(Sender: TObject);
begin
  ShowQuellZiel;
end;


procedure Tfrm_Job.ShowQuellZiel;
var
  Form: Tfrm_QuellZiel;
  JobView: Tfrm_JobView;
begin
  Form := Tfrm_QuellZiel.Create(Self);
  try
    Form.ShowModal;
    if Form.Cancel then
      exit;
    JobView := fJobViewList.Add;
    JobView.lbl_Ziel.Caption  := Form.Zielpfad;
    JobView.lbl_Quelle.Caption := Form.Quellpfad;
    JobView.OnSelected := JobViewSelect;
    JobView.OnJobDblClick := JobDblClick;
    JobView.FullFilename := Form.FullFilename;
    JobView.Job := Form.Job;
  finally
    FreeAndNil(Form);
  end;
end;

procedure Tfrm_Job.tmr_ScrollboxRepaintTimer(Sender: TObject);
begin
  tmr_ScrollboxRepaint.Enabled := false;
  ScrollBox1.Visible := true;
end;

end.
