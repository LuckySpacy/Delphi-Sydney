unit Form.HarddriveClone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Form.Job, Form.JobDetail, Objekt.HarddriveClone;

type
  Tfrm_HarddriveClone = class(TForm)
    pg: TPageControl;
    tbs_Job: TTabSheet;
    tbs_detail: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fFormJob: Tfrm_Job;
    fFormDetail: Tfrm_JobDetail;
    procedure JobDetailZurueck(Sender: TObject);
    procedure JobDblClick(Sender: TObject);
  public
  end;

var
  frm_HarddriveClone: Tfrm_HarddriveClone;

implementation

{$R *.dfm}

uses
  Objekt.Job;

procedure Tfrm_HarddriveClone.FormCreate(Sender: TObject);
var
  page: Integer;
begin
  HarddriveClone := THarddriveClone.Create;
  fFormJob := Tfrm_Job.Create(Self);
  fFormJob.Parent := tbs_Job;
  fFormJob.Align  := alClient;
  fFormJob.OnJobDblClick := JobDblClick;
  fFormJob.Show;
  fFormDetail := Tfrm_JobDetail.Create(Self);
  fFormDetail.Parent := tbs_Detail;
  fFormDetail.Align  := alClient;
  fFormDetail.OnZurueck := JobDetailZurueck;
  fFormDetail.Show;
  for page := 0 to pg.PageCount - 1 do
    pg.Pages[page].TabVisible := false;
  pg.ActivePage := tbs_Job;
end;

procedure Tfrm_HarddriveClone.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fFormJob);
  FreeAndNil(fFormDetail);
  FreeAndNil(HarddriveClone);
end;

procedure Tfrm_HarddriveClone.JobDblClick(Sender: TObject);
begin
  fFormDetail.setJob(TJob(Sender));
  pg.ActivePage := tbs_detail;
end;

procedure Tfrm_HarddriveClone.JobDetailZurueck(Sender: TObject);
begin
  pg.ActivePage := tbs_Job;
end;

end.
