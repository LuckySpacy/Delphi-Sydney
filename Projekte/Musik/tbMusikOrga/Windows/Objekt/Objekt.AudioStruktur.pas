unit Objekt.AudioStruktur;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs, Objekt.AudioFileText, Objekt.AudioFilePictureList;


type
  TVideoFormat = class
  public
    Width: Integer;
    Height: Integer;
  end;

type
  TAudioStruktur = class
  private
  protected
    fSampelrate: Integer;
    fYear: string;
    fGenre: string;
    fDateiname: string;
    fTitel: string;
    fLyrics: TAudioFileText;
    fChannelMode: string;
    fBitrate: Integer;
    fArtist: string;
    fDateigroesse: Integer;
    fvbr: Boolean;
    fDauer: Integer;
    fAlbum: string;
    fPfad: string;
    fFullDateiname: string;
    fWasUnsynchronised: Boolean;
    fExtendedHeader: Boolean;
    fExperimental: Boolean;
    fCRC32: Boolean;
    fRecordingTime: TDateTime;
    fTrackNo: string;
    fWXXXURL: string;
    fKommentar: TAudioFileText;
    fAudioFilePictureList: TAudioFilePictureList;
    fPlayTime: string;
    fTotalTracks: string;
    fDisc: string;
    fTotalDisc: string;
    fVideoFormat: TVideoFormat;
    fAudioFormat: string;
    function mSec2Time(mSec: Int64): String;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Pfad: string read fPfad write fPfad;
    property FullDateiname: string read fFullDateiname write fFullDateiname;
    property Dateiname: string read fDateiname write fDateiname;
    property Dateigroesse: Integer read fDateigroesse write fDateigroesse;
    property Artist: string read fArtist write fArtist;
    property Titel: string read fTitel write fTitel;
    property Album: string read fAlbum write fAlbum;
    property Year: string read fYear write fYear;
    property Genre: string read fGenre write fGenre;
    property Dauer: Integer read fDauer write fDauer;
    property Bitrate: Integer read fBitrate write fBitrate;
    property vbr: Boolean read fvbr write fvbr;
    property ChannelMode: string read fChannelMode write fChannelMode;
    property Samplerate: Integer read fSampelrate write fSampelrate;
    property WasUnsynchronised: Boolean read fWasUnsynchronised write fWasUnsynchronised;
    property ExtendedHeader: Boolean read fExtendedHeader write fExtendedHeader;
    property Experimental: Boolean read fExperimental write fExperimental;
    property RecordingTime: TDateTime read fRecordingTime write fRecordingTime;
    property TrackNo: string read fTrackNo write fTrackNo;
    property TotalTracks: string read fTotalTracks write fTotalTracks;
    property Disc: string read fDisc write fDisc;
    property TotalDisc: string read fTotalDisc write fTotalDisc;
    property CRC32: Boolean read fCRC32 write fCRC32;
    property WXXXURL: string read fWXXXURL write fWXXXURL;
    property Kommentar: TAudioFileText read fKommentar write fKommentar;
    property Lyrics: TAudioFileText read fLyrics write fLyrics;
    property PlayTime: string read fPlayTime write fPlayTime;
    property VideoFormat: TVideoFormat read fVideoFormat write fVideoFormat;
    property AudioFormat: string read fAudioFormat write fAudioFormat;
    procedure Init; virtual;
    function AudioFilePictureList: TAudioFilePictureList;
    procedure CopyStruktur(aAudioStruktur: TAudioStruktur);
    procedure setStruktur(aAudioStruktur: TAudioStruktur);
  end;

implementation

{ TAudioStruktur }

uses
  Objekt.AudioFilePicture;



constructor TAudioStruktur.Create;
begin
  fKommentar := TAudioFileText.Create;
  fLyrics    := TAudioFileText.Create;
  fAudioFilePictureList := TAudioFilePictureList.Create;
  fVideoFormat := TVideoFormat.Create;
  Init;
end;

destructor TAudioStruktur.Destroy;
begin
  FreeAndNil(fKommentar);
  FreeAndNil(fLyrics);
  FreeAndNil(fAudioFilePictureList);
  FreeAndNil(fVideoFormat);
  inherited;
