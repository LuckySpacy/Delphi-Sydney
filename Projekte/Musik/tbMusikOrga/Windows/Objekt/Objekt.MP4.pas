unit Objekt.MP4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs, MP4TagLibrary, Objekt.AudioStruktur;


type
  TMP4 = class(TAudioStruktur)
  private
    fMP4Tag: TMP4Tag;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ReadMP4File(aFilename: string);
    procedure SaveMP4File(aFilename: string);
  end;

implementation

{ TMP4 }

uses
  Objekt.AudioFilePicture, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

constructor TMP4.Create;
begin
  inherited;
  fMP4Tag := TMP4Tag.Create;
end;

destructor TMP4.Destroy;
begin
  FreeAndNil(fMP4Tag);
  inherited;
end;

procedure TMP4.ReadMP4File(aFilename: string);
var
  i1: Integer;
  FilePicture: TAudioFilePicture;
  PictureMagic: Word;
begin

  Init;

  if not FileExists(aFilename) then
    exit;

  FPfad          := ExtractFileDir(aFilename);
  fFullDateiname := aFilename;
  FDateiname := ExtractFileName(aFilename);


  fMP4Tag.LoadFromFile(aFilename);

  fTitel  := fMP4Tag.GetText('©nam');
  fArtist := fMP4Tag.GetText('©ART');
  fAlbum  := fMP4Tag.GetText('©alb');
  fGenre  := fMP4Tag.GetGenre;
  fYear   := fMP4Tag.GetText('©day');

  //* Some helper functions which extract the values from the stream
  fTrackNo := IntToStr(fMP4Tag.GetTrack);
  fTotalTracks := IntToStr(fMP4Tag.GetTotalTracks);
  fDisc := IntToStr(fMP4Tag.GetDisc);
  fTotalDisc := IntToStr(fMP4Tag.GetTotalDiscs);
  fKommentar.Text := fMP4Tag.GetText('©cmt');
  fLyrics.Text    := fMP4Tag.GetText('©lyr');

  if (fMP4Tag.VideoWidth <> 0) and (fMP4Tag.VideoHeight <> 0) then
  begin
    fVideoFormat.Height := fMP4Tag.VideoHeight;
    fVideoFormat.Width  := fMP4Tag.VideoWidth;
  end;

  case fMP4Tag.AudioFormat of
    mp4afUnknown: AudioFormat := 'Unknown audio track format';
    mp4afAAC: AudioFormat     := 'AAC audio, ' + IntToStr(fMP4Tag.AudioSampleRate) + ' Hz, ' + IntToStr(fMP4Tag.AudioResolution) + ' bit, ' + IntToStr(fMP4Tag.AudioChannelCount) + ' channels';
    mp4afALAC: AudioFormat    := 'ALAC audio, ' + IntToStr(fMP4Tag.AudioSampleRate) + ' Hz, ' + IntToStr(fMP4Tag.AudioResolution) + ' bit, ' + IntToStr(fMP4Tag.AudioChannelCount) + ' channels';
    mpfafAC3: AudioFormat     := 'AC3 audio, ' + IntToStr(fMP4Tag.AudioSampleRate) + ' Hz, ' + IntToStr(fMP4Tag.AudioResolution) + ' bit, ' + IntToStr(fMP4Tag.AudioChannelCount) + ' channels';
  end;

  fSampelrate := fMP4Tag.AudioSampleRate;
  fBitrate    := fMP4Tag.AudioResolution;
  if fMP4Tag.AudioChannelCount = 2 then
    fChannelMode := 'Stereo'
  else
    fChannelMode := 'Mono';

  for i1 := 0 to fMP4Tag.Count -1 do
  begin
    fKommentar.Text := fKommentar.Text + AtomNameToString(fMP4Tag.Atoms[i1].ID) + '; ';
  end;


  fAudioFilePictureList.Clear;
  for i1 := 0 to fMP4Tag.Count -1 do
  begin
    if IsSameAtomName(fMP4Tag.Atoms[i1].ID, 'covr') then
    begin
      FilePicture := fAudioFilePictureList.Add;
      FilePicture.Id := AtomNameToString(fMP4Tag.Atoms[i1].ID);
      FilePicture.Size := fMP4Tag.Atoms[i1].Size;

      if fMP4Tag.Atoms[i1].Datas[0].Data.Size > 0 then
      begin
        //* Position should be at start, just to be sure
        fMP4Tag.Atoms[i1].Datas[0].Data.Seek(0, soBeginning);
        //* Datas[0] means the first cover stream
        fMP4Tag.Atoms[i1].Datas[0].Data.Read(PictureMagic, 2);
        if PictureMagic = MAGIC_JPG then
        begin
          FilePicture.JPEGPicture := TJPEGImage.Create;
          fMP4Tag.Atoms[i1].Datas[0].Data.Seek(0, soBeginning);
          FilePicture.JPEGPicture.LoadFromStream(fMP4Tag.Atoms[i1].Datas[0].Data);
          FilePicture.Image.Picture.Assign(FilePicture.JPEGPicture);
        end;
        if PictureMagic = MAGIC_PNG then
        begin
          FilePicture.PNGPicture := TPNGImage.Create;
          fMP4Tag.Atoms[i1].Datas[0].Data.Seek(0, soBeginning);
          FilePicture.PNGPicture.LoadFromStream(fMP4Tag.Atoms[i1].Datas[0].Data);
          FilePicture.Image.Picture.Assign(FilePicture.PNGPicture);
        end;
      end;
    end;
    if IsSameAtomName(fMP4Tag.Atoms[i1].ID, 'gnre') then
    begin
      fGenre := fGenre + ID3Genres[fMP4Tag.Atoms[i1].GetAsInteger16];
    end;
  end;

  //* List Xtra
  //for i := 0 to MP4Tag.Xtras.Count - 1 do begin
  //    Memo1.Lines.Add(MP4Tag.Xtras[i].Name + ' ' + IntToStr(MP4Tag.Xtras[i].GetTotalSize(True)) + ' bytes = ' + MP4Tag.Xtras[i].GetAsText(True));
  //end;
