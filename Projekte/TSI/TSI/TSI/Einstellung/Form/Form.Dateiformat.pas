unit Form.Dateiformat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBObj.Dateiformat, DBObj.SchnittstelleList, DBObj.Schnittstelle,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  Tfrm_Dateiformat = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    lsb_Schnittstelle: TListBox;
    pnl_Dateiformat: TPanel;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edt_PosDatum: TSpinEdit;
    edt_PosEroeffnung: TSpinEdit;
    edt_PosTief: TSpinEdit;
    edt_PosHoch: TSpinEdit;
    edt_PosVolumen: TSpinEdit;
    edt_PosSchluss: TSpinEdit;
    Label7: TLabel;
    edt_Datumformat: TEdit;
    Panel5: TPanel;
    btn_Speichern: TButton;
    Label8: TLabel;
    edt_Trennzeichen: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SpeichernClick(Sender: TObject);
    procedure lsb_SchnittstelleClick(Sender: TObject);
  private
    fSchnittstelleList: TSchnittstelleList;
    fSchnittstelle: TSchnittstelle;
    fDBDateiformat: TDBDateiformat;
    procedure AktualSchnittstelle;
    procedure AktualLink;
    procedure Speichern;
  public
  end;

var
  frm_Dateiformat: Tfrm_Dateiformat;

implementation

{$R *.dfm}

uses
  Datamodul.TSI, Form.SchnittstelleBearb;


procedure Tfrm_Dateiformat.FormCreate(Sender: TObject);
begin
  fSchnittstelleList := TSchnittstelleList.Create(nil);
  fSchnittstelleList.Trans := dm.IBT;
  fSchnittstelle := TSchnittstelle.Create(nil);
  fSchnittstelle.Trans := dm.IBT;

  fDBDateiformat := TDBDateiformat.Create(nil);
  fDBDateiformat.Trans := dm.IBT;

end;

procedure Tfrm_Dateiformat.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fSchnittstelleList);
  FreeAndNil(fSchnittstelle);
  FreeAndNil(fDBDateiformat);
end;

procedure Tfrm_Dateiformat.FormShow(Sender: TObject);
begin  //
  AktualSchnittstelle;
end;

procedure Tfrm_Dateiformat.lsb_SchnittstelleClick(Sender: TObject);
begin
  AktualLink;
end;

procedure Tfrm_Dateiformat.Speichern;
begin
  if fDBDateiformat.SSID <= 0 then
    exit;
  fDBDateiformat.PosDatum      := edt_PosDatum.Value;
  fDBDateiformat.PosEroeffnung := edt_PosEroeffnung.Value;
  fDBDateiformat.PosHoch       := edt_PosHoch.Value;
  fDBDateiformat.PosTief       := edt_PosTief.Value;
  fDBDateiformat.PosSchluss    := edt_PosSchluss.Value;
  fDBDateiformat.PosVolumen    := edt_PosVolumen.Value;
  fDBDateiformat.DatumFormat   := Trim(edt_Datumformat.Text);
  fDBDateiformat.Trennzeichen  := Trim(edt_Trennzeichen.Text);
  fDBDateiformat.SaveToDB;
end;

procedure Tfrm_Dateiformat.AktualSchnittstelle;
begin
  fSchnittstelleList.LadeCombobox(lsb_Schnittstelle.Items);
  if lsb_Schnittstelle.Count > 0 then
    lsb_Schnittstelle.ItemIndex := 0;
  AktualLink;
end;

procedure Tfrm_Dateiformat.btn_SpeichernClick(Sender: TObject);
begin
  Speichern;
end;

procedure Tfrm_Dateiformat.AktualLink;
var
  Id: Integer;
begin
  //mem_Link.Clear;
  edt_Datumformat.Text := '';
  edt_Trennzeichen.Text := '';
  if lsb_Schnittstelle.ItemIndex < 0 then
    exit;
  Id := Integer(lsb_Schnittstelle.Items.Objects[lsb_Schnittstelle.ItemIndex]);
  fSchnittstelle.Read(Id);
  fDBDateiformat.ReadSSId(fSchnittstelle.id);
  fDBDateiformat.SSID := fSchnittstelle.id;
  edt_PosDatum.Value      := fDBDateiformat.PosDatum;
  edt_PosEroeffnung.Value := fDBDateiformat.PosEroeffnung;
  edt_PosTief.Value       := fDBDateiformat.PosTief;
  edt_PosHoch.Value       := fDBDateiformat.PosHoch;
  edt_PosVolumen.Value    := fDBDateiformat.PosVolumen;
  edt_PosSchluss.Value    := fDBDateiformat.PosSchluss;
  edt_Datumformat.Text    := fDBDateiformat.DatumFormat;
  edt_Trennzeichen.Text   := fDBDateiformat.Trennzeichen;
  //mem_Link.Text := fSchnittstelle.Link;
end;


end.
