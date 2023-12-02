program MySqlBackup;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.SvcMgr,
  Dienst.MySqlBackup in 'Dienst.MySqlBackup.pas' {tbMySqlBackup: TService},
  Objekt.Allgemein in '..\Backup\Objekt\Objekt.Allgemein.pas',
  Objekt.MySqlBackup in '..\Backup\Objekt\Objekt.MySqlBackup.pas',
  Objekt.MySqlBackupChecker in 'Objekt\Objekt.MySqlBackupChecker.pas';

{$R *.RES}

begin
  // Für Windows 2003 Server muss StartServiceCtrlDispatcher vor
  // CoRegisterClassObject aufgerufen werden, das indirekt von
  // Application.Initialize aufgerufen werden kann. TServiceApplication.DelayInitialize
  // ermöglicht, dass Application.Initialize von TService.Main (nach
  // StartServiceCtrlDispatcher) aufgerufen werden kann.
  //
  // Eine verzögerte Initialisierung des Application-Objekts kann sich auf
  // Ereignisse auswirken, die dann vor der Initialisierung ausgelöst werden,
  // wie z.B. TService.OnCreate. Dies wird nur empfohlen, wenn ServiceApplication
  // ein Klassenobjekt bei OLE registriert und für die Verwendung mit
  // Windows 2003 Server vorgesehen ist.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TtbMySqlBackup, tbMySqlBackup);
  Application.Run;
end.
