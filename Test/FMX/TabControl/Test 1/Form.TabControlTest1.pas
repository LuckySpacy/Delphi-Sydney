unit Form.TabControlTest1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl;

type
  TForm2 = class(TForm)
    tbc: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    StyleBook1: TStyleBook;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

end.
