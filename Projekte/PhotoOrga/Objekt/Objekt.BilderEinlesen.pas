unit Objekt.BilderEinlesen;

interface

uses
  SysUtils, Classes, Windows, Objekt.DateiDatum, Objekt.Dateisystem, Objekt.DateiList,
  db.Photo, Objekt.Datei, DB.PhotoUndBaum, vcl.Imaging.jpeg, vcl.Graphics;

type
  TBilderEinlesen = class
  private
    fDateisystem : TDateisystem;
    fDateiList: TDateiList;
    fDBPhoto: TDBPhoto;
    fDBPhotoUndBaum: TDBPhotoUndBaum;
    procedure ThumbNail(aFullFilename: string; aPixel: Integer; aJpg: TJpegImage);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Read(aPfad: string);
  end;

implementation

{ TBilderEinlesen }

uses
  Datamodul.Database, Objekt.Types, Objekt.PhotoOrga;

constructor TBilderEinlesen.Create;
begin
  fDateisystem := TDateisystem.Create;
  fDateiList   := TDateiList.Create;
  fDBPhoto     := TDBPhoto.Create(nil);
  fDBPhoto.Trans := dm.Trans_Standard;

  fDBPhotoUndBaum := TDBPhotoUndBaum.Create(nil);
  fDBPhotoUndBaum.Trans := dm.Trans_Standard;

end;

destructor TBilderEinlesen.Destroy;
begin
  FreeAndNil(fDateisystem);
  FreeAndNil(fDateiList);
  FreeAndNil(fDBPhoto);
  FreeAndNil(fDBPhotoUndBaum);
  inherited;
end;

procedure TBilderEinlesen.Read(aPfad: string);
var
  i1: integer;
  Pfad: string;
  Datei: TDatei;
  PosNr: Integer;
  FullFilename: string;
  ms: TMemoryStream;
  Jpg: TJpegImage;
begin
  fDateisystem.ReadFiles(aPfad, fDateiList);
  PosNr := 0;
  for i1 := 0 to fDateiList.Count -1 do
  begin
    Datei := fDateiList.Item[i1];
    if Datei.ext <> 'jpg' then
      continue;
    Pfad := Datei.Pfad;
    Pfad := Copy(Pfad, Length(aPfad)+1, Length(Pfad));
    fDBPhoto.ReadFromDateiname(Pfad, Datei.Dateiname);
    if not fDBPhoto.Gefunden then
    begin
      Pfad := PhotoOrga.Ini.Einstellung.Bilderpfad + Pfad;
      FullFilename := IncludeTrailingPathDelimiter(Pfad) + Datei.Dateiname;
      inc(PosNr);
      fDBPhoto.Init;
      fDBPhoto.Dateiname := Datei.Dateiname;
      fDBPhoto.Pfad      := Pfad;
      fDBPhoto.Datum     := now;
      //fDBPhoto.LoadBildFromFile(FullFilename);
      fDBPhoto.SaveToDB;
      fDBPhotoUndBaum.Init;
      fDBPhotoUndBaum.PHId  := fDBPhoto.Id;
      fDBPhotoUndBaum.PHUId := fDBPhoto.UId;
      fDBPhotoUndBaum.PBId  := 0;
      fDBPhotoUndBaum.PBUId := cBaumZweig_Neu;
      fDBPhotoUndBaum.PosNr := PosNr;

      ms  := TMemoryStream.Create;
      Jpg := TJpegImage.Create;
      try
        ThumbNail(FullFilename, 185, jpg);
        jpg.SaveToStream(ms);
        ms.Position := 0;
        fDBPhoto.setBild(ms);
      finally
        FreeAndNil(ms);
        FreeAndNil(jpg);
      end;


      fDBPhotoUndBaum.SaveToDB;
    end;
  end;
end;


procedure TBilderEinlesen.ThumbNail(aFullFilename: string; aPixel: Integer; aJpg: TJpegImage);
var
  bmp:TBitmap;
  n_x, n_y: integer;
   NoCopy: Boolean;
begin
  aJpg.LoadFromFile(aFullFilename);
  bmp := TBitmap.Create;
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
   // aJpg.SaveToFile('d:\Bachmann\Daten\OneDrive\Asus-PC-2018\Bilder\' + ExtractFileName(aFullFilename));
  finally
    bmp.free;
  end;
end;

end.
