unit fntConnectIB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, Vcl.StdCtrls;

type
  TfrmConnectIB = class(TForm)
    Label5: TLabel;
    cbx_DBName: TComboBox;
    cmdNew: TButton;
    Label2: TLabel;
    cbb_Laufwerk: TComboBox;
    Label1: TLabel;
    edt_Server: TEdit;
    Label3: TLabel;
    edt_Verzeichnis: TEdit;
    Label4: TLabel;
    edt_Datenbank: TEdit;
    cmd_Cancel: TAdvGlowButton;
    cmd_Ok: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbx_DBNameChange(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmd_CancelClick(Sender: TObject);
    procedure cmd_OkClick(Sender: TObject);
  private
    FIniFile: String;
    FPath: string;
    FOk  : Boolean;
    FDBListName: string;
    FDBList: TStringList;
    procedure ShowNewConnectIB;
    procedure LoadINI;
  public
    class function ShowConnect(AOwner: TComponent): Boolean;
  end;

var
  frmConnectIB: TfrmConnectIB;

implementation

{$R *.dfm}

uses
  nf_System, nf_RegIni, DataModul, fntNewConnectIB;

{ TfrmConnectIB }



procedure TfrmConnectIB.FormCreate(Sender: TObject);
begin
  edt_Server.Text      := '';
  edt_Verzeichnis.Text := '';
  FOk      := false;
  FPath    := IncludeTrailingPathDelimiter(nf_GetShellFolder(26)) + 'SqlEditor\';
  FIniFile := FPath + 'SqlEditor.ini';
  FDBListName := FPath + 'DatabaseList.txt';
  FDBList  := TStringList.Create;
  FDBList.Duplicates := dupIgnore;
  FDBList.Sorted     := true;
  FDBList.LoadFromFile(FDBListName);
  cbx_DBName.Items.AddStrings(FDBList);
  if cbx_DBName.Items.Count > 0 then
    cbx_DBName.ItemIndex := 0;
end;

procedure TfrmConnectIB.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDBList);
end;

procedure TfrmConnectIB.FormShow(Sender: TObject);
begin
  DM.IBDatabase.Connected := false;
  edt_Server.Text        := nf_ReadIni(FIniFile, 'DatabaseIB', 'Server', '');
  cbb_Laufwerk.ItemIndex := nf_ReadIniToInt(FIniFile, 'DatabaseIB', 'Laufwerk', '-1');
  edt_Verzeichnis.Text   := nf_ReadIni(FIniFile, 'DatabaseIB', 'Verzeichnis', '');
  edt_Datenbank.Text     := nf_ReadIni(FIniFile, 'DatabaseIB', 'Datenbankname', '');
end;

procedure TfrmConnectIB.cbx_DBNameChange(Sender: TObject);
begin
  LoadIni;
end;

procedure TfrmConnectIB.cmdNewClick(Sender: TObject);
begin
  ShowNewConnectIB;
end;

procedure TfrmConnectIB.cmd_CancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConnectIB.cmd_OkClick(Sender: TObject);
var
  Laufwerk: string;
begin
  if cbb_Laufwerk.ItemIndex = -1 then
  begin
    ShowMessage('Bitte den Laufwerksbuchstaben auswählen');
    exit;
  end;
  Laufwerk := cbb_Laufwerk.Items[cbb_Laufwerk.ItemIndex];
  dm.IBDatabase.Connected := false;
  DM.IBDatabase.DatabaseName := edt_Server.Text + ':' + Laufwerk + '\' + edt_Verzeichnis.Text + '\' + edt_Datenbank.Text;
  if not DM.ConnectIB then
    exit;
  FOk := true;
  if cbx_DBName.ItemIndex < 0 then
    exit;
  nf_WriteIni(FIniFile, cbx_DBName.Text, 'Server', edt_Server.Text);
  nf_WriteIni(FIniFile, cbx_DBName.Text, 'Laufwerk', IntToStr(cbb_Laufwerk.ItemIndex));
  nf_WriteIni(FIniFile, cbx_DBName.Text, 'Verzeichnis', edt_Verzeichnis.Text);
  nf_WriteIni(FIniFile, cbx_DBName.Text, 'Datenbankname', edt_Datenbank.Text);
  nf_WriteIni(FIniFile, 'LastConnection', 'Tablename', cbx_DBName.Text);
  close;
end;

procedure TfrmConnectIB.LoadINI;
begin
  if cbx_DBName.ItemIndex < 0 then
    exit;
  edt_Server.Text        := nf_ReadIni(FIniFile, cbx_DBName.Text, 'Server', '');
  cbb_Laufwerk.ItemIndex := nf_ReadIniToInt(FIniFile, cbx_DBName.Text, 'Laufwerk', '-1');
  edt_Verzeichnis.Text   := nf_ReadIni(FIniFile, cbx_DBName.Text, 'Verzeichnis', '');
  edt_Datenbank.Text     := nf_ReadIni(FIniFile, cbx_DBName.Text, 'Datenbankname', '');
end;

class function TfrmConnectIB.ShowConnect(AOwner: TComponent): Boolean;
var
  Form: TfrmConnectIB;
begin
  Form := TfrmConnectIB.Create(AOwner);
  try
    Form.ShowModal;
    Result := Form.FOk;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TfrmConnectIB.ShowNewConnectIB;
var
  Form: TfrmNewConnectIB;
begin
  Form := TfrmNewConnectIB.Create(Self);
  try
    Form.ShowModal;
    FDBList.LoadFromFile(FDBListName);
    cbx_DBName.Clear;
    cbx_DBName.Items.AddStrings(FDBList);
  finally
    FreeAndNil(Form);
  end;
end;

end.
