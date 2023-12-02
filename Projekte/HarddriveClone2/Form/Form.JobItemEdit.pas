unit Form.JobItemEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.ExtCtrls, AdvEdit, AdvEdBtn, AdvDirectoryEdit, DB.Job;

type
  Tfrm_JobItemEdit = class(Tfrm_Base)
    lbl_Quellverzeichnis: TLabel;
    lbl_Zielverzeichnis: TLabel;
    edt_Quellverzeichnis: TAdvDirectoryEdit;
    edt_Zielverzeichnis: TAdvDirectoryEdit;
    Panel1: TPanel;
    btn_Save: TButton;
    btn_Cancel: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    edt_Prio: TSpinEdit;
    btn_PfadeIgnorieren: TButton;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    cbx_Aktiv: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_PfadeIgnorierenClick(Sender: TObject);
  private
    fCancel: Boolean;
    fDBJob: TDBJob;
    fOnShowPfadeIgnorieren: TNotifyEvent;
    procedure SaveJob;
  protected
  public
    property Cancel: Boolean read fCancel;
    procedure setJob(aDBJob: TDBJob);
    procedure AktualForm; override;
    property OnShowPfadeIgnorieren: TNotifyEvent read fOnShowPfadeIgnorieren write fOnShowPfadeIgnorieren;
  end;

var
  frm_JobItemEdit: Tfrm_JobItemEdit;

implementation

{$R *.dfm}


procedure Tfrm_JobItemEdit.FormCreate(Sender: TObject);
begin
  inherited;
  fCancel := true;
  fDBJob := nil;
end;

procedure Tfrm_JobItemEdit.FormDestroy(Sender: TObject);
begin //
  inherited;

end;


procedure Tfrm_JobItemEdit.setJob(aDBJob: TDBJob);
begin
  fDBJob := aDBJob;
  if fDBJob <> nil then
  begin
    edt_Quellverzeichnis.Text := fDBJob.Quellpfad;
    edt_Zielverzeichnis.Text  := fDBJob.Zielpfad;
    edt_Prio.Value            := fDBJob.Prio;
    cbx_Aktiv.Checked         := fDBJob.Aktiv;
  end;
end;

procedure Tfrm_JobItemEdit.AktualForm;
begin
  inherited;

end;

procedure Tfrm_JobItemEdit.btn_CancelClick(Sender: TObject);
begin
  close;
end;


procedure Tfrm_JobItemEdit.btn_SaveClick(Sender: TObject);
begin
  fCancel := false;
  if fDBJob = nil then
  begin
    close;
    exit;
  end;

  SaveJob;
  close;
end;

procedure Tfrm_JobItemEdit.SaveJob;
begin
  fDBJOb.Quellpfad := IncludeTrailingPathDelimiter(edt_Quellverzeichnis.Text);
  fDBJob.Zielpfad  := IncludeTrailingPathDelimiter(edt_Zielverzeichnis.Text);
  fDBJOb.Prio      := edt_Prio.Value;
  fDBJob.Aktiv     := cbx_Aktiv.Checked;
  fDBJob.SaveToDB;
end;


procedure Tfrm_JobItemEdit.btn_PfadeIgnorierenClick(Sender: TObject);
begin
  if fDBJob.Id = 0 then
    SaveJob;
  if Assigned(fOnShowPfadeIgnorieren) then
    fOnShowPfadeIgnorieren(fDBJob);
end;



end.
