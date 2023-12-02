unit Form.MainChild;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TCreateNewFormEvent = procedure(Sender: TObject; var aPointer: Pointer) of object;
  Tfrm_MainChild = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fOnCloseMainChild: TNotifyEvent;
  protected
    fOnCreateEinstellung: TCreateNewFormEvent;
    fOnCreateRezeptNeu: TCreateNewFormEvent;
  public
    property OnCreateEinstellung: TCreateNewFormEvent read fOnCreateEinstellung write fOnCreateEinstellung;
    property OnCloseMainChild: TNotifyEvent read fOnCloseMainChild write fOnCloseMainChild;
    property OnCreateRezeptNeu: TCreateNewFormEvent read fOnCreateRezeptNeu write fOnCreateRezeptNeu;
  end;

var
  frm_MainChild: Tfrm_MainChild;

implementation

{$R *.dfm}

procedure Tfrm_MainChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(fOnCloseMainChild) then
    fOnCloseMainChild(Self);
end;

procedure Tfrm_MainChild.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //ShowMessage(Self.Name);
end;

end.
