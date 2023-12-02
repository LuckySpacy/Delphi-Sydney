unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.StdCtrls, Vcl.ExtCtrls, Form.Prozess;

type
  TSyncZielEvent = procedure(aJoId: Integer) of object;
  Tfrm_Main = class(Tfrm_Base)
    Panel1: TPanel;
    btn_Start: TButton;
    btn_Stop: TButton;
    btn_Einstellung: TButton;
    procedure btn_EinstellungClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure btn_StopClick(Sender: TObject);
  private
    fOnEinstellungClick: TNotifyEvent;
    fFormProzess: Tfrm_Prozess;
    fOnSyncZiel: TSyncZielEvent;
    fOnBevorStart: TNotifyEvent;
    fOnAfterStart: TNotifyEvent;
  public
    property OnEinstellungClick: TNotifyEvent read fOnEinstellungClick write fOnEinstellungClick;
    procedure AktualForm; override;
    procedure ProzessEnd(Sender: TObject);
    property OnSyncZiel: TSyncZielEvent read fOnSyncZiel write fOnSyncZiel;
    procedure SyncZielPfad(aJoId: Integer);
    property OnBevorStart: TNotifyEvent read fOnBevorStart write fOnBevorStart;
    property OnAfterStart: TNotifyEvent read fOnAfterStart write fOnAfterStart;
  end;

var
  frm_Main: Tfrm_Main;

implementation

{$R *.dfm}


procedure Tfrm_Main.FormCreate(Sender: TObject);
begin
  inherited;

  fFormProzess := Tfrm_Prozess.Create(Self);
  fFormProzess.Parent := Self;
  fFormProzess.Align := alClient;
  fFormProzess.onEnd := ProzessEnd;

end;


procedure Tfrm_Main.ProzessEnd(Sender: TObject);
begin
  fFormProzess.Visible := false;
  if Assigned(fOnAfterStart) then
    fOnAfterStart(Self);
end;

procedure Tfrm_Main.SyncZielPfad(aJoId: Integer);
begin
  fFormProzess.Show;
  fFormProzess.SyncZielPfad(aJoId);
end;

procedure Tfrm_Main.AktualForm;
begin //
  inherited;

end;

procedure Tfrm_Main.btn_EinstellungClick(Sender: TObject);
begin
  if Assigned(fOnEinstellungClick) then
    fOnEinstellungClick(Self);
end;


procedure Tfrm_Main.btn_StartClick(Sender: TObject);
begin
  fFormProzess.Show;
  if Assigned(fOnBevorStart) then
    fOnBevorStart(Self);
  fFormProzess.Start;
end;

procedure Tfrm_Main.btn_StopClick(Sender: TObject);
begin
  fFormProzess.Stop;
  if Assigned(fOnAfterStart) then
    fOnAfterStart(Self);
end;

end.
