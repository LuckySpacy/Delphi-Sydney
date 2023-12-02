unit Form.Option;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvEdit, AdvEdBtn,
  AdvFileNameEdit, Vcl.ExtCtrls, AdvDirectoryEdit, Vcl.ComCtrls,
  Vcl.Samples.Spin, Objekt.Option;

type
  Tfrm_Option = class(TForm)
    Label7: TLabel;
    edt_MySqlDumpDir: TAdvFileNameEdit;
    Panel1: TPanel;
    btn_Ok: TButton;
    btn_Cancel: TButton;
    Label1: TLabel;
    edt_Datenbankname: TEdit;
    Label2: TLabel;
    edt_Benutzername: TEdit;
    Label3: TLabel;
    edt_Passwort: TEdit;
    Label4: TLabel;
    edt_Passwort2: TEdit;
    Label5: TLabel;
    edt_Port: TAdvEdit;
    edt_Backupverzeichnis: TAdvDirectoryEdit;
    Label6: TLabel;
    edt_Backupname: TEdit;
    lbl_Backupname: TLabel;
    btn_TestConnection: TButton;
    edt_Uhrzeit: TDateTimePicker;
    Label8: TLabel;
    Label9: TLabel;
    edt_Anzahl: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
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

uses
  Objekt.MySqlBackup;


procedure Tfrm_Option.FormCreate(Sender: TObject);
begin
  fCancel := true;
  fOption := nil;
  edt_MySqlDumpDir.Text := '';
  edt_Datenbankname.Text := '';
  edt_Benutzername.Text := '';
  edt_Passwort.Text := '';
  edt_Passwort2.Text := '';
  edt_Port.Text := '3306';
  edt_Backupverzeichnis.Text := '';
  edt_Backupname. Text := '';
  edt_Anzahl.Value := 1;
  edt_Uhrzeit.Time := now;
end;

procedure Tfrm_Option.FormDestroy(Sender: TObject);
begin //

end;

procedure Tfrm_Option.setOption(aOption: TOption);
begin
  fOption := aOption;
  if fOption = nil then
    exit;
  edt_MySqlDumpDir.Text := fOption.MySqlDumpDir;
  edt_Datenbankname.Text := fOption.Datenbankname;
  edt_Benutzername.Text  := fOption.Username;
  edt_Passwort.Text := fOption.Passwort;
  edt_Passwort2.Text := fOption.Passwort;
  edt_Port.Text      := fOption.Port;
  edt_Backupverzeichnis.Text := fOption.Backupverzeichnis;
  edt_Backupname.Text := fOption.Backupname;
  edt_Uhrzeit.Time := fOption.StartZeit;
  edt_Anzahl.Text  := fOption.Anzahl;
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
 aOption.MySqlDumpDir  := edt_MySqlDumpDir.Text;
  aOption.Datenbankname := edt_Datenbankname.Text;
  aOption.Username      := edt_Benutzername.Text;
  aOption.Passwort      := edt_Passwort.Text;
  aOption.Port          := edt_Port.Text;
  aOption.Backupverzeichnis := edt_Backupverzeichnis.Text;
  aOption.Backupname := edt_Backupname.Text;
  aOption.StartZeit := edt_Uhrzeit.Time;
  aOption.Anzahl := edt_Anzahl.Text;
end;


end.
