unit Form.Notiz;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, NFSRichViewtoolbar,
  Objekt.NFSRvFont, RVScroll, RichView, RVEdit, NFSRichViewEdit;

type
  Tfrm_Notiz = class(TForm)
    tb_Toolbar: TNFSRichViewtoolbar;
    rv: TNFSRichViewEdit;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_Notiz: Tfrm_Notiz;

implementation

{$R *.dfm}

end.
