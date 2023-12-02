unit Form.TSISnapServer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, IdHTTPWebBrokerBridge, Web.HTTPApp, FMX.Controls.Presentation;

type
  Tfrm_TSISnapServer = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ButtonOpenBrowser: TButton;
    btn_Test: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    procedure ApplicationIdle(Sender: TObject; var Done: Boolean);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_TSISnapServer: Tfrm_TSISnapServer;

implementation

{$R *.fmx}

uses
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession,
  Datamodul.Database, Objekt.TSIServer2, View.Ansicht, View.AnsichtList,
  DB.AktieList, DB.Aktie;

procedure Tfrm_TSISnapServer.ApplicationIdle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure Tfrm_TSISnapServer.btn_TestClick(Sender: TObject);
var
  //stream: TMemoryStream;
  DBAktieList : TDBAktieList;
begin
  DBAktieList   := TDBAktieList.Create;
  try
    DBAktieList.Trans := dm.IBT_TSI;
    DBAktieList.ReadAll;
    Caption := IntToStr(DBAktieList.Count);
  finally
    FreeAndNil(DBAktieList);
  end;
end;

procedure Tfrm_TSISnapServer.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure Tfrm_TSISnapServer.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure Tfrm_TSISnapServer.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure Tfrm_TSISnapServer.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  Application.OnIdle := ApplicationIdle;
end;

procedure Tfrm_TSISnapServer.FormShow(Sender: TObject);
var
  s: string;
begin
  dm.TSIConnectData.Host := TSIServer2.Ini.TSI.Host;
  dm.TSIConnectData.Datenbankname := TSIServer2.Ini.TSI.Datenbankname;
  dm.TSIConnectData.Datenbankpfad := TSIServer2.Ini.TSI.Datenbankpfad;

  dm.KurseConnectData.Host := TSIServer2.Ini.Kurse.Host;
  dm.KurseConnectData.Datenbankname := TSIServer2.Ini.Kurse.Datenbankname;
  dm.KurseConnectData.Datenbankpfad := TSIServer2.Ini.Kurse.Datenbankpfad;

  s := 'Host: ' + dm.TSIConnectData.Host + sLineBreak +
       'Datenbankname: ' + dm.TSIConnectData.Datenbankname + sLineBreak +
       'Datanbankpfad: ' + dm.TSIConnectData.Datenbankpfad;
  ShowMessage(s);

  if dm.ConnectTSI then
  begin
    TSIServer2.IBT_TSI := dm.IBT_TSI;
  end;
  if dm.ConnectKurse then
    TSIServer2.IBT_Kurse := dm.IBT_Kurse;
end;

procedure Tfrm_TSISnapServer.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

end.
