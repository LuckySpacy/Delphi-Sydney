unit Form.Photo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.ChildBase, Vcl.ExtCtrls, Form.PhotoBaum, Form.Bilder,
  Vcl.StdCtrls, Vcl.Samples.Spin;

type
  Tfrm_Photo = class(Tfrm_ChildBase)
    pnl_PhotoBaum: TPanel;
    pnl_Client: TPanel;
    Splitter1: TSplitter;
    pnl_Top: TPanel;
    pnl_Bildgroesse: TPanel;
    Label1: TLabel;
    edt_Hoehe: TSpinEdit;
    Label2: TLabel;
    edt_Breite: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fFormBaum: Tfrm_PhotoBaum;
    fFormBilder: Tfrm_Bilder;
    procedure ZweigClick(aValue: string);
  public
  end;

var
  frm_Photo: Tfrm_Photo;

implementation

{$R *.dfm}

uses
  fmx.Types;

procedure Tfrm_Photo.FormCreate(Sender: TObject);
begin
  inherited;
  fFormBaum := Tfrm_PhotoBaum.Create(Self);
  fFormBaum.Parent := pnl_PhotoBaum;
  fFormBaum.Align := alClient;
  fFormBaum.OnZweigClick := ZweigClick;
  fFormBaum.Show;

  fFormBilder := Tfrm_Bilder.Create(Self);
  fFormBilder.Parent := pnl_Client;
  fFormBilder.Align := alClient;
  fFormBilder.Show;
end;

procedure Tfrm_Photo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fFormBaum);
  FreeAndNil(fFormBilder);
  inherited;

end;

procedure Tfrm_Photo.ZweigClick(aValue: string);
begin       //
  log.d('ZweigClick');
  fFormBilder.LoadBilder(aValue);
end;

end.
