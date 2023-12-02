unit Objekt.Hauptverarbeitung;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.StdCtrls, Objekt.Verarbeitung1;

type
  THauptverarbeitung = class
  private
    fStatusLabel: TLabel;
    fVerarbeitung1: TVerarbeitung1;
    fOnEnde: TNotifyEvent;
  public
    constructor Create;
    destructor Destroy; override;
    procedure setStatusLabel(aLabel: TLabel);
    procedure Start;
    procedure EndeVonVerarbeitung1(Sender: TObject);
    property OnEnde: TNotifyEvent read fOnEnde write fOnEnde;
  end;


implementation

{ THauptverarbeitung }

constructor THauptverarbeitung.Create;
begin
  fVerarbeitung1 := TVerarbeitung1.Create;
  fVerarbeitung1.OnEnde := EndeVonVerarbeitung1;
end;

destructor THauptverarbeitung.Destroy;
begin
  FreeAndNil(fVerarbeitung1);
  inherited;
end;


procedure THauptverarbeitung.setStatusLabel(aLabel: TLabel);
begin
  fStatusLabel := aLabel;
end;

procedure THauptverarbeitung.Start;
begin
  fStatusLabel.Text := 'Starte Verarbeitung';
  fVerarbeitung1.setStatusLabel(fStatusLabel);
  fVerarbeitung1.Start;
end;


procedure THauptverarbeitung.EndeVonVerarbeitung1(Sender: TObject);
begin
  if Assigned(fOnEnde) then
    fOnEnde(Self);
end;


end.
