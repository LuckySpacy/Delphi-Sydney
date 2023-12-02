unit Form.JobItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  Tfrm_JobItem = class(Tfrm_Base)
    Panel1: TPanel;
    lbl_Ziel: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    lbl_Quelle: TLabel;
    lbl_Prio: TLabel;
    Shape1: TShape;
    procedure Panel1Click(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
  private
    fOnSelected: TNotifyEvent;
    fOnJobItemDblClick: TNotifyEvent;
  protected
  public
    procedure setSelect(aSelect: Boolean);
    property OnSelected: TNotifyEvent read fOnSelected write fOnSelected;
    property OnJobItemDblClick: TNotifyEvent read fOnJobItemDblClick write fOnJobItemDblClick;
    procedure AktualForm; override;
  end;

var
  frm_JobItem: Tfrm_JobItem;

implementation

{$R *.dfm}

procedure Tfrm_JobItem.AktualForm;
begin
  inherited;

end;

procedure Tfrm_JobItem.Panel1Click(Sender: TObject);
begin
  if Assigned(fOnSelected) then
    fOnSelected(Self);
end;

procedure Tfrm_JobItem.Panel1DblClick(Sender: TObject);
begin
  if Assigned(fOnJobItemDblClick) then
    fOnJobItemDblClick(Self);
end;

procedure Tfrm_JobItem.setSelect(aSelect: Boolean);
begin
  Shape1.Visible := aSelect;
end;

end.
