unit Objekt.AudioFilePicture;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
    TAtomName = Array [0..3] of Byte;

type
  TAudioFilePicture = class
  private
    fPNGPicture: TPNGImage;
    fJPEGPicture: TJPEGImage;
    fPictureType: string;
    fBMPPicture: TJPEGImage;
    fImage: TImage;
    fId: string;
    fSize: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    property JPEGPicture: TJPEGImage read  fJPEGPicture write fJPEGPicture;
    property PNGPicture: TPNGImage read  fPNGPicture write fPNGPicture;
    property BMPPicture: TJPEGImage read  fBMPPicture write fBMPPicture;
    property Image: TImage read fImage write fImage;
    property Id: string read fId write fId;
    property Size: Integer read fSize write fSize;
    property PictureType: string read fPictureType write fPictureType;
  end;

implementation

{ TAudioFilePicture }

constructor TAudioFilePicture.Create;
begin
  fImage := TImage.Create(nil);
  fPNGPicture  := nil;
  fJPEGPicture := nil;
  fBMPPicture  := nil;
  fPictureType := '';
  fSize := 0;
  fId := '';
end;

destructor TAudioFilePicture.Destroy;
begin
  if fPNGPicture <> nil then
    FreeAndNil(fPNGPicture);
  if fJPEGPicture <> nil then
    FreeAndNil(fJPEGPicture);
  if fBMPPicture <> nil then
    FreeAndNil(fBMPPicture);
  if fImage <> nil then
    FreeAndNil(fImage);
  inherited;
end;

end.
