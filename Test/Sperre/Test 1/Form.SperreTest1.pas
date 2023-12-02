unit Form.SperreTest1;

interface



//https://stackoverflow.com/questions/19626892/how-to-detect-the-termination-of-a-program-in-android

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Platform;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    procedure FormHide(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fEvent: TApplicationEvent;
    function AppEvent(AAppEvent: TApplicationEvent; AContext: TObject) : Boolean;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

function TForm2.AppEvent(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
  if AAppEvent = TApplicationEvent.aeEnteredBackground then
    Memo1.Lines.Add('Backgroud');
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  AppEventSvc: IFMXApplicationEventService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(AppEventSvc)) then
    AppEventSvc.SetApplicationEventHandler(AppEvent);
end;

procedure TForm2.FormDeactivate(Sender: TObject);
begin
  Memo1.Lines.Add('Deactivate');
end;

procedure TForm2.FormHide(Sender: TObject);
begin
  Memo1.Lines.Add('Hide');
end;

end.
