unit Form.Test1Path;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Permissions,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  Tfrm_Test1Path = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FPermissionReadExternalStorage: string;
    FPermissionWriteExternalStorage: string;
    procedure DisplayRationale(Sender: TObject; const APermissions: TArray<string>; const APostRationaleProc: TProc);
    procedure ReadStoragePermissionRequestResult(Sender: TObject; const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>);
  public
  end;

var
  frm_Test1Path: Tfrm_Test1Path;

implementation

{$R *.fmx}

uses
  fmx.DialogService, System.IOUtils, Androidapi.Helpers, Androidapi.jni.os, fmx.Platform.Android
  {, Androidapi.IOUtilsEx};

{ Tfrm_Test1Path }


procedure Tfrm_Test1Path.DisplayRationale(Sender: TObject;
  const APermissions: TArray<string>; const APostRationaleProc: TProc);
begin
  // Show an explanation to the user *asynchronously* - don't block this thread waiting for the user's response!
  // After the user sees the explanation, invoke the post-rationale routine to request the permissions
  TDialogService.ShowMessage('The app needs to read files from your device storage to show you the songs and albums available to you',
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end);
end;

procedure Tfrm_Test1Path.FormCreate(Sender: TObject);
begin
{$IFDEF ANDROID}
  FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  PermissionsService.RequestPermissions([FPermissionReadExternalStorage], ReadStoragePermissionRequestResult, DisplayRationale);
  FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
  PermissionsService.RequestPermissions([FPermissionWriteExternalStorage], ReadStoragePermissionRequestResult, DisplayRationale);
{$ENDIF}
end;

procedure Tfrm_Test1Path.ReadStoragePermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 1 permission involved: READ_EXTERNAL_STORAGE
  {
  if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
    QuerySongs
  else
    TDialogService.ShowMessage('Cannot list out the song files because the required permission is not granted');
    }
end;


procedure Tfrm_Test1Path.Button1Click(Sender: TObject);
var
  List: TStringList;
  Filename: string;
  Dokumentpfad: string;
  Musikpfad: string;
  SharedMusikpfad: string;
begin
  Dokumentpfad    := TPath.GetDocumentsPath + System.SysUtils.PathDelim;
  Musikpfad       := TPath.GetMusicPath + System.SysUtils.PathDelim;
  SharedMusikpfad := TPath.GetSharedMusicPath + System.SysUtils.PathDelim;
  Label1.Text := Dokumentpfad;
  Label2.Text := TPath.GetMusicPath;
  Label3.Text := TPath.GetSharedMusicPath;
  List := TStringList.Create;
  try
    SaveState.StoragePath := Dokumentpfad;
    Filename := 'Dokumentpfad.txt';
    List.Text := 'Test';
    //List.SaveToFile(Dokumentpfad + Filename);
    SaveState.StoragePath := Musikpfad;
    Filename := 'Musikpfad.txt';
    //List.SaveToFile(Musikpfad + Filename);
    Filename := 'SharedMusikpfad.txt';

    SaveState.StoragePath := SharedMusikpfad;
    //List.SaveToFile(SharedMusikpfad + Filename);
  finally
    FreeAndNil(List);
  end;
  //ListBox1.Items.Add(TPath.GetDocumentsPath);
  //ListBox1.Items.Add(TPath.GetMusicPath);
  //ListBox1.Items.Add(TPath.GetSharedMusicPath);
end;


end.
