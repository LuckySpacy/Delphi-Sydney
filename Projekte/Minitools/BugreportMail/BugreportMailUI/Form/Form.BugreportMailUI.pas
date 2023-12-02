unit Form.BugreportMailUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Objekt.BugreportMail, Vcl.StdCtrls, Vcl.ExtCtrls,
  Form.AbsMail, Form.Dateien;

type
  Tfrm_BugreportMailUI = class(TForm)
    pg: TPageControl;
    tbs_MailAbsender: TTabSheet;
    tbs_Datei: TTabSheet;
    Panel1: TPanel;
    btn_Ok: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  private
    fFormAbsMail: Tfrm_AbsMail;
    fFormDateien: Tfrm_Dateien;
  public
  end;

var
  frm_BugreportMailUI: Tfrm_BugreportMailUI;

implementation

{$R *.dfm}

uses
  Objekt.Allgemein;


procedure Tfrm_BugreportMailUI.FormCreate(Sender: TObject);
begin
  AllgemeinObj  := TAllgemeinObj.Create;
  BugreportMail := TBugreportMail.Create;
  fFormAbsMail  := Tfrm_AbsMail.Create(Self);
  fFormAbsMail.Parent := tbs_MailAbsender;
  fFormAbsMail.Align := alClient;
  fFormAbsMail.Show;

  fFormDateien := Tfrm_Dateien.Create(Self);
  fFormDateien.Parent := tbs_Datei;
  fFormDateien.Align := alClient;
  fFormDateien.Show;

end;

procedure Tfrm_BugreportMailUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(BugreportMail);
  FreeAndNil(fFormAbsMail);
  FreeAndNil(fFormDateien);
  FreeAndNil(AllgemeinObj);
end;

procedure Tfrm_BugreportMailUI.btn_OkClick(Sender: TObject);
begin
  close;
end;


end.
