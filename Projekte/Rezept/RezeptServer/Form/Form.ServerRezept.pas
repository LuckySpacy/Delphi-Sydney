unit Form.ServerRezept;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp,
  DB.Rezept, Rest.Rezept, DB.RezeptList, Rest.RezeptList;

type
  Tfrm_ServerRezept = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    btn_Test: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    fDBRezept: TDBRezept;
    fDBRezeptList: TDBRezeptList;
    fRestRezept: TRestRezept;
    fRestRezeptList: TRestRezeptList;
    procedure StartServer;
    procedure ConnectToMySql;
  public
  end;

var
  frm_ServerRezept: Tfrm_ServerRezept;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession, Objekt.Rezept, Datamodul.Database,
  Objekt.Global;

procedure Tfrm_ServerRezept.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure Tfrm_ServerRezept.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  fDBRezept := TDBRezept.Create(nil);
  fRestRezept := TRestRezept.Create;
  fDBRezeptList := TDBRezeptList.Create;
  fRestRezeptList := TRestRezeptList.Create;
end;


procedure Tfrm_ServerRezept.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDBRezept);
  FreeAndNil(fRestRezept);
  FreeAndNil(fDBRezeptList);
  FreeAndNil(fRestRezeptList);
end;





procedure Tfrm_ServerRezept.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure Tfrm_ServerRezept.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure Tfrm_ServerRezept.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;


procedure Tfrm_ServerRezept.ConnectToMySql;
begin
  if dm.DB_MySql.Connected then
    exit;
  dm.Host := Rezept.Ini.MySql.Host;
  dm.Port := StrToInt(Rezept.Ini.MySql.Port);
  dm.Datenbankname := Rezept.Ini.MySql.Datenbankname;
  dm.Username := Rezept.Ini.MySql.Username;
  dm.Passwort := Rezept.Ini.MySql.Passwort;
  dm.ConnectMySql;
  Global.UseMySql := true;
end;

procedure Tfrm_ServerRezept.StartServer;
begin
  if Rezept.Ini.DatenbankAllgemein.UseFirebird then
    Caption := 'UseFirebird';

  if Rezept.Ini.DatenbankAllgemein.UseMySql then
    ConnectToMySql;

  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

procedure Tfrm_ServerRezept.btn_TestClick(Sender: TObject);
begin
  fDBRezept.Trans := dm.getTrans;
  fDBRezept.Read(2);
end;


procedure Tfrm_ServerRezept.Button1Click(Sender: TObject);
var
  Stream: TMemoryStream;
begin
  //fRestRezept.ID := 2;
  //fRestRezept.Rezeptname := 'Gulasch';
  fRestRezept.FieldByName('Rezeptname').AsString := 'Gulasch';
  fRestRezept.FieldByName('Id').AsInteger := 2;
  Stream := fRestRezept.getStream;
  fRestRezept.Init;
  fRestRezept.LoadFromStream(Stream);
  caption := fRestRezept.FieldByName('Id').AsString + ' / ' + fRestRezept.FieldByName('Rezeptname').AsString;

//  caption := fRestRezept.HexString;
end;


procedure Tfrm_ServerRezept.Button2Click(Sender: TObject);
var
  i1: Integer;
//  RestRezept: TRestRezept;
  Stream: TMemoryStream;
//  lEncoding: TEncoding;
begin //
  fDBRezeptList.Trans := dm.getTrans;
  fDBRezeptList.ReadAll;
  fRestRezeptList.Clear;
  fRestRezeptList.CopyFromDBFeldList(fDBRezeptList);
  {
  for i1 := 0 to fDBRezeptList.Count -1 do
  begin
    RestRezept := fRestRezeptList.Add;
    RestRezept.FieldByName('Id').AsInteger := fDBRezeptList.Item[i1].Id;
    RestRezept.FieldByName('Rezeptname').AsString := fDBRezeptList.Item[i1].Rezeptname;
    RestRezept.FieldByName('Beschreibung').AsString := fDBRezeptList.Item[i1].Beschreibung;
    RestRezept.FieldByName('Notiz').AsString := fDBRezeptList.Item[i1].Notiz;
    RestRezept.FieldByName('RlId').AsInteger := fDBRezeptList.Item[i1].RL_ID;
  end;
  }
  Stream := fRestRezeptList.getStream;
  Stream.Position := 0;
  stream.SaveToFile('d:\Bachmann\Daten\OneDrive\Asus-PC-2018\Programmierung\Delphi\Sydney\Projekte\RezeptStream.txt');
  Stream.Position := 0;
  fRestRezeptList.Clear;
  fRestRezeptList.LoadFromStream(Stream);
  for i1 := 0 to fRestRezeptList.Count -1 do
  begin
    caption := fRestRezeptList.Item[i1].FieldByName('Rezeptname').AsString;
  end;

end;

end.
