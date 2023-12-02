unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, Jpeg;

type
  PMyPicture = ^TMyPicture;
  TMyPicture = Record
    Path: AnsiString;
    //Pict: TBitmap;
end;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    Lv: TListView;
    procedure FormCreate(Sender: TObject);
    procedure LvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    pMyPic: PMyPicture;
    Pic : TJpegImage;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.LvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; var DefaultDraw: Boolean);
var
  IconRect: TRect;
begin
  Pic.LoadFromFile(PMyPicture(item.Data).Path);
  IconRect:= Item.DisplayRect(drIcon);
  Sender.Canvas.Draw(IconRect.Left+ 8, IconRect.Top+ 2, Pic);

  //if cdsFocused in State then
    //Sender.Canvas.DrawFocusRect(IconRect);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  LstItm: TListItem;
  PicPath: AnsiString;
  loop: integer;
begin
  Lv.LargeImages := ImageList1;
  PicPath:= ExtractFilePath(application.ExeName)+ 'Bilder\';
  Pic := TJpegImage.Create;

  for loop := 0 to 9 do
    if FileExists(PicPath+ inttostr(loop)+ '.jpg') then
    begin
      LstItm := Lv.Items.Add;
      LstItm.Caption:= inttostr(loop)+ '.jpg';
      New(pMyPic);
      pMyPic^.Path:= PicPath+ inttostr(loop)+ '.jpg';
      LstItm.Data := pMyPic;
    end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  loop : integer;
begin
  for loop := 0 to pred(lv.Items.Count) do
  begin
    pMyPic:= lv.Items.Item[loop].Data;
    DisPose(pMyPic);
  end;

  if Assigned(pic) then
    pic.Free;
end;

end.