end;

procedure TAudioStruktur.Init;
begin
  fSampelrate  := 0;
  fYear        := '';
  fGenre       := '';
  fDateiname   := '';
  fTitel       := '';
  fChannelMode := '';
  fBitrate     := 0;
  fArtist      := '';
  fDateigroesse:= 0;
  fvbr         := false;
  fDauer       := 0;
  fAlbum       := '';
  fPfad        := '';
  fFullDateiname := '';
  fWasUnsynchronised := false;
  fExtendedHeader := false;
  fExperimental := false;
  fCRC32 := false;
  fRecordingTime := 0;
  fTrackNo := '';
  fTotalTracks := '';
  fDisc := '';
  fTotalDisc := '';
  fWXXXURL := '';
  fPlayTime := '';
  fVideoFormat.Width  := 0;
  fVideoFormat.Height := 0;
  fAudioFormat := '';
end;

function TAudioStruktur.mSec2Time(mSec: Int64): String;
var
  tHours: String;
  tMinutes: String;
  tSecs: String;
  tmSecs: String;
  Seconds: Int64;
begin
    if mSec = 4294967295
        then mSec := 0;
    Seconds := mSec div 1000;
    tHours := IntToStr(Seconds div 3600);
    if Length(tHours) = 1
        then tHours := '0' + tHours;
    tMinutes := IntToStr(((Seconds - (StrToInt(tHours) * 3600)) div 60));
    if Length(tMinutes) = 1
        then tMinutes := '0' + tMinutes;
    tSecs := IntToStr(Seconds - (StrToInt(tHours) * 3600 + StrToInt(tMinutes) * 60));
    if Length(tSecs) = 1
        then tSecs := '0' + tSecs;
    tmSecs := IntToStr(mSec - ((StrToInt(tHours) * 3600 + StrToInt(tMinutes) * 60) + StrToInt(tSecs)) * 1000);
    case Length(tmSecs) of
        1: tmSecs := '00' + tmSecs;
        2: tmSecs := '0' + tmSecs;
    end;
    tmSecs := Copy(tmSecs, 1, 2);
    Result := tHours + ':' + tMinutes + ':' + tSecs + '.' + tmSecs;
end;


function TAudioStruktur.AudioFilePictureList: TAudioFilePictureList;
begin
  Result := fAudioFilePictureList;
end;

procedure TAudioStruktur.CopyStruktur(aAudioStruktur: TAudioStruktur);
var
  i1: Integer;
  FilePicture: TAudioFilePicture;
  ms: TMemoryStream;
begin
  aAudioStruktur.Samplerate  := fSampelrate;
  aAudioStruktur.Year        := fYear;
  aAudioStruktur.Genre       := fGenre;
  aAudioStruktur.Dateiname   := fDateiname;
  aAudioStruktur.Titel       := fTitel;
  aAudioStruktur.ChannelMode := fChannelMode;
  aAudioStruktur.Bitrate     := fBitrate;
  aAudioStruktur.Artist      := fArtist;
  aAudioStruktur.Dateigroesse := fDateigroesse;
  aAudioStruktur.vbr          := fvbr;
  aAudioStruktur.Dauer        := fDauer;
  aAudioStruktur.Album        := fAlbum;
  aAudioStruktur.Pfad         := fPfad;
  aAudioStruktur.FullDateiname := fFullDateiname;
  aAudioStruktur.WasUnsynchronised := fWasUnsynchronised;
  aAudioStruktur.ExtendedHeader := fExtendedHeader;
  aAudioStruktur.Experimental := fExperimental;
  aAudioStruktur.CRC32 := fCRC32;
  aAudioStruktur.RecordingTime := fRecordingTime;
  aAudioStruktur.TrackNo := fTrackNo;
  aAudioStruktur.TotalTracks := fTotalTracks;
  aAudioStruktur.Disc := fDisc;
  aAudioStruktur.TotalDisc := fTotalDisc;
  aAudioStruktur.WXXXURL := fWXXXURL;
  aAudioStruktur.PlayTime := fPlayTime;
  aAudioStruktur.Kommentar.LanguageId  := fKommentar.LanguageId;
  aAudioStruktur.Kommentar.Text        := fKommentar.Text;
  aAudioStruktur.Kommentar.Description := fKommentar.Description;
  aAudioStruktur.Lyrics.LanguageId  := fLyrics.LanguageId;
  aAudioStruktur.Lyrics.Text        := fLyrics.Text;
  aAudioStruktur.Lyrics.Description := fLyrics.Description;
  aAudioStruktur.VideoFormat.Width  := fVideoFormat.Width;
  aAudioStruktur.VideoFormat.Height := fVideoFormat.Height;
  aAudioStruktur.AudioFormat := fAudioFormat;
  aAudioStruktur.AudioFilePictureList.Clear;
  for i1 := 0 to fAudioFilePictureList.Count -1 do
  begin
    ms := TMemoryStream.Create;
    try
      fAudioFilePictureList.Item[i1].Image.Picture.SaveToStream(ms);
      ms.Position := 0;
      FilePicture := aAudioStruktur.AudioFilePictureList.Add;
      FilePicture.Image.Picture.LoadFromStream(ms);
    finally
      FreeAndNil(ms);
    end;
  end;
