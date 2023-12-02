unit Form.Datei;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, AdvEdit, AdvEdBtn, AdvFileNameEdit,
  Objekt.Datei;

type
  Tfrm_Datei = class(TForm)
    Panel1: TPanel;
    btn_Ok: TButton;
    btn_Cancel: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edt_Betreff: TEdit;
    edt_Datei: TAdvFileNameEdit;
    Label3: TLabel;
    edt_EMail: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
  private
    fCancel: Boolean;
  public
    property Cancel: Boolean read fCancel;
    procedure setDatei(aDatei: TDatei);
  end;

var
  frm_Datei: Tfrm_Datei;

implementation

{$R *.dfm}


procedure Tfrm_Datei.FormCreate(Sender: TObject);
begin
  fCancel := true;
end;


procedure Tfrm_Datei.setDatei(aDatei: TDatei);
begin
  if aDatei = nil then
  begin
    edt_Betreff.Text := '';
    edt_Datei.Text   := '';
    edt_EMail.Text   := '';
  end
  else
  begin
    edt_Betreff.Text := aDatei.Betreff;
    edt_Datei.Text   := aDatei.Datei;
    edt_EMail.Text   := aDatei.EMail;
  end;
end;

procedure Tfrm_Datei.btn_CancelClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_Datei.btn_OkClick(Sender: TObject);
begin
  fCancel := false;
  close;
end;


end.
