unit Form.JobDetail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Objekt.Job;

type
  Tfrm_JobDetail = class(TForm)
    pnl_Toolbar: TPanel;
    btn_Neu: TButton;
    btn_Delete: TButton;
    pnl_Ordner: TPanel;
    Label1: TLabel;
    lsb_Ordner: TListBox;
    btn_Zurueck: TButton;
    procedure btn_NeuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_ZurueckClick(Sender: TObject);
  private
    fJob: TJob;
    fOnZurueck: TNotifyEvent;
    procedure DeleteOrdner;
  public
    procedure setJob(aJob: TJob);
    property OnZurueck: TNotifyEvent read fOnZurueck write fOnZurueck;
  end;

var
  frm_JobDetail: Tfrm_JobDetail;

implementation

{$R *.dfm}


procedure Tfrm_JobDetail.FormCreate(Sender: TObject);
begin //
  fJob := nil;
end;

procedure Tfrm_JobDetail.FormDestroy(Sender: TObject);
begin //

end;


procedure Tfrm_JobDetail.setJob(aJob: TJob);
begin
  fJob := aJob;
  fJob.LoadIgnoreFolder(lsb_Ordner.Items);
end;

procedure Tfrm_JobDetail.btn_DeleteClick(Sender: TObject);
begin
  DeleteOrdner;
end;

procedure Tfrm_JobDetail.btn_NeuClick(Sender: TObject);
var
  Ordner: string;
begin
  Ordner := '';
  InputQuery('Neuer Ordner', 'Ordnername:', Ordner);
  if Trim(Ordner) = '' then
    exit;
  lsb_Ordner.Items.Add(Ordner);
  if fJob = nil then
    exit;
  fJob.SaveIgnoreFolder(lsb_Ordner.Items);
end;


procedure Tfrm_JobDetail.btn_ZurueckClick(Sender: TObject);
begin
  if Assigned(fOnZurueck) then
    fOnZurueck(Self);
end;

procedure Tfrm_JobDetail.DeleteOrdner;
begin
  if lsb_Ordner.ItemIndex < 0 then
    exit;
  lsb_Ordner.DeleteSelected;
end;

end.
