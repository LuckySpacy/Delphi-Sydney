unit Form.Test1Musikplayer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    fMusikpfad: string;
    fMusikdatei: string;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses
  fmx.DialogService, Androidapi.IOUtilsex, Androidapi.jni.envintf, Androidapi.Helpers,
  Androidapi.JNI.JavaTypes;


procedure TForm2.FormCreate(Sender: TObject);
begin
  //fMusikpfad := GetHomePath + PathDelim + 'Music';
  exit;
  fMusikpfad := '/Interner Speicher';
  Label1.Text := fMusikpfad;
  if DirectoryExists(fMusikpfad) then
    TDialogService.ShowMessage('Hurra1')
  else
    TDialogService.ShowMessage('Schade1');

  fMusikpfad := '/sdcard0';
  Label1.Text := fMusikpfad;
  if DirectoryExists(fMusikpfad) then
    TDialogService.ShowMessage('Hurra2')
  else
    TDialogService.ShowMessage('Schade2');

end;

procedure TForm2.Button1Click(Sender: TObject);
var
  EmulStorage: JFile;
begin
//  Label1.Text := GetExternalSDCardDirectory;
   EmulStorage := TJEnvironment.JavaClass.getExternalStorageDirectory;
   fMusikpfad := JStringToString(EmulStorage.getPath) + '/Test1234';
   {
   fMusikdatei := fMusikpfad + PathDelim + 'Aloah.mp3';
   if FileExists(fMusikdatei) then
    TDialogService.ShowMessage('Hurra')
   else
    TDialogService.ShowMessage('Schade123');
   }

  if DirectoryExists(fMusikpfad) then
    TDialogService.ShowMessage('Hurra')
  else
    TDialogService.ShowMessage('Schade');


end;


end.
