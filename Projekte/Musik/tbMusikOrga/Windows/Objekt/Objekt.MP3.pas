unit Objekt.MP3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs, ID3v1Library, ID3v2Library, Objekt.AudioStruktur;


type
  TMP3 = class(TAudioStruktur)
  private
    fID3v1Tag : TID3v1Tag;
    fID3v2Tag : TID3v2Tag;
    procedure CreateTags;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ReadMP3File(aFilename: string);
    procedure SaveMP3File(aFilename: string);
  end;

implementation

{ TMP3 }

uses
  mp3FileUtils, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  System.UITypes, Objekt.AudioFileText, Objekt.AudioFilePictureList, Objekt.AudioFilePicture;

constructor TMP3.Create;
begin
  inherited;
  fID3v1Tag := ID3v1Library.TID3v1Tag.Create;
  fID3v2Tag := ID3v2Library.TID3v2Tag.Create;
end;


destructor TMP3.Destroy;
begin
  if Assigned(fID3v1Tag) then
    FreeAndNil(fID3v1Tag);
  if Assigned(fID3v2Tag) then
    FreeAndNil(fID3v2Tag);
  inherited;
end;


procedure TMP3.CreateTags;
begin
  if Assigned(fID3v1Tag) then
    FreeAndNil(fID3v1Tag);
  if Assigned(fID3v2Tag) then
    FreeAndNil(fID3v2Tag);
  fID3v1Tag := ID3v1Library.TID3v1Tag.Create;
  fID3v2Tag := ID3v2Library.TID3v2Tag.Create;
end;


procedure TMP3.ReadMP3File(aFilename: string);
var
  Error: Integer;
  LanguageIDArray: TLanguageID;
  Description: string;
  i1: Integer;
  PictureStream : TMemoryStream;
  Success: Boolean;
  MIMEType: String;
  PictureType: Integer;
  AudioPicture: TAudioFilePicture;
begin
  Init;

  if not FileExists(aFilename) then
    exit;

  FPfad          := ExtractFileDir(aFilename);
  fFullDateiname := aFilename;
  FDateiname := ExtractFileName(aFilename);

  CreateTags;

  //* Enable search for tag from beginning
  fID3v2Tag.BeginningSearchLength := 128;
  Error := fID3v2Tag.LoadFromFile(aFilename);

  if Error <> ID3V2LIBRARY_SUCCESS then
  begin
    //MessageDlg('Error loading ID3v2 tag, error code: ' + IntToStr(Error) + #13#10 + ID3v2TagErrorCode2String(Error), mtError, [mbOk], 0);
    exit;
  end;

  fVBR     := fID3v2Tag.MPEGInfo.VBR;
  fBitrate := fID3v2Tag.BitRate;

  case fID3v2Tag.MPEGInfo.ChannelMode of
    tmpegcmUnknown: fChannelMode := 'Unknown';
    tmpegcmMono: fChannelMode := 'Mono';
    tmpegcmDualChannel: fChannelMode := 'Dual channel';
    tmpegcmJointStereo: fChannelMode := 'Joint stereo';
    tmpegcmStereo: fChannelMode := 'Stereo';
  end;

  fWasUnsynchronised := fID3v2Tag.WasUnsynchronised;

  //* Always call 'DeCompressAllFrames' after 'RemoveUnsynchronisationOnAllFrames'
  //* Note that in 'All Frames' view all frames will appear as not compressed because of this!
  fID3v2Tag.DeCompressAllFrames;

  fExtendedHeader    := fID3v2Tag.ExtendedHeader;
  fExperimental      := fID3v2Tag.Experimental;
  fCRC32             := fID3v2Tag.ExtendedHeader3.CRCPresent;
  fTitel             := fID3v2Tag.GetUnicodeText('TIT2');
  fArtist            := fID3v2Tag.GetUnicodeText('TPE1');
  fAlbum             := fID3v2Tag.GetUnicodeText('TALB');
  fYear              := fID3v2Tag.GetUnicodeText('TYER');
  fRecordingTime     := fID3v2Tag.GetTime('TDRC');
  fTrackNo           := fID3v2Tag.GetUnicodeText('TRCK');
  fGenre             := ID3v2DecodeGenre(fID3v2Tag.GetUnicodeText('TCON'));
  fWXXXURL           := fID3v2Tag.GetUnicodeUserDefinedURLLink('WXXX', Description);
  fPlayTime          := mSec2Time(Trunc(fID3v2Tag.PlayTime * 1000));


  fKommentar.Text    := fID3v2Tag.GetUnicodeComment('COMM', LanguageIDArray, Description);
  fKommentar.Description := Description;
  fKommentar.LanguageID  := LanguageIDToString(LanguageIDArray);

  fLyrics.Text := fID3v2Tag.GetUnicodeLyrics('USLT', LanguageIDArray, Description);
  fLyrics.LanguageID := LanguageIDToString(LanguageIDArray);
  fLyrics.Description := Description;

  fAudioFilePictureList.Clear;
  PictureStream := nil;

  if fID3v2Tag.FrameExists('APIC') >= 0 then
  begin
    for i1 := 0 to fID3v2Tag.FrameCount - 1 do
    begin
      try
        if Picturestream <> nil then
          FreeAndNil(PictureStream);
        PictureStream := TMemoryStream.Create;
        Success := fID3v2Tag.GetUnicodeCoverPictureStream(i1, PictureStream, MIMEType, Description, PictureType);
        if (PictureStream.Size = 0) or (not Success) then
          continue;
        AudioPicture := fAudioFilePictureList.Add;
        AudioPicture.PictureType := APICType2Str(PictureType);

        PictureStream.Seek(0, soFromBeginning);
        MIMEType := LowerCase(MIMEType);

        if (MIMEType = 'image/jpeg') or (MIMEType = 'image/jpg')
        then
        begin
          AudioPicture.JPEGPicture := TJPEGImage.Create;
          AudioPicture.JPEGPicture.LoadFromStream(PictureStream);
          AudioPicture.JPEGPicture.DIBNeeded;
          AudioPicture.Image.Picture.Assign(AudioPicture.JPEGPicture);
        end;

        if MIMEType = 'image/png' then
        begin
          AudioPicture.PNGPicture := TPNGImage.Create;
          AudioPicture.PNGPicture.LoadFromStream(PictureStream);
          AudioPicture.Image.Picture.Assign(AudioPicture.PNGPicture);
        end;

        if MIMEType = 'image/bmp' then
        begin
          PictureStream.Seek(0, soFromBeginning);
          AudioPicture.BMPPicture.LoadFromStream(PictureStream);
          AudioPicture.Image.Picture.Bitmap.LoadFromStream(PictureStream);
        end;

      finally
        if Picturestream <> nil then
          FreeAndNil(PictureStream);
      end;
    end;
  end;


  Error := fID3v1Tag.LoadFromFile(aFilename);
  if Error <> ID3V2LIBRARY_SUCCESS then
  begin
    //MessageDlg('Error loading ID3v2 tag, error code: ' + IntToStr(Error) + #13#10 + ID3v2TagErrorCode2String(Error), mtError, [mbOk], 0);
    exit;
  end;

  if fTitel = '' then
    fTitel := fID3v1Tag.Title;
  if fArtist = '' then
    fArtist := fID3v1Tag.Artist;
  if fAlbum = '' then
    fAlbum := fID3v1Tag.Album;
  if fYear = '' then
    fYear := fID3v1Tag.Year;
  if fKommentar.Text = '' then
    fKommentar.Text := fID3v1Tag.Comment;
  if fTrackNo = '' then
    fTrackNo := IntToStr(fID3v1Tag.Track);
  if fGenre = '' then
    fGenre := fID3v1Tag.Genre;

