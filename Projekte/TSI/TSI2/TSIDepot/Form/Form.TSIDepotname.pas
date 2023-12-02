unit Form.TSIDepotname;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, dm.Style, ClientModule.Classes,
  FMX.Objects;

type
  TOnCloseFormEvent=procedure(aDepotname: string; aDone: Boolean) of object;
  Tfrm_TSIDepotname = class(TForm)
    Lay_Top: TLayout;
    lbl_Depot: TLabel;
    btn_Save: TSpeedButton;
    edt_Depotname: TEdit;
    btn_Cancel: TSpeedButton;
    rec_Background: TRectangle;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
  private
    fOnCloseForm: TOnCloseFormEvent;
    fDpId: Integer;
    fBeId: Integer;
  public
    property OnCloseForm: TOnCloseFormEvent read fOnCloseForm write fOnCloseForm;
    property DpId: Integer read fDpId write fDpId;
    property BeId: Integer read fBeId write fBeId;
  end;

var
  frm_TSIDepotname: Tfrm_TSIDepotname;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure Tfrm_TSIDepotname.btn_CancelClick(Sender: TObject);
begin
  if Assigned(fOnCloseForm) then
    fOnCloseForm(edt_Depotname.Text, false);
end;

procedure Tfrm_TSIDepotname.btn_SaveClick(Sender: TObject);
begin
  if Assigned(fOnCloseForm) then
    fOnCloseForm(edt_Depotname.Text, true);
end;

end.
