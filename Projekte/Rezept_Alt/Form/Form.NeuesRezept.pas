unit Form.NeuesRezept;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls;

type
  Tfrm_NeuesRezept = class(TForm)
    PageControl1: TPageControl;
    tbs_Titel: TTabSheet;
    tbs_Zutatenliste: TTabSheet;
    tbs_Zutaten: TTabSheet;
    tbs_Kategoire: TTabSheet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_NeuesRezept: Tfrm_NeuesRezept;

implementation

{$R *.dfm}

procedure Tfrm_NeuesRezept.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Release;
  frm_NeuesRezept := nil;
end;

end.