end;

procedure TAudioStruktur.setStruktur(aAudioStruktur: TAudioStruktur);
var
  i1: Integer;
  FilePicture: TAudioFilePicture;
  ms: TMemoryStream;
begin
  fSampelrate   := aAudioStruktur.Samplerate;
  fYear         := aAudioStruktur.Year;
  fGenre        := aAudioStruktur.Genre;
  fDateiname    := aAudioStruktur.Dateiname;
  fTitel        := aAudioStruktur.Titel;
  fChannelMode  := aAudioStruktur.ChannelMode;
  fBitrate      := aAudioStruktur.Bitrate;
  fArtist       := aAudioStruktur.Artist;
  fDateigroesse := aAudioStruktur.Dateigroesse;
  fvbr          := fvbr;
  fDauer        := aAudioStruktur.Dauer;
  fAlbum        := aAudioStruktur.Album;
  fPfad         := aAudioStruktur.Pfad;
  fFullDateiname := aAudioStruktur.FullDateiname;
  fWasUnsynchronised := aAudioStruktur.WasUnsynchronised;
  fExtendedHeader := aAudioStruktur.ExtendedHeader;
  fExperimental   := aAudioStruktur.Experimental;
  fCRC32          := aAudioStruktur.CRC32;
  fRecordingTime  := aAudioStruktur.RecordingTime;
  fTrackNo        := aAudioStruktur.TrackNo;
  fTotalTracks    := aAudioStruktur.TotalTracks;
  fDisc           := aAudioStruktur.Disc;
  fTotalTracks    := aAudioStruktur.TotalDisc;
  fWXXXURL        := aAudioStruktur.WXXXURL;
  fPlayTime       := aAudioStruktur.PlayTime;
  fVideoFormat.Height := aAudioStruktur.VideoFormat.Height;
  fVideoFormat.Width  := aAudioStruktur.VideoFormat.Width;
  fAudioFormat        := aAudioStruktur.AudioFormat;

  fKommentar.LanguageId  := aAudioStruktur.Kommentar.LanguageId;
  fKommentar.Text        := aAudioStruktur.Kommentar.Text;
  fKommentar.Description := aAudioStruktur.Kommentar.Description;

  fLyrics.LanguageId     := aAudioStruktur.Lyrics.LanguageId;
  fLyrics.Text           := aAudioStruktur.Lyrics.Text;
  fLyrics.Description    := aAudioStruktur.Lyrics.Description;

  fAudioFilePictureList.Clear;
  for i1 := 0 to aAudioStruktur.AudioFilePictureList.Count -1 do
  begin
    ms := TMemoryStream.Create;
    try
      aAudioStruktur.AudioFilePictureList.Item[i1].Image.Picture.SaveToStream(ms);
      ms.Position := 0;
      FilePicture := fAudioFilePictureList.Add;
      FilePicture.Image.Picture.LoadFromStream(ms);
    finally
      FreeAndNil(ms);
    end;
  end;

end;


end.
