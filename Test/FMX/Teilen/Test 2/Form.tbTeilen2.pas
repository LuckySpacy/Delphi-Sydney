unit Form.tbTeilen2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, dw.ShareItems;

type
  Tfrm_Teilen2 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FExcluded: TShareActivities;
    FShareItems: TShareItems;
    procedure Share;
    procedure ShareItemsShareCompletedHandler(Sender: TObject; const AActivity: TShareActivity; const AError: string);
    procedure SaveToFile;
    function getSharedFilename: string;
  public
  end;

var
  frm_Teilen2: Tfrm_Teilen2;

implementation

{$R *.fmx}

uses
  System.IOUtils, System.Permissions,
  DW.Consts.Android, DW.Permissions.Helpers;



procedure Tfrm_Teilen2.FormCreate(Sender: TObject);
begin
  // Exclude all but the following - Note: applicable to iOS ONLY - uncomment the next line to test
  // FExcluded := TShareItems.AllShareActivities - [TShareActivity.Message, TShareActivity.Mail, TShareActivity.CopyToPasteboard];
  FShareItems := TShareItems.Create;
  FShareItems.OnShareCompleted := ShareItemsShareCompletedHandler;
end;

procedure Tfrm_Teilen2.FormDestroy(Sender: TObject);
begin  //
  FreeAndNil(FShareItems);
end;


procedure Tfrm_Teilen2.ShareItemsShareCompletedHandler(Sender: TObject; const AActivity: TShareActivity; const AError: string);
begin
  // If AActivity is TShareActivity.None, then the user cancelled - except for Android because it does not tell you :-/
  if AActivity = TShareActivity.None then
    ShowMessage('Share cancelled')
  else
    ShowMessage('Share completed');
end;


procedure Tfrm_Teilen2.Button1Click(Sender: TObject);
begin
  //SaveToFile;
  //exit;
  PermissionsService.RequestPermissions([cPermissionReadExternalStorage, cPermissionWriteExternalStorage],
    procedure(const APermissions: TPermissionArray; const AGrantResults: TPermissionStatusArray)
    begin
      if AGrantResults.AreAllGranted then
        Share;
    end
  );
end;



function Tfrm_Teilen2.getSharedFilename: string;
begin
  Result := TPath.Combine(TPath.GetSharedDocumentsPath, 'BAScloud.csv');
end;


procedure Tfrm_Teilen2.SaveToFile;
var
  SharedFilename: string;
  List: TStringList;
begin
  SharedFileName := getSharedFilename;
  List := TStringList.Create;
  try
    List.Add('Thomas;Bachmann');
    List.SaveToFile(SharedFilename);
  finally
    FreeAndNil(List);
  end;
end;


procedure Tfrm_Teilen2.Share;
var
  LSharedFileName: string;
begin
  saveToFile;
  FShareItems.AddFile(getSharedFilename);
  FShareItems.Share(Button1, FExcluded);
end;


{
procedure Tfrm_Teilen2.Share;
var
  LSharedFileName: string;
begin
  LSharedFileName := TPath.Combine('Files', 'Lorem.txt');
  // FShareItems.AddText('Share Test');
  // Uncomment the following line and comment out the next one, to test sharing of a file
   FShareItems.AddFile(TPath.Combine(TPath.GetDocumentsPath, LSharedFileName));
  //FShareItems.AddImage(Image1.Bitmap); // On Android, don't attempt to share an image as well as text
  FShareItems.Share(Button1, FExcluded);
end;
 }

end.
