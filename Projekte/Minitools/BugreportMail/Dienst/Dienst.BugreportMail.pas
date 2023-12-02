unit Dienst.BugreportMail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Objekt.DateiCheck;

type
  TASSBugreportMail = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    fDateiCheck: TDateiCheck;
  public
    function GetServiceController: TServiceController; override;
    { Public-Deklarationen }
  end;

var
  ASSBugreportMail: TASSBugreportMail;

implementation

{$R *.dfm}

uses
  Objekt.Allgemein, Objekt.BugreportMail;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ASSBugreportMail.Controller(CtrlCode);
end;

function TASSBugreportMail.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TASSBugreportMail.ServiceCreate(Sender: TObject);
begin
  AllgemeinObj := TAllgemeinObj.create;
  AllgemeinObj.Log.DienstInfo('ServiceCreate');
  AllgemeinObj.Log.DienstInfo('Version 1.0.0 vom 01.02.2021 10:30');
  BugreportMail := TBugreportMail.Create;
  fDateiCheck := TDateiCheck.Create;
end;

procedure TASSBugreportMail.ServiceDestroy(Sender: TObject);
begin
  FreeAndNil(AllgemeinObj);
  FreeAndNil(BugreportMail);
  FreeAndNil(fDateiCheck);
end;

procedure TASSBugreportMail.ServiceExecute(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('Dienst läuft');
  fDateiCheck.TimerEnabled := true;
  while not Terminated do
  begin
    sleep(100);
    ServiceThread.ProcessRequests(false);
  end;
  fDateiCheck.TimerEnabled := false;
  AllgemeinObj.Log.DienstInfo('Dienst ist beendet');
end;

procedure TASSBugreportMail.ServicePause(Sender: TService; var Paused: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('ServicePause');
end;

procedure TASSBugreportMail.ServiceShutdown(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('Shutdown');
end;

procedure TASSBugreportMail.ServiceStart(Sender: TService; var Started: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('ServiceStart');
end;

procedure TASSBugreportMail.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('ServiceStop');
end;

end.
