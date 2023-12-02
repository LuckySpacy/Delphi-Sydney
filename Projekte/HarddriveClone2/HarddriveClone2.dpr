program HarddriveClone2;

uses
  FastMM4 in '..\Log4d\FastMM\FastMM4.pas',
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  FastMM4Messages in '..\Log4d\FastMM\Translations\German\by Thomas Speck\FastMM4Messages.pas',
  Vcl.Forms,
  Form.HarddriveClone2 in 'Form\Form.HarddriveClone2.pas' {frm_Harddriveclone2},
  Objekt.Logger in 'Objekt\Objekt.Logger.pas',
  Objekt.Basislist in 'Objekt\Objekt.Basislist.pas',
  Objekt.ObjektList in 'Objekt\Objekt.ObjektList.pas',
  Objekt.HarddriveClone2 in 'Objekt\Objekt.HarddriveClone2.pas',
  Objekt.Ini in 'Objekt\Objekt.Ini.pas',
  Objekt.HarddriveCloneIni in 'Objekt\Objekt.HarddriveCloneIni.pas',
  dm.Datenbank in 'Form\dm.Datenbank.pas' {dm_Datenbank: TDataModule},
  Objekt.HarddriveCloneDBIni in 'Objekt\Objekt.HarddriveCloneDBIni.pas',
  DB.CreateFDB in 'Datenbank\DB.CreateFDB.pas',
  DB.Basis in 'Datenbank\DB.Basis.pas',
  Objekt.DBFeld in 'Objekt\Objekt.DBFeld.pas',
  Objekt.DBFeldList in 'Objekt\Objekt.DBFeldList.pas',
  DB.BasisList in 'Datenbank\DB.BasisList.pas',
  DB.Job in 'Datenbank\DB.Job.pas',
  DB.JobList in 'Datenbank\DB.JobList.pas',
  DB.IgnorePfad in 'Datenbank\DB.IgnorePfad.pas',
  DB.IgnorePfadList in 'Datenbank\DB.IgnorePfadList.pas',
  Form.Base in 'Form\Form.Base.pas' {frm_Base},
  Form.Joblist in 'Form\Form.Joblist.pas' {frm_Joblist},
  Objekt.FormList in 'Objekt\Objekt.FormList.pas',
  Form.JobItem in 'Form\Form.JobItem.pas' {frm_JobItem},
  Form.JobItemEdit in 'Form\Form.JobItemEdit.pas' {frm_JobItemEdit},
  Form.IgnorePfad in 'Form\Form.IgnorePfad.pas' {frm_IgnorePfad},
  Form.Main in 'Form\Form.Main.pas' {frm_Main},
  DB.Datei in 'Datenbank\DB.Datei.pas',
  DB.DateiList in 'Datenbank\DB.DateiList.pas',
  Form.Prozess in 'Form\Form.Prozess.pas' {frm_Prozess},
  Objekt.Dateisystem in '..\Allgemein\Objekt\Objekt.Dateisystem.pas',
  Objekt.DateiList in '..\Allgemein\Objekt\Objekt.DateiList.pas',
  Objekt.Datei in '..\Allgemein\Objekt\Objekt.Datei.pas',
  Objekt.Dateidatum in '..\Allgemein\Objekt\Objekt.Dateidatum.pas',
  Thread.FestplatteEinlesen in 'Thread\Thread.FestplatteEinlesen.pas',
  DB.JobDatei in 'Datenbank\DB.JobDatei.pas',
  DB.JobDateiList in 'Datenbank\DB.JobDateiList.pas',
  Thread.CopyFiles in 'Thread\Thread.CopyFiles.pas',
  VW.JobDatei in 'View\VW.JobDatei.pas',
  VW.Basis in 'View\VW.Basis.pas',
  VW.JobDateiList in 'View\VW.JobDateiList.pas',
  Objekt.FestplatteEinlesen in 'Objekt\Objekt.FestplatteEinlesen.pas',
  Objekt.ProzessBasis in 'Objekt\Objekt.ProzessBasis.pas',
  Objekt.CloneManager in 'Objekt\Objekt.CloneManager.pas',
  DB.Delete in 'Datenbank\DB.Delete.pas',
  Objekt.HarddriveCloneFormIni in 'Objekt\Objekt.HarddriveCloneFormIni.pas',
  Objekt.DBUpgrade in 'Objekt\Objekt.DBUpgrade.pas',
  DB.Upgrade in 'Datenbank\DB.Upgrade.pas',
  DB.UpgradeList in 'Datenbank\DB.UpgradeList.pas',
  Objekt.IgnorePfad in 'Objekt\Objekt.IgnorePfad.pas',
  Objekt.IgnorePfadList in 'Objekt\Objekt.IgnorePfadList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := False;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm_Datenbank, dm_Datenbank);
  Application.CreateForm(Tfrm_Harddriveclone2, frm_Harddriveclone2);
  Application.Run;
end.
