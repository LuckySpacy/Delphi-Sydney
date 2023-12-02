unit Form.Option;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Samples.Spin, Vcl.ComCtrls, AdvEdit, AdvEdBtn, AdvDirectoryEdit, Objekt.Option;

type
  Tfrm_Option = class(TForm)
    lbl_Backupname: TLabel;
    edt_von: TEdit;
    Label1: TLabel;
    edt_Nach: TAdvDirectoryEdit;
    Label2: TLabel;
    edt_Startzeit: TDateTimePicker;
    Label9: TLabel;
    edt_Anzahl_Ziel: TSpinEdit;
    Panel1: TPanel;
    btn_Ok: TButton;
    btn_Cancel: TButton;
    cbx_Verschieben: TCheckBox;
    Label3: TLabel;
    edt_Anzahl_Quell: TSpinEdit;
    cbx_Zippen: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  private
    fCancel: Boolean;
    fOption: TOption;
  public
    procedure FillOption(aOption: TOption);
    procedure setOption(aOption: TOption);
    property Cancel: Boolean read fCancel;
  end;

var
  frm_Option: Tfrm_Option;

implementation

{$R *.dfm}


procedure Tfrm_Option.FormCreate(Sender: TObject);
begin
  fCancel := true;
  fOption := nil;
  edt_von.Text := '';
  edt_Nach.Text := '';
  edt_Anzahl_Ziel.Value := 0;
  edt_Anzahl_Quell.Value := 0;
  cbx_Verschieben.Checked := false;
  edt_Startzeit.Time := now;
end;

procedure Tfrm_Option.FormDestroy(Sender: TObject);
begin  //

end;

procedure Tfrm_Option.setOption(aOption: TOption);
begin
  fOption := aOption;
  if fOption = nil then
    exit;
  edt_Von.Text := fOption.Von;
  edt_Nach.Text := fOption.Nach;
  //edt_StartZeit.Time := fOption.StartZeit;
  edt_Anzahl_Quell.Text  := fOption.Anzahl_Quell;
  edt_Anzahl_Ziel.Text  := fOption.Anzahl_Ziel;
  cbx_Verschieben.Checked := fOption.Verschieben = '1';
  cbx_Zippen.Checked := fOption.Zippen = '1';
end;

procedure Tfrm_Option.btn_CancelClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_Option.btn_OkClick(Sender: TObject);
begin
  fCancel := false;
  close;
end;

procedure Tfrm_Option.FillOption(aOption: TOption);
begin
  aOption.Von  := edt_Von.Text;
  aOption.Nach  := edt_Nach.Text;
  //aOption.StartZeit := edt_Startzeit.Time;
  aOption.Anzahl_Quell := edt_Anzahl_Quell.Text;
  aOption.Anzahl_Ziel := edt_Anzahl_Ziel.Text;
  if cbx_Verschieben.Checked then
    aOption.Verschieben := '1'
  else
    aOption.Verschieben := '0';
  if cbx_Zippen.Checked then
    aOption.Zippen := '1'
  else
    aOption.Zippen := '0';
end;


end.
