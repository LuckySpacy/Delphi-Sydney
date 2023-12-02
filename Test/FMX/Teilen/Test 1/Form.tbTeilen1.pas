unit Form.tbTeilen1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Permissions;

const
  cPermissionReadExternalStorage = 'android.permission.READ_EXTERNAL_STORAGE';
  cPermissionWriteExternalStorage = 'android.permission.WRITE_EXTERNAL_STORAGE';

type
  {$IF CompilerVersion < 35}
  TPermissionArray = TArray<string>;
  TPermissionStatusArray = TArray<TPermissionStatus>;
  {$ELSE}
  TPermissionArray = TClassicStringDynArray;
  TPermissionStatusArray = TClassicPermissionStatusDynArray;
  {$ENDIF}


type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure CreateEmail2(const Recipient, Subject, Content, Attachment: string);
    procedure CreateEmail(const Recipient, Subject, Content, Attachment: string);
    procedure SaveCSVFile;
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses
  Androidapi.JNI.JavaTypes, Androidapi.JNI.GraphicsContentViewText, Androidapi.Helpers, FMX.Platform.Android,
  Androidapi.JNIBridge,
  Androidapi.JNI.Net,
  Androidapi.JNI.Java.Net,
  Androidapi.JNI.Java.Security,
  Androidapi.JNI.Os,
  Androidapi.jni.app,
  System.IOUtils,
  DW.Consts.Android, DW.Permissions.Helpers;



procedure TForm2.Button1Click(Sender: TObject);
begin
  PermissionsService.RequestPermissions([cPermissionReadExternalStorage, cPermissionWriteExternalStorage],
  procedure(const APermissions: TPermissionArray; const AGrantResults: TPermissionStatusArray)
  begin
    if AGrantResults.AreAllGranted then
    begin
      SaveCSVFile;
      CreateEmail('bachmann@ass-systemhaus.de', 'Betreff', 'Inhalt', 'Test2.csv');
    end;
  end
  );
end;

procedure TForm2.CreateEmail(const Recipient, Subject, Content, Attachment: string);
var
 Intent: JIntent;
 Uri: Jnet_Uri;
 AttachmentFile: JFile;
begin
 Intent := TJIntent.Create;
 Intent.setAction(TJIntent.JavaClass.ACTION_SEND);
 Intent.setFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NEW_TASK);
 Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, StringToJString(Recipient));
 Intent.putExtra(TJIntent.JavaClass.EXTRA_SUBJECT, StringToJString(Subject));
 Intent.putExtra(TJIntent.JavaClass.EXTRA_TEXT, StringToJString(Content));
 //intent.addFlags(FLAG_GRANT_READ_URI_PERMISSION);
 //intent.

 //intent.addFlags(FLAG_GRANT_READ_URI_PERMISSION);
 AttachmentFile := TAndroidhelper.activity.getExternalFilesDir (StringToJString(Attachment));

 Uri := TJnet_Uri.JavaClass.fromFile(AttachmentFile);

 Intent.putExtra(TJIntent.JavaClass.EXTRA_STREAM,
   TJParcelable.Wrap((Uri as ILocalObject).GetObjectID));

 Intent.setType(StringToJString('vnd.android.cursor.dir/email'));

 TAndroidhelper.activity.startActivity(Intent);
end;


procedure TForm2.CreateEmail2(const Recipient, Subject, Content, Attachment: string);
var
 Intent: JIntent;
 Uri: Jnet_Uri;
 AttachmentFile: JFile;
begin
 Intent := TJIntent.Create;
 Intent.setAction(TJIntent.JavaClass.ACTION_SEND);
 Intent.setFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NEW_TASK);
 Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, StringToJString(Recipient));
 Intent.putExtra(TJIntent.JavaClass.EXTRA_SUBJECT, StringToJString(Subject));
 Intent.putExtra(TJIntent.JavaClass.EXTRA_TEXT, StringToJString(Content));
 flag_
// intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
 AttachmentFile := TAndroidhelper.activity.getExternalFilesDir(StringToJString(Attachment));

 Uri := TJnet_Uri.JavaClass.fromFile(AttachmentFile);

 Intent.putExtra(TJIntent.JavaClass.EXTRA_STREAM,
   TJParcelable.Wrap((Uri as ILocalObject).GetObjectID));

 Intent.setType(StringToJString('vnd.android.cursor.dir/email'));

 TAndroidhelper.activity.startActivity(Intent);
end;

procedure TForm2.SaveCSVFile;
var
  List: TStringList;
  Pfad : string;
  Filename: string;
begin
  //Pfad := TPath.GetPublicPath;
  Pfad := TPath.GetSharedDocumentsPath;
  Filename := TPath.Combine(Pfad, 'Test2.csv');
  ShowMessage(Filename);
  List := TStringList.Create;
  try
    List.Add('Thomas;Bachmann');
    List.SaveToFile(Filename);
  finally
    FreeAndNil(List);
  end;

end;

end.
