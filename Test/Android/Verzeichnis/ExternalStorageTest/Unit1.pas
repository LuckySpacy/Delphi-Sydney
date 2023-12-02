unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls,
  uSupport, System.IOUtils, Androidapi.JNI.JavaTypes, Androidapi.Helpers, System.Permissions,
  Androidapi.JNI,
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Os,
  AndroidApi.Log,
  Androidapi.os.Environment,
  FMX.Helpers.Android;

type
  TForm1 = class(TForm)
    btnInternal: TButton;
    btnExternal: TButton;
    Label1: TLabel;
    procedure btnInternalClick(Sender: TObject);
    procedure btnExternalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPermissionReadExternalStorage: string;
    FPermissionWriteExternalStorage: string;
    procedure DisplayRationale(Sender: TObject; const APermissions: TArray<string>; const APostRationaleProc: TProc);
    procedure ReadStoragePermissionRequestResult(Sender: TObject; const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>);
    procedure TryCreateDir(APath: String);
    procedure TryCreateFile(APath: String);
    procedure TryCreateJavaFile(APath: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  fmx.DialogService,  fmx.Platform.Android, Androidapi.IOUtilsEx;

procedure TForm1.btnExternalClick(Sender: TObject);
var
  path: String;
  dirList: TStringDynArray;
  i1: Integer;
begin
  if TJEnvironment.JavaClass.isExternalStorageEmulated then
    path := JStringToString(TJEnvironment.JavaClass.getExternalStorageDirectory.getAbsolutePath);
  //exit;

  dirList:= System.IOUtils.TDirectory.GetDirectories('/');
  //Label1.Text := System.IOUtils.TPath.GetCameraPath;
  //exit;

//  dirList:=TDirectory.GetDirectories('/storage', TSearchOption.soTopDirectoryOnly, nil);
  for i1 := 0 to length(dirList) -1 do
    Label1.Text := dirlist[i1];



  Label1.Text := JStringToString(TJEnvironment.JavaClass.MEDIA_SHARED);
  exit;
  //path := uSupport.CreateFilesDirExternal;
  TryCreateDir('/storage/9C33-6BBD');
  exit;
  TryCreateDir(path);
  TryCreateFile(path);
  TryCreateJavaFile(path);
end;

procedure TForm1.btnInternalClick(Sender: TObject);
var
  path: String;
begin
  path := uSupport.CreateFilesDirInternal;
  Label1.Text := Path;
  TryCreateDir(path);
  TryCreateFile(path);
  TryCreateJavaFile(path);
end;

procedure TForm1.DisplayRationale(Sender: TObject;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
{$IFDEF ANDROID}
  FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  PermissionsService.RequestPermissions([FPermissionReadExternalStorage], ReadStoragePermissionRequestResult, DisplayRationale);
  FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
  PermissionsService.RequestPermissions([FPermissionWriteExternalStorage], ReadStoragePermissionRequestResult, DisplayRationale);
{$ENDIF}
end;

procedure TForm1.ReadStoragePermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin

end;

procedure TForm1.TryCreateDir(APath: String);
var
  s: String;
begin
  s := APath + '/bla';
  TDirectory.CreateDirectory(s);
  if TDirectory.Exists(s) then
    ShowMessage('OK')
  else
    ShowMessage(s + ' konnte nicht erstellt werden!');
end;

procedure TForm1.TryCreateFile(APath: String);
var
  s: String;
  sr: TStreamWriter;
begin
  s := APath + '/test.txt';
  sr := TFile.CreateText(s);
  sr.Write('Bla');
  sr.Close;
  sr.Free;
end;

procedure TForm1.TryCreateJavaFile(APath: String);
var
  jf: JFile;
  s: String;
begin
  s := APath + '/testjava.txt';
  jf := TJFile.JavaClass.init(StringToJString(s));
  if jf.createNewFile then
    ShowMessage('OK')
  else
    ShowMessage(s + ' konnte nicht erstellt werden!');
end;

end.
