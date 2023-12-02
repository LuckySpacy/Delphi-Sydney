unit Objekt.AudioFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Objekt.AudioFileText, ID3v1Library, ID3v2Library,
  Objekt.AudioFilePictureList, Objekt.MP3, Objekt.AudioStruktur, Objekt.MP4;

type
  TAudioFile = class(TAudioStruktur)
  private
    fMP3: TMP3;
    fMP4: TMP4;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init; override;
    procedure ReadMP3File(aFilename: string);
    procedure SaveMP3File(aFilename: string);
    procedure ReadMP4File(aFilename: string);
    procedure SaveMP4File(aFilename: string);
    procedure Read(aFilename: string);
    procedure Save(aFilename: string);
  end;

implementation

{ TAudioFile }

uses
  mp3FileUtils, Objekt.AudioFilePicture, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  System.UITypes;


constructor TAudioFile.Create;
begin
  inherited;
  fMP3 := TMP3.Create;
  fMP4 := TMP4.Create;
  Init;
end;

destructor TAudioFile.Destroy;
begin
  FreeAndNil(fMP3);
  FreeAndNil(fMP4);
  inherited;
end;

procedure TAudioFile.Init;
begin
  inherited;
end;


procedure TAudioFile.Read(aFilename: string);
var
  ext: string;
begin
  Init;
  if not FileExists(aFilename) then
    exit;
  ext := ExtractFileExt(aFilename);
  if SameText('.mp3', ext) then
    ReadMP3File(aFilename);
  if SameText('.m4a', ext) then
    ReadMP4File(aFilename);
end;

procedure TAudioFile.ReadMP3File(aFilename: string);
begin
  fMP3.ReadMP3File(aFilename);
  fMP3.CopyStruktur(Self);
end;

procedure TAudioFile.ReadMP4File(aFilename: string);
begin
  fMP4.ReadMP4File(aFilename);
  fMP4.CopyStruktur(Self);
end;

procedure TAudioFile.Save(aFilename: string);
var
  ext: string;
begin
  ext := ExtractFileExt(aFilename);
  if SameText('.mp3', ext) then
    SaveMP3File(aFilename);
  if SameText('.m4a', ext) then
    SaveMP4File(aFilename);
end;

procedure TAudioFile.SaveMP3File(aFilename: string);
begin
  fMP3.setStruktur(Self);
  fMP3.SaveMP3File(aFilename);
end;

procedure TAudioFile.SaveMP4File(aFilename: string);
begin
  fMP4.setStruktur(Self);
  fMP4.SaveMP4File(aFilename);
end;

end.
