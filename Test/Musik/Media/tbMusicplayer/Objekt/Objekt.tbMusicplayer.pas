unit Objekt.tbMusicplayer;

interface

type
  TtbMusicplayer = class
  private
  public
    constructor Create;
    destructor Destroy;
    function getMusikpfad: string;
  end;

var
  Musicplayer: TtbMusicplayer;


implementation

{ TtbMusicplayer }

uses
  System.IOUtils;


constructor TtbMusicplayer.Create;
begin

end;

destructor TtbMusicplayer.Destroy;
begin

end;

function TtbMusicplayer.getMusikpfad: string;
begin
  Result := System.IOUtils.TPath.GetHomePath;
  {$IFDEF ANDROID}
  Result := '/storage/9C33-6BBD/Music';
  {$ENDIF ANDROID}
end;

end.
