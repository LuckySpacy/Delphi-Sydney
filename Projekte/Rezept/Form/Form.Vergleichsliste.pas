unit Form.Vergleichsliste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Objekt.Abgleich;

type
  Tfrm_Vergleichsliste = class(TForm)
    lst_Ziel: TListBox;
    lst_Quelle: TListBox;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lst_QuelleDblClick(Sender: TObject);
    procedure lst_ZielDblClick(Sender: TObject);
  private
    fAbgleich: TAbgleich;
    procedure AktualQuell;
    procedure AktualZiel;
  public
  end;

var
  frm_Vergleichsliste: Tfrm_Vergleichsliste;

implementation

{$R *.dfm}

uses
  objekt.Vergleich;


procedure Tfrm_Vergleichsliste.FormCreate(Sender: TObject);
//var
//  i1: Integer;
begin
  fAbgleich := TAbgleich.Create;
  fAbgleich.AddQuellList(1, 'Salz', nil);
  fAbgleich.AddQuellList(2, 'Pfeffer', nil);
  fAbgleich.AddQuellList(3, 'Zucker', nil);
  fAbgleich.AddQuellList(4, 'Mehl', nil);
  AktualQuell;
  AktualZiel;
end;

procedure Tfrm_Vergleichsliste.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fAbgleich);
end;


procedure Tfrm_Vergleichsliste.AktualQuell;
var
  i1: Integer;
begin
  lst_Quelle.Clear;
  for i1 := 0 to fAbgleich.QuellList.Count -1 do
  begin
    lst_Quelle.AddItem(fAbgleich.QuellList.Item[i1].Bez, fAbgleich.QuellList.Item[i1]);
  end;
end;

procedure Tfrm_Vergleichsliste.AktualZiel;
var
  i1: Integer;
begin
  lst_Ziel.Clear;
  for i1 := 0 to fAbgleich.ZielList.Count -1 do
  begin
    lst_Ziel.AddItem(fAbgleich.ZielList.Item[i1].Bez, fAbgleich.ZielList.Item[i1]);
  end;
end;


procedure Tfrm_Vergleichsliste.lst_QuelleDblClick(Sender: TObject);
var
  Vergleich: TVergleich;
begin
  Vergleich := TVergleich(lst_Quelle.Items.Objects[lst_Quelle.ItemIndex]);
  fAbgleich.FromQuellToZiel(Vergleich.Id);
  fAbgleich.Ziellist.SortBez;
  AktualQuell;
  AktualZiel;
end;

procedure Tfrm_Vergleichsliste.lst_ZielDblClick(Sender: TObject);
var
  Vergleich: TVergleich;
begin
  Vergleich := TVergleich(lst_Ziel.Items.Objects[lst_Ziel.ItemIndex]);
  fAbgleich.FromZielToQuell(Vergleich.Id);
  fAbgleich.QuellList.SortBez;
  AktualQuell;
  AktualZiel;
end;

end.
