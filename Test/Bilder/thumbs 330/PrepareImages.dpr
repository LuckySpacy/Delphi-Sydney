program PrepareImages;

uses
  Forms,
  SysUtils,
  PrMain in 'units\PrMain.pas' {MainForm},
  PrShowUnit in 'units\PrShowUnit.pas' {ShowForm},
  PrConstVars in 'units\PrConstVars.pas',
  PrJpegConv in 'units\PrJpegConv.pas';

{$R *.res}

begin
  ProgPath:=ExtractFilePath(Application.ExeName);
  if ProgPath[Length(ProgPath)]<>'\' then ProgPath:=ProgPath+'\';
  Application.Initialize;
  Application.Title := 'Bilder und Verzeichnisse für php-Galerien vorbereiten';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
