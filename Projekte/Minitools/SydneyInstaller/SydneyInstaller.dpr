program SydneyInstaller;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Form.SydneyInstaller in 'Form\Form.SydneyInstaller.pas' {frm_SydneyInstaller},
  Objekt.Registry in 'Objekt\Objekt.Registry.pas',
  Objekt.Ini in 'Objekt\Objekt.Ini.pas',
  Objekt.Bibliothek in 'Objekt\Objekt.Bibliothek.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_SydneyInstaller, frm_SydneyInstaller);
  Application.Run;
end.