end;


procedure TMP3.SaveMP3File(aFilename: string);
var
  Track: Integer;
  LanguageID: TLanguageID;
  ErrorCode: Integer;
  Error: Integer;
begin

  CreateTags;
  //* Enable search for tag from beginning
  fID3v2Tag.BeginningSearchLength := 128;
  Error := fID3v2Tag.LoadFromFile(aFilename);

  if Error <> ID3V2LIBRARY_SUCCESS then
  begin
    //MessageDlg('Error loading ID3v2 tag, error code: ' + IntToStr(Error) + #13#10 + ID3v2TagErrorCode2String(Error), mtError, [mbOk], 0);
    exit;
  end;

  Error := fID3v1Tag.LoadFromFile(aFilename);
  if Error <> ID3V2LIBRARY_SUCCESS then
  begin
    //MessageDlg('Error loading ID3v2 tag, error code: ' + IntToStr(Error) + #13#10 + ID3v2TagErrorCode2String(Error), mtError, [mbOk], 0);
    exit;
  end;



  if not TryStrToInt(fTrackNo, Track) then
    Track := 0;
  fID3v1Tag.Title   := fTitel;
  fID3v1Tag.Artist  := fArtist;
  fID3v1Tag.Album   := fAlbum;
  fID3v1Tag.Year    := fYear;
  fID3v1Tag.Comment := fKommentar.Text;
  fID3v1Tag.Track   := Track;
  fID3v1Tag.Genre   := fGenre;
  //fID3v1Tag.SaveToFile(fFullDateiname);

  //* Set Title
  fID3v2Tag.SetUnicodeText('TIT2', fTitel);
  //* Set Artist
  fID3v2Tag.SetUnicodeText('TPE1', fArtist);
  //* Set Album
  fID3v2Tag.SetUnicodeText('TALB', fAlbum);
  //* Set Year
  fID3v2Tag.SetUnicodeText('TYER', fYear);
  //* Set Genre
  fID3v2Tag.SetUnicodeText('TCON', fGenre);
  //* Set track no.
  fID3v2Tag.SetUnicodeText('TRCK', fTrackNo);
  //* Set WXXX URL (most common)
  fID3v2Tag.SetUnicodeUserDefinedURLLink('WXXX', fWXXXURL, 'Description');
  //* Set Comment
  //* Language ID is 3 bytes long ANSI string
  StringToLanguageID(fKommentar.LanguageId, LanguageID);
  fID3v2Tag.SetUnicodeComment('COMM', fKommentar.Text, LanguageID, fWXXXURL);

  //* Set lyrics
  //* Language ID is 3 bytes long ANSI string we convert it here
  StringToLanguageID(fLyrics.LanguageId, LanguageID);
  fID3v2Tag.SetUnicodeLyrics('USLT', fLyrics.Text, LanguageID, fWXXXURL);

    {
    if CheckBox1.Checked then begin
        ID3v2Tag.ApplyUnsynchronisationOnAllFrames;
    end;
    }
    //* Save the ID3v2 Tag
  ErrorCode := fID3v2Tag.SaveToFile(fFullDateiname{$IFDEF DEBUG}, False{$ENDIF});

  if ErrorCode <> ID3V2LIBRARY_SUCCESS then begin
      MessageDlg('Error saving ID3v2 tag, error code: ' + IntToStr(ErrorCode) + #13#10 + ID3v2TagErrorCode2String(ErrorCode), mtError, [mbOk], 0);
  end;

end;

end.
