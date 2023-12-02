program Test1Musikplayer;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.Test1Musikplayer in 'Form.Test1Musikplayer.pas' {Form2},
  Androidapi.IOUtilsEx in 'Androidapi.IOUtilsEx.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
