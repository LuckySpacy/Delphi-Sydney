unit Dienst.MySqlBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Objekt.MySqlBackupChecker;

type
  TtbMySqlBackup = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    fBackupChecker: TBackupchecker;
  public
    function GetServiceController: TServiceController; override;
    { Public-Deklarationen }
  end;

var
  tbMySqlBackup: TtbMySqlBackup;

implementation

{$R *.dfm}

uses
  Objekt.Allgemein, Objekt.MySqlBackup;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  tbMySqlBackup.Controller(CtrlCode);
end;

function TtbMySqlBackup.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TtbMySqlBackup.ServiceCreate(Sender: TObject);
begin
  AllgemeinObj := TAllgemeinObj.create;
  AllgemeinObj.Log.DienstInfo('ServiceCreate');
  AllgemeinObj.Log.DienstInfo('Version 1.0.0 vom 31.01.2021 10:30');
  MySqlBackup := TMySqlBackup.Create;
  fBackupChecker := TBackupchecker.Create;
  //fBackupChecker.Handle := ServiceThread.Handle;
end;

procedure TtbMySqlBackup.ServiceDestroy(Sender: TObject);
begin
  FreeAndNil(AllgemeinObj);
  FreeAndNil(MySqlBackup);
  FreeAndNil(fBackupChecker);
end;

procedure TtbMySqlBackup.ServiceExecute(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('Dienst läuft');
  if fbackupchecker = nil then
    AllgemeinObj.Log.DienstInfo('Backupchecker = nil');

  fBackupchecker.TimerEnabled := true;

  while not Terminated do
  begin
    sleep(100);
    ServiceThread.ProcessRequests(false);
  end;
  fBackupchecker.TimerEnabled := false;

  AllgemeinObj.Log.DienstInfo('Dienst ist beendet');

end;

procedure TtbMySqlBackup.ServicePause(Sender: TService; var Paused: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('ServicePause');
end;

procedure TtbMySqlBackup.ServiceShutdown(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('Shutdown');
end;

procedure TtbMySqlBackup.ServiceStart(Sender: TService; var Started: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('Start');
end;

procedure TtbMySqlBackup.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('Stop');
end;

end.