end;

procedure TMP4.SaveMP4File(aFilename: string);
var
  Error: Integer;
begin
  if not FileExists(fFullDateiname) then
    exit;

  fMP4Tag.LoadFromFile(aFilename);
  //* Set specific tags
  fMP4Tag.SetText('©nam', fTitel);
  fMP4Tag.SetText('©ART', fArtist);
  fMP4Tag.SetText('©alb', fAlbum);
  //* Automatically set proper genre
  fMP4Tag.SetGenre(fGenre);
    //* Genre can be stored as an index to an ID3 genre + 1 or as a text (for custom genre)
    {
    GenreIndex := GenreToIndex(Edit5.Text);
    if GenreIndex > - 1 then begin
        MP4Tag.SetInteger16('gnre', GenreIndex);
    end else begin
        MP4Tag.SetText('©gen', Edit5.Text);
    end;
    }
  fMP4Tag.SetText('©day', fYear);
  //* Some helper functions which encode the values to the stream
  fMP4Tag.SetTrack(StrToIntDef(fTrackNo, 0), StrToIntDef(fTotalTracks, 0));
  fMP4Tag.SetDisc(StrToIntDef(fDisc, 0), StrToIntDef(fTotalDisc, 0));
  fMP4Tag.SetText('©cmt', fKommentar.Text);
    //* Set an album cover picture
    //MP4Tag.DeleteAtom('covr');
    //MP4Tag.AddAtom('covr').AddData.Data.LoadFromFile('H:\MP4 Files\Cover1.png');
    //* To add more pictures
    //MP4Tag.FindAtom('covr').AddData.Data.LoadFromFile('H:\MP4 Files\Cover2.jpg');
  Error := fMP4Tag.SaveToFile(fFullDateiname);
  if Error <> MP4TAGLIBRARY_SUCCESS then begin
        Showmessage('Error while saving tag, error code: ' + IntToStr(Error));
  end;
end;

end.
