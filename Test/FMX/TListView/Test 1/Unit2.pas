unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl,
  FMX.Layouts, System.Generics.Collections;

type
  TForm2 = class(TForm)
    lay_Client: TLayout;
    tac: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    lay_Tab1: TLayout;
    ToolBar1: TToolBar;
    Label1: TLabel;
    lv: TListView;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    type
      TDay = (montag, dienstag, mittwoch, donnerstag, freitag, samstag, sonntag);
      TDayArrStr = Array [TDay] of String;
    const
      DayNameCon: TDayArrStr = ('Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag');
      DayNameShort: TDayArrStr = ('Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So');
    type
      TDaySet = set of TDay;
      TProjectRec = Record
      private
        function getDaysStr: string;

      public
        Name: string;
        Days: TDaySet;
        procedure Init(aProjektname: string; aDaySet: TDaySet);
        property DaysStr: string read getDaysStr;
      End;
  public
    ProjektList: TList<TProjectRec>;
    procedure InitProjektListView;
    procedure UpdateProjektListView(aIndex: Integer = -1);
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

{ TForm2.TProjectRec }

function TForm2.TProjectRec.getDaysStr: string;
var
  s: string;
  i: TDay;
begin
  s :='';
  for i in Days do
    s := s + DayNameShort[i] + Space; // Auflisten der Tage
  Result := Trim(s);

end;

procedure TForm2.TProjectRec.Init(aProjektname: string; aDaySet: TDaySet);
begin  // Übernahme der Vorgabe
  Name := aProjektname;
  Days := aDaySet;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  ProjektList := TList<TProjectRec>.Create;
  InitProjektListView;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin //
  ProjektList.Free;
end;

procedure TForm2.InitProjektListView;
var
  i: TProjectRec;
begin
  i.Init('Berlin, Biesdorf', [donnerstag, mittwoch, freitag]);
  ProjektList.Add(i);
  i.Init('Dresden, Altstadt', [montag, mittwoch, samstag]);
  ProjektList.Add(i);
  i.Init('Hamburg, Wentorf', [samstag, sonntag]);
  ProjektList.Add(i);
  UpdateProjektListView;
end;

procedure TForm2.lvItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  k: TProjectRec;
begin
  k := ProjektList.Items[aItem.Index];
  tac.SetActiveTabWithTransition(TabItem2, TTabTransition.Slide);
end;

procedure TForm2.UpdateProjektListView(aIndex: Integer = -1);
var
  i: TProjectRec;
  k: TListViewItem;
  imgBanned: TListItemImage;
  Bmp: TBitmap;
  MyRect : TRectF;
begin
  lv.BeginUpdate;
  lv.items.Clear;
  try
    for i in ProjektList do
    begin
      k := lv.items.Add;
      k.Data['Projekt'] := i.Name;
      k.Data['Wochentage'] := i.DaysStr;
      //exit;
      imgBanned := k.Objects.FindObjectT<TListItemImage>('Image4');
      imgBanned.Bitmap := TBitmap.Create;
      Bmp := imgBanned.Bitmap;
      bmp.Height := Round(imgBanned.Height);
      bmp.Width  := Round(imgBanned.Width);
      bmp.SetSize(Round(imgBanned.Width), Round(imgBanned.Height));
      bmp.Clear(0);
      //bmp.Clear(TAlphaColors.White);
    // sets the circumscribed rectangle of the ellipse
      MyRect := TRectF.Create(5, 10, bmp.Width-5, bmp.Height-2);
    // draws the ellipse on the canvas
      bmp.Canvas.BeginScene;
      bmp.Canvas.Stroke.Thickness := 1;
      bmp.Canvas.Stroke.Color := TAlphaColors.Red;
      bmp.Canvas.DrawEllipse(MyRect, 100);
      bmp.Canvas.fill.Color := TAlphaColors.Red;
      bmp.Canvas.Font.Size := 10;
      bmp.Canvas.FillText(MyRect, FormatDateTime('dd.mm.yyyy', now), true, 100, [TFillTextFlag.ftRightToLeft], TTextAlign.Center, TTextAlign.Center);
      bmp.Canvas.EndScene;
    end;

  finally
    lv.EndUpdate;
  end;
end;


{
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
 }
end.
