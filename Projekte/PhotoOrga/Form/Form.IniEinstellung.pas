unit Form.IniEinstellung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.ChildBase, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  Tfrm_IniEinstellung = class(Tfrm_ChildBase)
    pnl_Left_Datenbank: TPanel;
    Label2: TLabel;
    pnl_Client_Datenbank: TPanel;
    edt_Bilderpfad: TEdit;
    Panel1: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CMVISIBLECHANGED(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
  private
    fCanSave: Boolean;
  public
    procedure Save;
  end;

var
  frm_IniEinstellung: Tfrm_IniEinstellung;

implementation

{$R *.dfm}

uses
  Objekt.PhotoOrga;


procedure Tfrm_IniEinstellung.FormCreate(Sender: TObject);
begin  //
  inherited;
  fCanSave := false;
  edt_Bilderpfad.Text   := PhotoOrga.Ini.Einstellung.Bilderpfad;
end;

procedure Tfrm_IniEinstellung.FormDestroy(Sender: TObject);
begin  //
  inherited;

end;


procedure Tfrm_IniEinstellung.CMShowingChanged(var Message: TMessage);
begin
  fCanSave := true;
  inherited;
end;

procedure Tfrm_IniEinstellung.CMVISIBLECHANGED(var Message: TMessage);
begin
  if (fCanSave) and (not Visible) then
    save;
  inherited;
end;


procedure Tfrm_IniEinstellung.Save;
begin
  PhotoOrga.Ini.Einstellung.Bilderpfad  := edt_Bilderpfad.Text;
end;

end.
