unit Frame.Kategorie;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, tbButton, Vcl.ExtCtrls,
  Vcl.Menus;

type
  Tfra_Kategorie = class(TForm)
    Panel1: TPanel;
    btn_Neu: TTBButton;
    VirtualStringTree1: TVirtualStringTree;
    btn_Loeschen: TTBButton;
    pop: TPopupMenu;
    mnu_Neu_auf_dieser_Ebene: TMenuItem;
    mnu_Neu_auf_naechster_Ebene: TMenuItem;
    N1: TMenuItem;
    mnu_Loeschen: TMenuItem;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fra_Kategorie: Tfra_Kategorie;

implementation

{$R *.dfm}

uses
  Datenmodul.dm;

end.
