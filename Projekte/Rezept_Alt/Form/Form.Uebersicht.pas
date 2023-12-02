unit Form.Uebersicht;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Frame.Kategorie;

type
  Tfrm_Uebersicht = class(TForm)
    pnl_Kategorie: TPanel;
    pnl_Client: TPanel;
    Splitter1: TSplitter;
    Edit1: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fMaximized: Boolean;
    fFrameKategorie: Tfra_Kategorie;
    { Private-Deklarationen }
  public
    property Maximized: Boolean read fMaximized write fMaximized;
  end;

var
  frm_Uebersicht: Tfrm_Uebersicht;

implementation

{$R *.dfm}

procedure Tfrm_Uebersicht.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Release;
  frm_Uebersicht := nil;
end;

procedure Tfrm_Uebersicht.FormCreate(Sender: TObject);
begin
  fFrameKategorie := Tfra_Kategorie.Create(nil);
  fFrameKategorie.Parent := pnl_Kategorie;
  fFrameKategorie.Align  := alClient;
  fFrameKategorie.Show;
end;

procedure Tfrm_Uebersicht.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fFrameKategorie);
end;

procedure Tfrm_Uebersicht.FormResize(Sender: TObject);
begin
  caption := 'w='+IntToStr(Width) + ' / h=' + IntToStr(Height);
end;

end.
