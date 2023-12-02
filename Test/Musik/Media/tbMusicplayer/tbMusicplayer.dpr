program tbMusicplayer;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.tbMusicplayer in 'Form\Form.tbMusicplayer.pas' {frm_tbMusicplayer},
  Objekt.Permissions in 'Objekt\Objekt.Permissions.pas',
  Objekt.tbMusicplayer in 'Objekt\Objekt.tbMusicplayer.pas',
  Form.Player in 'Form\Form.Player.pas' {frm_Player};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_tbMusicplayer, frm_tbMusicplayer);
  Application.CreateForm(Tfrm_Player, frm_Player);
  Application.Run;
end.
