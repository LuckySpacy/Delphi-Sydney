program Zeitplaner;

uses
  Vcl.Forms,
  Form.Zeitplaner in 'Form\Form.Zeitplaner.pas' {frm_Zeitplaner},
  Form.Option in 'Form\Form.Option.pas' {frm_Option},
  Form.Mail in 'Form\Form.Mail.pas' {frm_Mail},
  Objekt.Option in '..\Backup\Objekt\Objekt.Option.pas',
  Datenmodul.DM in '..\Backup\Datenmodul\Datenmodul.DM.pas' {dm: TDataModule},
  Allgemein.Funktionen in 'Allgemein\Allgemein.Funktionen.pas',
  Allgemein.RegIni in 'Allgemein\Allgemein.RegIni.pas',
  Allgemein.SysFolderlocation in 'Allgemein\Allgemein.SysFolderlocation.pas',
  Allgemein.System in 'Allgemein\Allgemein.System.pas',
  Allgemein.Types in 'Allgemein\Allgemein.Types.pas',
  Objekt.Allgemein in '..\Backup\Objekt\Objekt.Allgemein.pas',
  Objekt.Logger in '..\Backup\Objekt\Objekt.Logger.pas',
  Log4D in '..\..\Log4d\Log4D.pas',
  Objekt.Ini in '..\Backup\Objekt\Objekt.Ini.pas',
  Objekt.Backup in '..\Backup\Objekt\Objekt.Backup.pas',
  Objekt.Maildat in '..\Backup\Objekt\Objekt.Maildat.pas',
  Objekt.DateTime in '..\Backup\Objekt\Objekt.DateTime.pas',
  Objekt.SendMail in '..\Backup\Objekt\Objekt.SendMail.pas',
  Objekt.OptionList in '..\Backup\Objekt\Objekt.OptionList.pas',
  Objekt.BaseList in '..\Backup\Objekt\Objekt.BaseList.pas',
  Objekt.Backupchecker in '..\Backup\Objekt\Objekt.Backupchecker.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Zeitplaner, frm_Zeitplaner);
  Application.Run;
end.
