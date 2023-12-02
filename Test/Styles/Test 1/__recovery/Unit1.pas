unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.StdCtrls, FMX.Styles.Objects;

type
  TForm1 = class(TForm)
    Grid1: TGrid;
    Column1: TColumn;
    Column2: TColumn;
    StyleBook1: TStyleBook;
    Button1: TButton;
    CornerButton1: TCornerButton;
    RadioButton1: TRadioButton;
    CheckBox1: TCheckBox;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

end.
