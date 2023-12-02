unit MainFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Memo.Types,
  DW.MobileDeviceInfo;

type
  TfrmMain = class(TForm)
    Memo: TMemo;
  private
    FDeviceInfo: TMobileDeviceInfo;
    procedure DumpOSInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  REST.Json,
  DW.OSDevice, DW.OSPower, DW.Classes.Helpers;

const
  cDevicePowerStatusCaptions: array[TDevicePowerStatus] of string = (
    'Unknown', 'Device Charging', 'Device Not Charging', 'Device on AC Power'
  );
  cBatteryStatusCaptions: array[TBatteryStatus] of string = (
    'Unknown', 'No Battery', 'Battery Healthy', 'Battery Normal', 'Battery Low', 'Battery Critical'
  );
  cUIModeCaptions: array[TUIMode] of string = (
    'Appliance', 'Car', 'Desk', 'Normal', 'TV', 'VR Headset', 'Undefined', 'Watch'
  );

function SecondsToTime(ASeconds: Integer): TDateTime;
var
  LHours, LMins: Word;
begin
  if ASeconds > 0 then
  begin
    LHours := ASeconds div SecsPerHour;
    ASeconds := ASeconds mod SecsPerHour;
    LMins := ASeconds div SecsPerMin;
    ASeconds := ASeconds mod SecsPerMin;
    Result := EncodeTime(LHours, LMins, ASeconds, 0);
  end
  else
    Result := 0;
end;

{ TfrmMain }

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;
  FDeviceInfo := TJson.JsonToObject<TMobileDeviceInfo>(TResourceHelper.LoadString('MobileDeviceInfo'));
  DumpOSInfo;
end;

destructor TfrmMain.Destroy;
begin
  FDeviceInfo.Free;
  inherited;
end;

procedure TfrmMain.DumpOSInfo;
var
  LSeconds: Integer;
  LDevice: TMobileDevice;
begin
  Memo.Lines.Add(Format('Device manufacturer: %s', [TOSDevice.GetManufacturer]));
  Memo.Lines.Add(Format('Device name: %s', [TOSDevice.GetDeviceName]));
//  Memo.Lines.Add(Format('Device model: %s', [TOSDevice.GetDeviceModel]));
  if (FDeviceInfo <> nil) and FDeviceInfo.FindDeviceByModel(TOSDevice.GetDeviceModel, LDevice) then
    Memo.Lines.Add(Format('Device model: %s', [LDevice.Description]))
  else
    Memo.Lines.Add(Format('Device model: %s', [TOSDevice.GetDeviceModel]));
  Memo.Lines.Add(Format('UI Mode: %s', [cUIModeCaptions[TOSDevice.GetUIMode]]));
  Memo.Lines.Add(Format('Unique ID: %s', [TOSDevice.GetUniqueDeviceID]));
  if TOSDevice.IsMobile then
    Memo.Lines.Add('Device is a mobile device')
  else
    Memo.Lines.Add('Device is not a mobile device');
  if TOSDevice.IsTouchDevice then
    Memo.Lines.Add('Device has touch features')
  else
    Memo.Lines.Add('Device does not have touch features');
  Memo.Lines.Add(Format('Device power status: %s', [cDevicePowerStatusCaptions[TOSPower.GetDevicePowerStatus]]));
  Memo.Lines.Add(Format('Battery level: %d%', [TOSPower.GetBatteryLevel]));
  Memo.Lines.Add(Format('Battery status: %s', [cBatteryStatusCaptions[TOSPower.GetBatteryStatus]]));
  LSeconds := TOSPower.GetBatteryLifeTime;
  if LSeconds > -1 then
    Memo.Lines.Add(Format('Battery charge remaining: %s', [FormatDateTime('hh:nn:ss', SecondsToTime(LSeconds))]));
  LSeconds := TOSPower.GetBatteryChargeTime;
  if LSeconds > -1 then
    Memo.Lines.Add(Format('Battery charging time remaining: %s', [FormatDateTime('hh:nn:ss', SecondsToTime(LSeconds))]));
end;

end.
