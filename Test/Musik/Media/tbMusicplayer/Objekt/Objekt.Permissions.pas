unit Objekt.Permissions;

interface

uses
  System.SysUtils, System.Permissions
  {$IFDEF ANDROID}
  ,Androidapi.Helpers
  ,Androidapi.JNI.Os
  {$ENDIF ANDROID}
  ;


type
  TMyPermissions = class
  private
    FPermissionReadExternalStorage: string;
    FPermissionWriteExternalStorage: string;
    procedure DisplayRationale(Sender: TObject; const APermissions: TArray<string>; const APostRationaleProc: TProc);
    procedure ReadStoragePermissionRequestResult(Sender: TObject; const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>);
  public
    procedure getPermissions;
  end;


implementation

{ TMyPermissions }

uses
  fmx.DialogService, System.UITypes;

procedure TMyPermissions.DisplayRationale(Sender: TObject;
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



procedure TMyPermissions.ReadStoragePermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin

end;

procedure TMyPermissions.getPermissions;
begin
  {$IFDEF ANDROID}
  FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  PermissionsService.RequestPermissions([FPermissionReadExternalStorage], ReadStoragePermissionRequestResult, DisplayRationale);
  FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
  PermissionsService.RequestPermissions([FPermissionWriteExternalStorage], ReadStoragePermissionRequestResult, DisplayRationale);
 {$ENDIF ANDROID}

end;


end.
