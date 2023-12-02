unit PrJpegConv;

interface

uses Windows, Graphics, SysUtils, Classes;

  procedure MakeBigBilder(InFile, OutFile: String; Wbig, Wnorm: Integer);
  procedure MakeNormalBilder(InFile, OutFile: String; W1: Integer);
  procedure MakeThumbBilder(InFile, OutFile: String; W1: Integer);

implementation

uses Jpeg;

procedure MakeBigBilder(InFile, OutFile: String; Wbig, Wnorm: Integer);
var bmp:TBitmap;
    jpeg:TJpegImage;
    n_x, n_y: integer;
    NoBigger, noCopy: Boolean;
begin
  Jpeg:=TJpegImage.Create;
  try
    jpeg.LoadFromFile(InFile);
    bmp:=TBitmap.Create;
    try
      bmp.width:=jpeg.Width;
      bmp.height:=jpeg.Height;
      //Nur generieren, wenn Original größer als Big-Größe
      NoBigger:= ((jpeg.Height <= Wbig)and(jpeg.Width <= Wbig));
      NoCopy:= ((jpeg.Height <= Wnorm)and(jpeg.Width <= Wnorm));
      if not NoBigger then begin
        if jpeg.width > jpeg.Height then begin
          n_x := Wbig;
          n_y := round(bmp.height * (n_x / bmp.width));
        end else begin
          n_y := Wbig;
          n_x := round(bmp.width * (n_y / bmp.height));
        end;
        bmp.Width := n_x;
        bmp.Height := n_y;
        bmp.canvas.StretchDraw(Rect(0,0,n_x,n_y),jpeg);
        jpeg.assign(bmp);
      end;
    finally
      bmp.free;
    end;
    //nur speichern, wenn das Oribild größer ist als das Normalbild
    if not NoCopy then jpeg.SaveToFile(OutFile);
  finally
    jpeg.Free;
  end;
end;

procedure MakeNormalBilder(InFile, OutFile: String; W1: Integer);
var bmp:TBitmap;
    jpeg:TJpegImage;
    n_x, n_y: integer;
    NoCopy: Boolean;
begin
  Jpeg:=TJpegImage.Create;
  try
    jpeg.LoadFromFile(InFile);
    bmp:=TBitmap.Create;
    try
      bmp.width:=jpeg.Width;
      bmp.height:=jpeg.Height;
      //Nur generieren, wenn größer als Vorgabe, sonst so lassen
      NoCopy:= ((jpeg.Height<W1)and(jpeg.Width<W1));
      if not NoCopy then begin
        if jpeg.width > jpeg.Height then begin
          n_x := W1;
          n_y := round(bmp.height * (n_x / bmp.width));
        end else begin
          n_y := W1;
          n_x := round(bmp.width * (n_y / bmp.height));
        end;
        bmp.Width := n_x;
        bmp.Height := n_y;
        bmp.canvas.StretchDraw(Rect(0,0,n_x,n_y),jpeg);
        jpeg.assign(bmp);
      end;
    finally
      bmp.free;
    end;
    jpeg.SaveToFile(OutFile); //immer speichern, auch wenn kleiner
  finally
    jpeg.Free;
  end;
end;

procedure MakeThumbBilder(InFile, OutFile: String; W1: Integer);
var bmp:TBitmap;
    jpeg:TJpegImage;
    n_x, n_y: integer;
    NoCopy: Boolean;
begin
  Jpeg:=TJpegImage.Create;
  try
    jpeg.LoadFromFile(InFile);
    bmp:=TBitmap.Create;
    try
      bmp.width:=jpeg.Width;
      bmp.height:=jpeg.Height;
      //Nur generieren, wenn größer als Vorgabe, sonst so lassen
      NoCopy:= ((jpeg.Height < W1)and(jpeg.Width < W1));
      if not NoCopy then begin
        if jpeg.width > jpeg.Height then begin
          n_x := W1;
          n_y := round(bmp.height * (n_x / bmp.width));
        end else begin
          n_y := W1;
          n_x := round(bmp.width * (n_y / bmp.height));
        end;
        bmp.Width := n_x;
        bmp.Height := n_y;
        bmp.canvas.StretchDraw(Rect(0,0,n_x,n_y),jpeg);
        jpeg.assign(bmp);
      end;
    finally
      bmp.free;
    end;
    jpeg.SaveToFile(OutFile); //immer speichern, auch wenn kleiner
  finally
    jpeg.Free;
  end;
end;

end.
