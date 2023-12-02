unit Frame.Rezepttitel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  Tfra_Rezepttitel = class(TForm)
    pnl_Left: TPanel;
    pnl_Client: TPanel;
    Label1: TLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fra_Rezepttitel: Tfra_Rezepttitel;

implementation

{$R *.dfm}

end.
