unit fntNewConnectIB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmNewConnectIB = class(TForm)
    lbl_Name: TLabel;
    edt_DBName: TEdit;
    Label2: TLabel;
    cbb_Laufwerk: TComboBox;
    Label1: TLabel;
    edt_Server: TEdit;
    Label3: TLabel;
    edt_Verzeichnis: TEdit;
    Label4: TLabel;
    edt_Datenbank: TEdit;
    cmd_Cancel: TButton;
    cmd_Save: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmd_CancelClick(Sender: TObject);
    procedure cmd_SaveClick(Sender: TObject);
  private
    FPath: string;
    FDBListName: string;
    FDBList: TStringList;
  public
  end;

var
  frmNewConnectIB: TfrmNewConnectIB;

implementation

{$R *.dfm}

uses
  nf_System, nf_RegIni, DataModul;



procedure TfrmNewConnectIB.FormCreate(Sender: TObject);
begin
  FPath       := IncludeTrailingPathDelimiter(nf_GetShellFolder(26)) + 'SqlEditor\';
  FDBListName := FPath + 'DatabaseList.txt';
  FDBList     := TStringList.Create;
  FDBList.LoadFromFile(FDBListName);
end;

procedure TfrmNewConnectIB.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDBList);
end;


procedure TfrmNewConnectIB.cmd_CancelClick(Sender: TObject);
begin
  close;
end;


procedure TfrmNewConnectIB.cmd_SaveClick(Sender: TObject);
begin
  FDBList.Add(edt_DBName.Text);
  FDBList.SaveToFile(FDBListName);
  close;
end;



end.
