unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TMSToolBar,
  FMX.TMSRichEditorToolBar, FMX.TMSBaseControl, FMX.TMSScrollControl,
  FMX.TMSRichEditorBase, FMX.TMSRichEditor, FMX.TMSPageControl,
  FMX.TMSCustomControl, FMX.TMSTabSet;

type
  TForm1 = class(TForm)
    TMSFMXToolBarButton1: TTMSFMXToolBarButton;
    TMSFMXRichEditor1: TTMSFMXRichEditor;
    TMSFMXRichEditorEditToolBar1: TTMSFMXRichEditorEditToolBar;
    TMSFMXRichEditorFormatToolBar1: TTMSFMXRichEditorFormatToolBar;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
