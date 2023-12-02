unit Form.Einstellung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  tbButton, Objekt.Rezept;

type
  Tfrm_Einstellung = class(TForm)
    pg: TPageControl;
    tbs_Datenbank: TTabSheet;
    pnl_Left_Datenbank: TPanel;
    pnl_Client_Datenbank: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edt_Host: TEdit;
    edt_Datenbankpfad: TEdit;
    edt_Datenbankname: TEdit;
    edt_Username: TEdit;
    edt_Passwort: TEdit;
    pnl_Button: TPanel;
    btn_Schliessen: TTBButton;
    btn_Cancel: TTBButton;
    procedure FormShow(Sender: TObject);
    procedure btn_SchliessenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure FuelleForm;
    procedure Save;
  public
  end;

var
  frm_Einstellung: Tfrm_Einstellung;

implementation

{$R *.dfm}

uses
  Datenmodul.dm;


procedure Tfrm_Einstellung.FormShow(Sender: TObject);
begin//
  FuelleForm;
end;

procedure Tfrm_Einstellung.FuelleForm;
begin
  edt_Host.Text := Rezept.IniEinstellung.Host;
  edt_Datenbankpfad.Text := Rezept.IniEinstellung.Datenbankpfad;
  edt_Datenbankname.Text := Rezept.IniEinstellung.Datenbankname;
  edt_Username.Text      := Rezept.IniEinstellung.Username;
  edt_Passwort.Text      := Rezept.IniEinstellung.Passwort;
end;

procedure Tfrm_Einstellung.Save;
begin
  Rezept.IniEinstellung.Host          := edt_Host.Text;
  Rezept.IniEinstellung.Datenbankpfad := edt_Datenbankpfad.Text;
  Rezept.IniEinstellung.Datenbankname := edt_Datenbankname.Text;
  Rezept.IniEinstellung.Username      := edt_Username.Text;
  Rezept.IniEinstellung.Passwort      := edt_Passwort.Text;
end;

procedure Tfrm_Einstellung.btn_SchliessenClick(Sender: TObject);
begin
  Save;
  close;
end;

procedure Tfrm_Einstellung.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Release;
  frm_Einstellung := nil;
end;


end.
