unit Objekt.Verarbeitung1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.StdCtrls;

type
  TVerarbeitung1 = class
  private
    fStatusLabel: TLabel;
    fOnEnde: TNotifyEvent;
    procedure VerarbeitungEnde(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure setStatusLabel(aLabel: TLabel);
    procedure Start;
    property OnEnde: TNotifyEvent read fOnEnde write fOnEnde;
  end;

implementation

{ TVerarbeitung1 }

constructor TVerarbeitung1.Create;
begin

end;

destructor TVerarbeitung1.Destroy;
begin

  inherited;
end;

procedure TVerarbeitung1.setStatusLabel(aLabel: TLabel);
begin
  fStatusLabel := aLabel;
end;

procedure TVerarbeitung1.Start;
var
  t: TThread;
begin
  t := Tthread.CreateAnonymousThread(
    procedure
    var
      i1: Integer;
    begin
      for i1 := 0 to 10000 do
      begin
        //Sleep(1000);
        //fStatusLabel.Text := 'Verarbeitung1 (' + IntToStr(i1) + ')';

        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          fStatusLabel.Text := 'Verarbeitung1 (' + IntToStr(i1) + ')';
          //Memo1.Lines.Add('Hurra');
        end
        )
      end
    end
  );
  t.OnTerminate := VerarbeitungEnde;
  t.Start;
  t.WaitFor;

end;

procedure TVerarbeitung1.VerarbeitungEnde(Sender: TObject);
begin
  if Assigned(fOnEnde) then
    fOnEnde(Self);
end;

end.
