program MyFileSaverUI;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Form.MyFileSaverUI in 'Form\Form.MyFileSaverUI.pas' {frm_MyFileSaver},
  Objekt.MyFileServer in '..\Objekt\Objekt.MyFileServer.pas',
  Objekt.Option in '..\Objekt\Objekt.Option.pas',
  Objekt.BaseList in '..\Objekt\Objekt.BaseList.pas',
  Objekt.OptionList in '..\Objekt\Objekt.OptionList.pas',
  Form.Option in 'Form\Form.Option.pas' {frm_Option};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_MyFileSaver, frm_MyFileSaver);
  Application.Run;
end.
