program MyFileSaver;

uses
  Vcl.SvcMgr,
  Dienst.MyFileSaver in 'Dienst.MyFileSaver.pas' {tbMyFileSaver: TService},
  Objekt.Allgemein in '..\Objekt\Objekt.Allgemein.pas',
  Objekt.MyFileServer in '..\Objekt\Objekt.MyFileServer.pas',
  Objekt.Dateisystem in '..\..\Allgemein\Objekt\Objekt.Dateisystem.pas';

{$R *.RES}

begin
  // F�r Windows 2003 Server muss StartServiceCtrlDispatcher vor
  // CoRegisterClassObject aufgerufen werden, das indirekt von
  // Application.Initialize aufgerufen werden kann. TServiceApplication.DelayInitialize
  // erm�glicht, dass Application.Initialize von TService.Main (nach
  // StartServiceCtrlDispatcher) aufgerufen werden kann.
  //
  // Eine verz�gerte Initialisierung des Application-Objekts kann sich auf
  // Ereignisse auswirken, die dann vor der Initialisierung ausgel�st werden,
  // wie z.B. TService.OnCreate. Dies wird nur empfohlen, wenn ServiceApplication
  // ein Klassenobjekt bei OLE registriert und f�r die Verwendung mit
  // Windows 2003 Server vorgesehen ist.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TtbMyFileSaver, tbMyFileSaver);
  Application.Run;
end.
