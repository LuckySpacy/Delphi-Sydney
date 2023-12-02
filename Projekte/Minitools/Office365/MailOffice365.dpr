program MailOffice365;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Form.MailOffice365 in 'Form\Form.MailOffice365.pas' {frm_MailOffice365},
  Objekt.Ini in 'Objekt\Objekt.Ini.pas',
  Types.Mail in 'Types\Types.Mail.pas',
  Objekt.Mail in 'Objekt\Objekt.Mail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_MailOffice365, frm_MailOffice365);
  Application.Run;
end.
