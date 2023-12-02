unit uSupport;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Controls, FMX.Graphics, FMX.Objects, FMX.Types,
  IdComponent, FMX.Platform, FMX.VirtualKeyboard, FMX.Dialogs,
{$IFDEF ANDROID}
  Androidapi.JNI.JavaTypes
{$ENDIF}
  ;

{$IFDEF ANDROID}
function CreateFilesDirExternal: string;
function CreateFilesDirInternal: string;
function GetDefaultStoragePathAsString: String;
function GetExternalStoragePath: JFile;
{$ENDIF}

implementation

uses
  System.IOUtils, StrUtils,
{$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI,
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Os,
  AndroidApi.Log,
  Androidapi.os.Environment,
  FMX.Helpers.Android,
{$ENDIF}
{$IFDEF IOS}
  iOSapi.Foundation,
  Macapi.CoreFoundation,
  Macapi.Helpers,
  Macapi.ObjectiveC,
{$ENDIF}
{$IFDEF MSWINDOWS}
  Windows, psApi, ShlObj
{$ELSE}
  Posix.Unistd
{$ENDIF}
;

{$IFDEF ANDROID}
function GetSdCardPath: JFile;
var
  i, nSDK_Level: Integer;
  jfMntPath: JFile;
  jfList: TJavaObjectArray<JFile>;
  sMediaMounted, sPathStorageState: string;
begin
  Result := nil;
  // SD-Card hat unterschiedliche Namen: "/mnt/external" "/mnt/external_sd", "/mnt/extSdCard", "/mnt/sdcard/ext_sd" u.a.
//  jfMntPath := TJFile.JavaClass.init( StringToJString( '/mnt' ) );
  // "/storage" Pfad enthält noch emulated Pfad, "/mnt" - nur mounted Pfade. But Sony Z1 has SD-Card in "/mnt" with "unknown" State!
  jfMntPath := TJFile.JavaClass.init( StringToJString( '/storage' ) );
  if jfMntPath.isDirectory and jfMntPath.exists then
  begin
    nSDK_Level := 20;
    //nSDK_Level := TJBuild_VERSION.JavaClass.SDK_INT;
    if nSDK_Level >= 19 then begin
      sMediaMounted := JStringToString( TJEnvironment.JavaClass.MEDIA_MOUNTED );
      jfList := jfMntPath.listFiles;
      if jfList <> nil then
      begin
        for i := 0 to jfList.Length-1 do begin
        // getStorageState is added in API level 19; deprecated in API level 21, which introduces getExternalStorageState(File). Delphi interface does not supports this method with parameter.
          sPathStorageState := JStringToString( TJEnvironment.JavaClass.getStorageState( jfList.Items[i] ) );
          if SameText( sPathStorageState, sMediaMounted ) then begin
            Result := jfList.Items[i];
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function GetDefaultStoragePathAsString: String;
var
  jfPath: JFile;
begin
  jfPath := GetExternalStoragePath;
  if Assigned(jfPath) then
    result := JStringToString(jfPath.toString)
  else
    result := '/';
end;

function GetExternalStoragePath: JFile;
begin
  // if the primary "external" storage device is emulated in internal storage system
  if TJEnvironment.JavaClass.isExternalStorageEmulated then
    result := GetSdCardPath
  else
    result := TJEnvironment.JavaClass.getExternalStorageDirectory; // the primary "external" storage directory is not always SD-Card !
end;

function CreateFilesDirExternal: string;
var
  jfPath: JFile;
  s, sMountedSdRootDir, sExtEmulatedStorageRootDir: string;
begin
  Result := '';
  sExtEmulatedStorageRootDir := '';
  jfPath := GetExternalStoragePath;
  if Assigned( jfPath ) then
  begin
    if TJEnvironment.JavaClass.isExternalStorageEmulated then
      sExtEmulatedStorageRootDir := JStringToString(TJEnvironment.JavaClass.getExternalStorageDirectory.getAbsolutePath);
    sMountedSdRootDir := JStringToString( jfPath.getAbsolutePath );
    if sExtEmulatedStorageRootDir <> '' then
    begin
      s := JStringToString( TAndroidHelper.Activity.getExternalFilesDir(nil).getAbsolutePath );
      Result := ReplaceText( s, sExtEmulatedStorageRootDir, sMountedSdRootDir );
    end
    else
      Result := JStringToString( TAndroidHelper.Activity.getExternalFilesDir(nil).getAbsolutePath );

    if not TDirectory.Exists( Result ) then
      TDirectory.CreateDirectory( Result );
  end;
end;

function CreateFilesDirInternal: string;
begin
  Result := JStringToString( TAndroidHelper.Activity.getFilesDir.getAbsolutePath );
  if not TDirectory.Exists( Result ) then
    TDirectory.CreateDirectory( Result );
end;

{$ENDIF   if Android}


end.
