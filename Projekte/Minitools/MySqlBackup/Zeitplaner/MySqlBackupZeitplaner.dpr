program MySqlBackupZeitplaner;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Form.Zeitplaner in 'Form\Form.Zeitplaner.pas' {frm_Zeitplaner},
  Form.Option in 'Form\Form.Option.pas' {frm_Option},
  Objekt.Option in '..\Backup\Objekt\Objekt.Option.pas',
  Objekt.BaseList in '..\Backup\Objekt\Objekt.BaseList.pas',
  Objekt.OptionList in '..\Backup\Objekt\Objekt.OptionList.pas',
  Objekt.Allgemein in '..\Backup\Objekt\Objekt.Allgemein.pas',
  Objekt.Logger in '..\Backup\Objekt\Objekt.Logger.pas',
  Allgemein.System in 'Allgemein\Allgemein.System.pas',
  Allgemein.Funktionen in 'Allgemein\Allgemein.Funktionen.pas',
  Allgemein.RegIni in 'Allgemein\Allgemein.RegIni.pas',
  Allgemein.SysFolderlocation in 'Allgemein\Allgemein.SysFolderlocation.pas',
  Allgemein.Types in 'Allgemein\Allgemein.Types.pas',
  Objekt.Ini in '..\Backup\Objekt\Objekt.Ini.pas',
  Objekt.MySqlBackup in '..\Backup\Objekt\Objekt.MySqlBackup.pas',
  Objekt.IniDienst in '..\Backup\Objekt\Objekt.IniDienst.pas',
  c_AllgTypes in '..\..\Allgemein\Units\c_AllgTypes.pas',
  o_sysfolderlocation in '..\..\Allgemein\Units\o_sysfolderlocation.pas',
  u_System in '..\..\Allgemein\Units\u_System.pas',
  Objekt.Basislist in '..\..\Allgemein\Objekt\Objekt.Basislist.pas',
  Objekt.Datei in '..\..\Allgemein\Objekt\Objekt.Datei.pas',
  Objekt.Dateidatum in '..\..\Allgemein\Objekt\Objekt.Dateidatum.pas',
  Objekt.DateiList in '..\..\Allgemein\Objekt\Objekt.DateiList.pas',
  Objekt.Dateisystem in '..\..\Allgemein\Objekt\Objekt.Dateisystem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Zeitplaner, frm_Zeitplaner);
  Application.CreateForm(Tfrm_Option, frm_Option);
  Application.Run;
end.
