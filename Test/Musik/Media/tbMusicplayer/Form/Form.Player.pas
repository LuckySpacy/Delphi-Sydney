unit Form.Player;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Media;

type
  Tfrm_Player = class(TForm)
    Layout1: TLayout;
    btn_Play: TSpeedButton;
    MediaPlayer: TMediaPlayer;
    procedure btn_PlayClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_Player: Tfrm_Player;

implementation

{$R *.fmx}

uses
  Objekt.tbMusicplayer;

procedure Tfrm_Player.btn_PlayClick(Sender: TObject);
var
  Filename: string;
begin
  MediaPlayer.Volume := 100;
  Filename := Musicplayer.getMusikpfad + PathDelim + 'Aloha.mp3';
  if not FileExists(Filename) then
    exit;
  //Filename := 'https://www.bachmannserver.de/Aloha.mp3';
  MediaPlayer.FileName := Filename;
  MediaPlayer.Play;
end;

end.
