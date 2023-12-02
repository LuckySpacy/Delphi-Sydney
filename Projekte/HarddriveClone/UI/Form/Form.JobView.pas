unit Form.JobView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Objekt.Job;

type
  Tfrm_JobView = class(TForm)
    Panel1: TPanel;
    lbl_Ziel: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    lbl_Quelle: TLabel;
    Shape1: TShape;
    lbl_Prio: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure lbl_PrioDblClick(Sender: TObject);
  private
    fOnSelected: TNotifyEvent;
    fFullFilename: string;
    fOnJobDblClick: TNotifyEvent;
    fJob: TJob;
  public
    property OnSelected: TNotifyEvent read fOnSelected write fOnSelected;
    procedure setSelect(aSelect: Boolean);
    property FullFilename: string read fFullFilename write fFullFilename;
    property OnJobDblClick: TNotifyEvent read fOnJobDblClick write fOnJobDblClick;
    property Job: TJob read fJob write fJob;
  end;

var
  frm_JobView: Tfrm_JobView;

implementation

{$R *.dfm}

procedure Tfrm_JobView.FormCreate(Sender: TObject);
begin
//  Bev_Frame.on
  fFullFilename := '';
  fJob := nil;
end;

procedure Tfrm_JobView.lbl_PrioDblClick(Sender: TObject);
var
  s: string;
  Prio: Integer;
begin
  InputQuery('Andere Priorität festlegen', 'Priorität', s);
  if not TryStrToInt(s, Prio) then
    Prio := 0;
  Job.Prio := Prio;
  Job.SaveToFile;
  lbl_Prio.Caption := 'Priorität: ' + IntToStr(Job.Prio);
end;

procedure Tfrm_JobView.Panel1Click(Sender: TObject);
begin
  if Assigned(fOnSelected) then
    fOnSelected(Self);
end;

procedure Tfrm_JobView.Panel1DblClick(Sender: TObject);
begin
  if Assigned(fOnJobDblClick) then
    fOnJobDblClick(Self);
end;

procedure Tfrm_JobView.setSelect(aSelect: Boolean);
begin
  Shape1.Visible := aSelect;
end;

end.
