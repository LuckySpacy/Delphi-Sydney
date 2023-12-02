unit Dienst.MyFileSaver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Objekt.OptionList, Objekt.Option;

type
  TtbMyFileSaver = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private-Deklarationen }
  public
    function GetServiceController: TServiceController; override;
    { Public-Deklarationen }
  end;

var
  tbMyFileSaver: TtbMyFileSaver;

implementation

{$R *.dfm}

uses
  Objekt.Allgemein, Objekt.MyFileServer;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  tbMyFileSaver.Controller(CtrlCode);
end;

function TtbMyFileSaver.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TtbMyFileSaver.ServiceCreate(Sender: TObject);
begin
  AllgemeinObj := TAllgemeinObj.create;
  MyFileServer := TMyFileServer.Create;
  AllgemeinObj.Log.DienstInfo('ServiceCreate');
  AllgemeinObj.Log.DienstInfo('Version 1.0.0 vom 21.02.2021 10:30');
end;

procedure TtbMyFileSaver.ServiceDestroy(Sender: TObject);
begin
  FreeAndNil(AllgemeinObj);
  FreeAndNil(MyFileServer);
end;

procedure TtbMyFileSaver.ServiceExecute(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('Dienst läuft');
//  if fbackupchecker = nil then
//    AllgemeinObj.Log.DienstInfo('Backupchecker = nil');

//  fBackupchecker.TimerEnabled := true;

  MyFileServer.TimerEnabled := true;
  while not Terminated do
  begin
    sleep(100);
    ServiceThread.ProcessRequests(false);
  end;
//  fBackupchecker.TimerEnabled := false;

  MyFileServer.TimerEnabled := false;
  AllgemeinObj.Log.DienstInfo('Dienst ist beendet');
end;

procedure TtbMyFileSaver.ServicePause(Sender: TService; var Paused: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('ServicePause');
end;

procedure TtbMyFileSaver.ServiceShutdown(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('Shutdown');
end;

procedure TtbMyFileSaver.ServiceStart(Sender: TService; var Started: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('Start');
end;

procedure TtbMyFileSaver.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('Stop');
end;

end.
