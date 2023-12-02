unit Form.Audiofile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.MainChild, nfsButton, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls, Objekt.AudioFile;

type
  Tfrm_AudioFile = class(Tfrm_MainChild)
    PageControl1: TPageControl;
    pnl_Button: TPanel;
    tbs_Einfach: TTabSheet;
    tbs_Details: TTabSheet;
    tbs_Klassifikation: TTabSheet;
    tbs_Liedtext: TTabSheet;
    tbs_Bild: TTabSheet;
    tbs_Benutzerdefiniert: TTabSheet;
    btn_Zurueck: TnfsButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edt_Typ: TEdit;
    edt_Dateiname: TEdit;
    edt_Speicherort: TEdit;
    edt_Titel: TLabeledEdit;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    edt_Interpret: TLabeledEdit;
    edt_Album: TLabeledEdit;
    edt_Genre: TLabeledEdit;
    Kommentar: TLabel;
    mem_Kommentar: TMemo;
    edt_Jahr: TLabeledEdit;
    edt_TrackNo: TLabeledEdit;
    mem_Liedtext: TMemo;
    Image1: TImage;
    btn_Save: TnfsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
  private
    fAudioFile: TAudioFile;
  public
    procedure LadeAudio(aFullFilename: string);
  end;

var
  frm_AudioFile: Tfrm_AudioFile;

implementation

{$R *.dfm}

procedure Tfrm_AudioFile.btn_SaveClick(Sender: TObject);
begin
  fAudioFile.Titel   := edt_Titel.Text;
  fAudioFile.Artist  := edt_Interpret.Text;
  fAudioFile.Genre   := edt_Genre.Text;
  fAudioFile.Album   := edt_Album.Text;
  fAudioFile.Year    := edt_Jahr.Text;
  fAudioFile.TrackNo := edt_TrackNo.Text;
  fAudioFile.Kommentar.Text := mem_Kommentar.Lines.Text;
  fAudioFile.Lyrics.Text := mem_Liedtext.Text;
  //fAudioFile.SaveMP3File;
  fAudioFile.Save(edt_Speicherort.Text);
end;

procedure Tfrm_AudioFile.FormCreate(Sender: TObject);
begin
  inherited;
  fAudioFile := TAudioFile.Create;
end;

procedure Tfrm_AudioFile.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fAudioFile);
  inherited;
end;

procedure Tfrm_AudioFile.LadeAudio(aFullFilename: string);
begin
  //fAudioFile.ReadMP3File(aFullFilename);
  fAudioFile.Read(aFullFilename);
  edt_Speicherort.Text := aFullFilename;
  edt_Dateiname.Text   := fAudioFile.Dateiname;
  edt_Typ.Text         := 'Musik';
  edt_Titel.Text       := fAudioFile.Titel;
  edt_Interpret.Text   := fAudioFile.Artist;
  edt_Genre.Text       := fAudioFile.Genre;
  edt_Album.Text       := fAudioFile.Album;
  edt_Jahr.Text        := fAudioFile.Year;
  edt_TrackNo.Text     := fAudioFile.TrackNo;
  mem_Kommentar.Lines.Text := fAudioFile.Kommentar.Text;
  mem_Liedtext.Text        := fAudioFile.Lyrics.Text;
  //Image1.Picture.LoadFromStream(fAudioFile.AudioFilePictureList.Item[0].Image.Picture.SaveToStream())
  if fAudioFile.AudioFilePictureList.Count > 0 then
    Image1.Picture.Assign(fAudioFile.AudioFilePictureList.Item[0].Image.Picture);
end;

end.
