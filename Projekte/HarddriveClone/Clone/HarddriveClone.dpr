program HarddriveClone;

uses
  Vcl.Forms,
  Form.Harddriveclone in 'Form\Form.Harddriveclone.pas' {frm_Harddrive},
  Objekt.Basislist in 'Objekt\Objekt.Basislist.pas',
  Objekt.ObjektList in 'Objekt\Objekt.ObjektList.pas',
  Objekt.HarddriveClone in 'Objekt\Objekt.HarddriveClone.pas',
  Objekt.Logger in 'Objekt\Objekt.Logger.pas',
  sys.Objekt in '..\sys\sys.Objekt.pas',
  sys.Folderlocation in '..\sys\sys.Folderlocation.pas',
  sys.Disk in '..\sys\sys.Disk.pas',
  Types.Folder in '..\Types\Types.Folder.pas',
  Objekt.Job in '..\UI\Objekt\Objekt.Job.pas',
  Objekt.JobList in '..\UI\Objekt\Objekt.JobList.pas',
  Objekt.Datei in 'Objekt\Objekt.Datei.pas',
  Objekt.DateiList in 'Objekt\Objekt.DateiList.pas',
  Objekt.DateiSync in 'Objekt\Objekt.DateiSync.pas',
  Objekt.DateiSyncList in 'Objekt\Objekt.DateiSyncList.pas',
  Objekt.Protokoll in 'Objekt\Objekt.Protokoll.pas',
  Objekt.ProtokollList in 'Objekt\Objekt.ProtokollList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := False;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Harddrive, frm_Harddrive);
  Application.Run;
end.
