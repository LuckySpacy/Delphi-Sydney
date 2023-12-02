unit Form.Einstellung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Objekt.Ini,
  Form.AkSt, Form.KurseLoeschen;

type
  Tfrm_Einstellung = class(TForm)
    pnl_Button: TPanel;
    btn_Pfad: TButton;
    btn_Schnittstelle: TButton;
    btn_AkSt: TButton;
    btn_KurseLoeschen: TButton;
    btn_Aktie: TButton;
    btn_Dateiformat: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_PfadClick(Sender: TObject);
    procedure btn_SchnittstelleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_AkStClick(Sender: TObject);
    procedure btn_KurseLoeschenClick(Sender: TObject);
    procedure btn_AktieClick(Sender: TObject);
    procedure pnl_ButtonDblClick(Sender: TObject);
    procedure btn_DateiformatClick(Sender: TObject);
  private
    procedure ShowPfad;
    procedure ShowSchnittstelle;
    procedure ShowAktieSchnittstelle;
    procedure ShowKurseLoeschen;
    procedure ShowAktien;
    procedure ShowDateiformat;
  public
  end;

var
  frm_Einstellung: Tfrm_Einstellung;

implementation

{$R *.dfm}

uses
  Form.Pfad, Form.Schnittstelle, Datamodul.TSI, Form.Aktien, system.DateUtils,
  Form.Dateiformat;



// Datenbank:
// C:\Users\TomBa\OneDrive\AppData\TSI\DB\TSI30.FDB




procedure Tfrm_Einstellung.FormCreate(Sender: TObject);
begin
  Ini := TIni.Create(nil);
end;

procedure Tfrm_Einstellung.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Ini);
end;

procedure Tfrm_Einstellung.FormShow(Sender: TObject);
begin
  dm.Connect;
end;

procedure Tfrm_Einstellung.pnl_ButtonDblClick(Sender: TObject);
var
  d: TDateTime;
  i: int64;
begin
  i := SecondsBetween(StrToDate('01.01.1970'), StrToDate('01.01.2022'));
  caption := IntToStr(i);
{
  d := StrToDate('01.01.2022');
  d :=IncSecond(d, -1640995200);

//  i := trunc(d);
  caption := DateToStr(d);

  }
end;

procedure Tfrm_Einstellung.btn_AkStClick(Sender: TObject);
begin
  ShowAktieSchnittstelle;
end;

procedure Tfrm_Einstellung.btn_AktieClick(Sender: TObject);
begin
  ShowAktien;
end;

procedure Tfrm_Einstellung.btn_DateiformatClick(Sender: TObject);
begin
  ShowDateiformat;
end;

procedure Tfrm_Einstellung.btn_KurseLoeschenClick(Sender: TObject);
begin
  ShowKurseLoeschen;
end;

procedure Tfrm_Einstellung.btn_PfadClick(Sender: TObject);
begin
  ShowPfad;
end;


procedure Tfrm_Einstellung.btn_SchnittstelleClick(Sender: TObject);
begin
  ShowSchnittstelle;
end;


procedure Tfrm_Einstellung.ShowAktien;
var
  Form: Tfrm_Aktien;
begin
  Form := Tfrm_Aktien.Create(nil);
  try
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

procedure Tfrm_Einstellung.ShowAktieSchnittstelle;
var
  Form: Tfrm_AkSt;
begin
  Form := Tfrm_AkSt.Create(nil);
  try
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

procedure Tfrm_Einstellung.ShowKurseLoeschen;
var
  Form: Tfrm_KurseLoeschen;
begin
  Form := Tfrm_KurseLoeschen.Create(nil);
  try
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;

end;

procedure Tfrm_Einstellung.ShowPfad;
var
  Form: Tfrm_Pfad;
begin
  Form := Tfrm_Pfad.Create(nil);
  try
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

procedure Tfrm_Einstellung.ShowSchnittstelle;
var
  Form: Tfrm_Schnittstelle;
begin
  Form := Tfrm_Schnittstelle.Create(nil);
  try
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;

end;

procedure Tfrm_Einstellung.ShowDateiformat;
var
  Form: Tfrm_Dateiformat;
begin
  Form := Tfrm_Dateiformat.Create(nil);
  try
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;

end;


end.
