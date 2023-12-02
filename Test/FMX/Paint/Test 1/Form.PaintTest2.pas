unit Form.PaintTest2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, System.Math.Vectors;

type
  TForm3 = class(TForm)
    lay_Top: TLayout;
    lay_Client: TLayout;
    Button1: TButton;
    Image1: TImage;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}



procedure TForm3.FormCreate(Sender: TObject);
begin //
//  Image1.Bitmap.SetSize(Round(Image1.Width), Round(Image1.Height));
//  Image1.Bitmap.Clear(TAlphaColors.White);
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin //

end;


procedure TForm3.Button1Click(Sender: TObject);
var
  MyRect: TRectF;
  MyRect2: TRectF;
begin
  Image1.Bitmap.SetSize(Round(Image1.Width), Round(Image1.Height));
  Image1.Bitmap.Clear(TAlphaColors.White);
  // sets the circumscribed rectangle of the ellipse
  MyRect := TRectF.Create(1, 1, image1.Width-1, image1.Height-1);
  MyRect2 := TRectF.Create(1, 1, image1.Width-1, image1.Height-1);
  // draws the ellipse on the canvas
  Image1.Bitmap.Canvas.BeginScene;
  Image1.Bitmap.Canvas.Stroke.Thickness := 2;
  Image1.Bitmap.Canvas.Stroke.Color := TAlphaColors.Red;
  Image1.Bitmap.Canvas.DrawEllipse(MyRect, 100);
  Image1.Bitmap.Canvas.fill.Color := TAlphaColors.Red;
  Image1.Bitmap.Canvas.Font.Size := 8;
  Image1.Bitmap.Canvas.FillText(MyRect, 'Hallo', true, 100, [TFillTextFlag.ftRightToLeft], TTextAlign.Center, TTextAlign.Center);
  Image1.Bitmap.Canvas.EndScene;
end;


procedure TForm3.Button2Click(Sender: TObject);
var
  p1, p2: TPointF;
begin
  // Sets the center of the arc
  p1 := TPointF.Create(200, 200);
  // sets the radius of the arc
  p2 := TPointF.Create(150, 150);
  Image1.Bitmap.Canvas.BeginScene;
  // draws the arc on the canvas
  Image1.Bitmap.Canvas.DrawArc(p1, p2, 90, 230, 20);
  // updates the bitmap to show the arc
  Image1.Bitmap.Canvas.EndScene;
end;



end.
