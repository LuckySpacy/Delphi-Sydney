unit Form.Rezept;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, tbButton, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Buttons, Datenmodul.DM, Form.Einstellung, Form.Uebersicht,
  Vcl.Menus, Vcl.StdCtrls, Form.NeuesRezept;

type
  Tfrm_Rezept = class(TForm)
    pnl_Button: TPanel;
    btn_Einstellung: TTBButton;
    MainMenu: TMainMenu;
    Einstellung1: TMenuItem;
    Label1: TLabel;
    btn_NeuesRezept: TTBButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_EinstellungClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure btn_NeuesRezeptClick(Sender: TObject);
  private
    fMaximzedValue: TRect;
    procedure ShowEinstellung;
    procedure ShowUebersicht;
    procedure ShowNeuesRezept;
    procedure setFormMaximized(aForm: TForm);
    procedure AktualMaximizedValue;
    function FormMaximized(aForm: TForm): Boolean;
    procedure FormUebersichtResize(Sender: TObject);
  public
  end;

var
  frm_Rezept: Tfrm_Rezept;

implementation

{$R *.dfm}


procedure Tfrm_Rezept.FormCreate(Sender: TObject);
begin //

end;

procedure Tfrm_Rezept.FormDblClick(Sender: TObject);
begin
  setFormMaximized(frm_Uebersicht);
end;

procedure Tfrm_Rezept.FormDestroy(Sender: TObject);
begin
  if frm_Einstellung <> nil then
    FreeAndNil(frm_Einstellung);
  if frm_Uebersicht <> nil then
    FreeAndNil(frm_Uebersicht);
end;



function Tfrm_Rezept.FormMaximized(aForm: TForm): Boolean;
begin
  Result := false;
  if aForm.WindowState = wsMaximized then
  begin
    Result := true;
    exit;
  end;
  AktualMaximizedValue;
  if (aForm.Height = fMaximzedValue.Height) and (aForm.Width = fMaximzedValue.Width)  then
    Result := true;
end;

procedure Tfrm_Rezept.FormResize(Sender: TObject);
begin
  if (frm_Uebersicht <> nil) and (frm_Uebersicht.Maximized) then
    setFormMaximized(frm_Uebersicht);
end;

procedure Tfrm_Rezept.FormShow(Sender: TObject);
begin //
  if not dm.Connect then
    ShowMessage(dm.LastError);
  ShowUebersicht;
end;




procedure Tfrm_Rezept.FormUebersichtResize(Sender: TObject);
begin
  if frm_Uebersicht = nil then
    exit;
  frm_uebersicht.Maximized := FormMaximized(frm_uebersicht);
end;

procedure Tfrm_Rezept.setFormMaximized(aForm: TForm);
begin //
  if aForm = nil then
    exit;
  aForm.Top  := 0;
  aForm.Left := 0;
  aForm.Width := Width - 20;
  aForm.Height := Height - 63 - pnl_Button.Height;
end;

procedure Tfrm_Rezept.ShowEinstellung;
var
  Maxim: Boolean;
begin //
  MaxIm := (frm_Uebersicht <> nil) and (frm_Uebersicht.WindowState = wsMaximized);

  if frm_Einstellung = nil then
    frm_Einstellung := Tfrm_Einstellung.Create(Self)
  else
    frm_Einstellung.BringToFront;
  if (frm_Uebersicht <> nil) and (Maxim) then
    setFormMaximized(frm_Uebersicht);
  frm_Einstellung.BringToFront;
end;

procedure Tfrm_Rezept.ShowNeuesRezept;
begin
  if frm_NeuesRezept = nil then
    frm_NeuesRezept := Tfrm_NeuesRezept.Create(Self)
  else
    frm_NeuesRezept.BringToFront;
end;

procedure Tfrm_Rezept.ShowUebersicht;
begin //
  if frm_Uebersicht = nil then
  begin
    frm_Uebersicht := Tfrm_Uebersicht.Create(Self);
    frm_Uebersicht.OnResize := FormUebersichtResize;
    setFormMaximized(frm_Uebersicht);
  end
  else
    frm_Uebersicht.BringToFront;
end;

procedure Tfrm_Rezept.AktualMaximizedValue;
begin
  fMaximzedValue.Left := 0;
  fMaximzedValue.Top  := 0;
  fMaximzedValue.Width := Width - 20;
  fMaximzedValue.Height := Height - 63 - pnl_Button.Height;
end;

procedure Tfrm_Rezept.btn_EinstellungClick(Sender: TObject);
begin
  ShowEinstellung;
end;


procedure Tfrm_Rezept.btn_NeuesRezeptClick(Sender: TObject);
begin
  ShowNeuesRezept;
end;

end.
