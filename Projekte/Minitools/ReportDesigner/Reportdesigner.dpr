program Reportdesigner;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Form.Reportdesigner in 'Form\Form.Reportdesigner.pas' {frm_Reportdesigner},
  Konstanten.Dateien in 'Konstanten\Konstanten.Dateien.pas',
  Objekt.Dateien in 'Objekt\Objekt.Dateien.pas',
  Objekt.Folderlocation in 'Objekt\Objekt.Folderlocation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Reportdesigner, frm_Reportdesigner);
  Application.Run;
end.
