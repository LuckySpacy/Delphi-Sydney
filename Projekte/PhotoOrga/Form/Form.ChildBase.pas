unit Form.ChildBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  Tfrm_ChildBase = class(TForm)
  private
    fOnAnzeigen: TNotifyEvent;
  public
    procedure Anzeigen;
    property OnAnzeigen: TNotifyEvent read fOnAnzeigen write fOnAnzeigen;
  end;

var
  frm_ChildBase: Tfrm_ChildBase;

implementation

{$R *.dfm}

{ Tfrm_ChildBase }

procedure Tfrm_ChildBase.Anzeigen;
begin
  if Assigned(fOnAnzeigen) then
    fOnAnzeigen(Self);
  show;
end;

end.
