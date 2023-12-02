unit Form.MainToolbar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.ChildBase, nfsButton, Vcl.ExtCtrls,
  Datamodul.Bilder;

type
  Tfrm_MainToolbar = class(Tfrm_ChildBase)
    Panel1: TPanel;
    btn_Einstellung: TnfsButton;
    btn_Close: TnfsButton;
    btn_BilderEinlesen: TnfsButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_EinstellungClick(Sender: TObject);
    procedure btn_BilderEinlesenClick(Sender: TObject);
  private
    fOnSchliessen: TNotifyEvent;
    fOnEinstellung: TNotifyEvent;
    fOnBilderEinlesen: TNotifyEvent;
  public
    property OnSchliessen: TNotifyEvent read fOnSchliessen write fOnSchliessen;
    property OnEinstellung: TNotifyEvent read fOnEinstellung write fOnEinstellung;
    property OnBilderEinlesen: TNotifyEvent read fOnBilderEinlesen write fOnBilderEinlesen;
  end;

var
  frm_MainToolbar: Tfrm_MainToolbar;

implementation

{$R *.dfm}

procedure Tfrm_MainToolbar.btn_BilderEinlesenClick(Sender: TObject);
begin
  if Assigned(fOnBilderEinlesen) then
    fOnBilderEinlesen(Self);
end;

procedure Tfrm_MainToolbar.btn_CloseClick(Sender: TObject);
begin
  if Assigned(fOnSchliessen) then
    fOnSchliessen(Self);
end;

procedure Tfrm_MainToolbar.btn_EinstellungClick(Sender: TObject);
begin
  if Assigned(fOnEinstellung) then
    fOnEinstellung(Self);
end;

end.
