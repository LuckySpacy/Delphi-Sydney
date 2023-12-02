program HarddriveCloneUI;

uses
  Vcl.Forms,
  Form.HarddriveClone in 'Form\Form.HarddriveClone.pas' {frm_HarddriveClone},
  Form.Job in 'Form\Form.Job.pas' {frm_Job},
  Form.JobDetail in 'Form\Form.JobDetail.pas' {frm_JobDetail},
  Form.JobView in 'Form\Form.JobView.pas' {frm_JobView},
  Form.QuellZiel in 'Form\Form.QuellZiel.pas' {frm_QuellZiel},
  Objekt.HarddriveClone in 'Objekt\Objekt.HarddriveClone.pas',
  Objekt.Logger in 'Objekt\Objekt.Logger.pas',
  sys.Objekt in 'sys\sys.Objekt.pas',
  sys.Disk in 'sys\sys.Disk.pas',
  sys.Folderlocation in 'sys\sys.Folderlocation.pas',
  Types.Folder in 'Types\Types.Folder.pas',
  Objekt.Job in 'Objekt\Objekt.Job.pas',
  Objekt.JobList in 'Objekt\Objekt.JobList.pas',
  Objekt.ObjektList in 'Objekt\Objekt.ObjektList.pas',
  Objekt.Basislist in 'Objekt\Objekt.Basislist.pas',
  Objekt.JobViewList in 'Objekt\Objekt.JobViewList.pas',
  Objekt.Datei in 'Objekt\Objekt.Datei.pas',
  Objekt.DateiList in 'Objekt\Objekt.DateiList.pas',
  Objekt.DateiSync in 'Objekt\Objekt.DateiSync.pas',
  Objekt.DateiSyncList in 'Objekt\Objekt.DateiSyncList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_HarddriveClone, frm_HarddriveClone);
  Application.Run;
end.
