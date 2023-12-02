unit Form.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  Tfrm_Base = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fObjects: TObject;
    fOnCloseForm: TNotifyEvent;
  protected
  public
    property Objects: TObject read fObjects write fObjects;
    property OnCloseForm: TNotifyEvent read fOnCloseForm write fOnCloseForm;
    procedure AktualForm; virtual; Abstract;
  end;

var
  frm_Base: Tfrm_Base;

implementation

{$R *.dfm}

procedure Tfrm_Base.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(fOnCloseForm) then
    fOnCloseForm(Self);
end;

end.
