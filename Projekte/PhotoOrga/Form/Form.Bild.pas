unit Form.Bild;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.ChildBase, Vcl.ExtCtrls, vcl.Imaging.jpeg;

type
  Tfrm_Bild = class(Tfrm_ChildBase)
    img: TImage;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imgClick(Sender: TObject);
    procedure imgDblClick(Sender: TObject);
  private
    fjpg: TJpegImage;
    fFullFilename: string;
    fFullDateiname: String;
    fObjects: TObject;
    fOnImageDblClick: TNotifyEvent;
    procedure ThumbNail(aFullFilename: string; aPixel: Integer; aJpg: TJpegImage);
    procedure Rotate90(Bitmap: TBitmap);
  public
    procedure LoadJpg(aFullDateiname: string);
    procedure LoadFromStream(aStream: TMemoryStream);
    property FullDateiname: String read fFullDateiname write fFullDateiname;
    property Objects: TObject read fObjects write fObjects;
    property OnImageDblClick: TNotifyEvent read fOnImageDblClick write fOnImageDblClick;
  end;

var
  frm_Bild: Tfrm_Bild;

implementation

{$R *.dfm}

procedure Tfrm_Bild.FormCreate(Sender: TObject);
begin //
  inherited;
  fjpg := TJpegImage.Create;
  fFullDateiname := '';
  fObjects := nil;
end;

procedure Tfrm_Bild.FormDestroy(Sender: TObject);
begin //
  FreeAndNil(fjpg);
  inherited;
end;

procedure Tfrm_Bild.imgClick(Sender: TObject);
begin
  inherited;
  Rotate90(img.Picture.Bitmap);
//  ShowMessage('Click');
end;

procedure Tfrm_Bild.imgDblClick(Sender: TObject);
begin
  if Assigned(fOnImageDblClick) then
    fOnImageDblClick(fObjects);
end;

procedure Tfrm_Bild.LoadFromStream(aStream: TMemoryStream);
begin
  try
    aStream.Position := 0;
    fjpg.LoadFromStream(aStream);
    img.Picture.Bitmap.Assign(fjpg);
    aStream.Position := 0;
  except
    on E: Exception do
    begin
      raise e.Create('Fehler beim Laden des Bildes :' + E.Message);
    end;
  end;
end;

procedure Tfrm_Bild.LoadJpg(aFullDateiname: string);
begin
  //fjpg.LoadFromFile(aFullDateiname);
  ThumbNail(aFulldateiname, 185, fJpg);
  img.Picture.Bitmap.Assign(fjpg);
end;

procedure Tfrm_Bild.ThumbNail(aFullFilename: string; aPixel: Integer; aJpg: TJpegImage);
var
  bmp:TBitmap;
  n_x, n_y: integer;
   NoCopy: Boolean;
begin
  aJpg.LoadFromFile(aFullFilename);
  bmp:=TBitmap.Create;
  try
    bmp.width  := aJpg.Width;
    bmp.height := aJpg.Height;
    //Nur generieren, wenn größer als Vorgabe, sonst so lassen
    NoCopy:= ((aJpg.Height < aPixel)and(aJpg.Width < aPixel));
    if not NoCopy then
    begin
      if aJpg.width > aJpg.Height then
      begin
        n_x := aPixel;
        n_y := round(bmp.height * (n_x / bmp.width));
      end
      else
      begin
        n_y := aPixel;
        n_x := round(bmp.width * (n_y / bmp.height));
      end;
      bmp.Width := n_x;
      bmp.Height := n_y;
      bmp.canvas.StretchDraw(Rect(0,0,n_x,n_y),aJpg);
      aJpg.assign(bmp);
    end;
    aJpg.SaveToFile('d:\Bachmann\Daten\OneDrive\Asus-PC-2018\Bilder\' + ExtractFileName(aFullFilename));
  finally
    bmp.free;
  end;
end;


procedure Tfrm_Bild.Rotate90(Bitmap: TBitmap);
type
  TRGBArray = array[0..0] of TRGBTriple;
  pRGBArray = ^TRGBArray;
var
  oldRows, oldColumns: integer;
  rowIn, rowOut: pRGBArray;
  tmpBitmap: TBitmap;
begin
  tmpBitmap := TBitmap.Create;

  tmpBitmap.Width := Bitmap.Height;
  tmpBitmap.Height := Bitmap.Width;
  tmpBitmap.PixelFormat := Bitmap.PixelFormat;

  for oldColumns := 0 to Bitmap.Width - 1 do
  begin
    rowOut := tmpBitmap.ScanLine[oldColumns];

    for oldRows := 0 to Bitmap.Height - 1 do
    begin
      rowIn := Bitmap.ScanLine[oldRows];
      rowOut[Bitmap.Height - oldRows - 1] := rowIn[oldColumns];
    end;
  end;

  Bitmap.assign(tmpBitmap);
  tmpBitmap.free;
end;
end.
