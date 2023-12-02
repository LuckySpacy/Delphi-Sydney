unit Form.RezeptServer;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp,
  Datasnap.DSServer;

type
  Tfrm_RezeptServer = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    Label1: TLabel;
    EditPort: TEdit;
    ButtonOpenBrowser: TButton;
    ApplicationEvents1: TApplicationEvents;
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    //FServer: TIdHTTPWebBrokerBridge;
    FServer: TDSServer;
    procedure StartServer;
  public
  end;

var
  frm_RezeptServer: Tfrm_RezeptServer;

implementation

{$R *.dfm}

uses
  Winapi.ShellApi, Datasnap.DSSession, ServerContainerRezept;


procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure Tfrm_RezeptServer.FormCreate(Sender: TObject);
begin
  //FServer := TIdHTTPWebBrokerBridge.Create(Self);
  FServer := ContainerRezept.DSServer1;
end;


procedure Tfrm_RezeptServer.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Started;
  ButtonStop.Enabled  := FServer.Started;
  EditPort.Enabled    := not FServer.Started;
  {
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
  }
end;

procedure Tfrm_RezeptServer.ButtonStartClick(Sender: TObject);
begin
   StartServer;
end;

procedure Tfrm_RezeptServer.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Stop;
  {
  FServer.Active := False;
  FServer.Bindings.Clear;
  }
end;


procedure Tfrm_RezeptServer.StartServer;
begin
  if not FServer.Started then
  begin
    ContainerRezept.Port := StrToInt(EditPort.Text);
    FServer.Start;
  end;

  {
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
  }
end;

end.

