unit Form.tbMusicplayer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  Objekt.Permissions, Objekt.tbMusicplayer, Form.Player;

type
  Tfrm_tbMusicplayer = class(TForm)
    TabControl: TTabControl;
    tbs_Player: TTabItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fPermissions: TMyPermissions;
    fFormPlayer: Tfrm_Player;
  public
  end;

var
  frm_tbMusicplayer: Tfrm_tbMusicplayer;

implementation

{$R *.fmx}

procedure Tfrm_tbMusicplayer.FormCreate(Sender: TObject);
begin
  fPermissions := TMyPermissions.Create;
  fPermissions.getPermissions;
  MusicPlayer := TtbMusicPlayer.Create;

  fFormPlayer := Tfrm_Player.Create(Self);
  while fFormPlayer.ChildrenCount>0 do
    fFormPlayer.Children[0].Parent := tbs_Player;


end;

procedure Tfrm_tbMusicplayer.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fPermissions);
  FreeAndNil(MusicPlayer);
end;

end.
