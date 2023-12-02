unit Form.RezeptZutatenListe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.StdCtrls, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, Vcl.ExtCtrls, DB.Rezept, Objekt.Abgleich,
  Objekt.Vergleich, Objekt.Vergleichlist, DB.RezeptZutaten, DB.RezeptZutatenlist,
  Objekt.VergleichRezeptZutatList, Objekt.VergleichRezeptZutat;

type
  RCol = Record const
    Indicator = 0;
    Menge = 1;
    Einheit = 2;
    Zutat = 3;
    ColCount = 4;
  End;


type
  Tfrm_Rezeptzutatenliste = class(TForm)
    Panel2: TPanel;
    grd: TAdvStringGrid;
    Panel9: TPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdDblClick(Sender: TObject);
    procedure grdGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure grdCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure grdEditCellDone(Sender: TObject; ACol, ARow: Integer);
  private
    fCol: RCol;
    fAbgleich: TAbgleich;
    fDBRezept: TDBRezept;
    fZlId: Integer;
    fDBRezeptzutatenList: TDBRezeptzutatenList;
    fVergleichRezeptZutatList: TVergleichRezeptZutatList;
    procedure AktualAbgleich;
  public
    procedure setDBRezept(aDBRezept: TDBRezept; aZlId: Integer);
    procedure setAbgleich(aAbgleich: TAbgleich);
    procedure AktualGrid(aId: Integer);
  end;

var
  frm_Rezeptzutatenliste: Tfrm_Rezeptzutatenliste;

implementation

{$R *.dfm}



procedure Tfrm_Rezeptzutatenliste.FormCreate(Sender: TObject);
begin
  grd.FixedCols := 1;
  grd.FixedColWidth := 10;
  grd.ColCount := fCol.ColCount;
  grd.ColumnHeaders.Add(' ');
  grd.ColumnHeaders.Add('Menge');
  grd.ColumnHeaders.Add('Einheit');
  grd.ColumnHeaders.Add('Zutat');
  grd.Options := grd.Options + [goColSizing];
  grd.Options := grd.Options - [goRowSelect];
  grd.Options := grd.Options + [goEditing];
  grd.AutoSize := true;
  grd.ColWidths[fCol.Zutat] := 200;
  grd.ColWidths[fCol.Menge] := 80;
  grd.ColWidths[fCol.Einheit] := 80;

  fAbgleich := nil;
  fDBRezeptzutatenList := TDBRezeptzutatenList.Create;
  fVergleichRezeptZutatList := TVergleichRezeptZutatList.Create;

end;

procedure Tfrm_Rezeptzutatenliste.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fVergleichRezeptZutatList);
  FreeAndNil(fDBRezeptzutatenList);
end;


procedure Tfrm_Rezeptzutatenliste.grdDblClick(Sender: TObject);
var
  Vergleich: TVergleich;
begin //
  Vergleich := TVergleich(grd.Objects[0, grd.Row]);
  if Vergleich = nil then
    exit;
  fAbgleich.FromZielToQuell(Vergleich.Id);
end;

procedure Tfrm_Rezeptzutatenliste.grdEditCellDone(Sender: TObject; ACol,
  ARow: Integer);
var
  Vergleich: TVergleich;
  rMenge: Extended;
  sMenge: string;
begin
  if ARow <= 0 then
    exit;
  Vergleich := TVergleich(grd.Objects[0, ARow]);
  if Vergleich.Objects = nil then
    Vergleich.Objects := fVergleichRezeptZutatList.Add;

  sMenge := grd.Cells[fCol.Menge, ARow];

  if TryStrToFloat(sMenge, rMenge) then
    TVergleichRezeptZutat(Vergleich.Objects).Menge := rMenge
  else
    TVergleichRezeptZutat(Vergleich.Objects).Menge := 0;

  TVergleichRezeptZutat(Vergleich.Objects).Einheit := grd.Cells[fCol.Einheit, ARow];

end;

procedure Tfrm_Rezeptzutatenliste.grdGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = fCol.Menge then
    HAlign := taRightJustify;
end;

procedure Tfrm_Rezeptzutatenliste.grdCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  if ARow <= 0 then
    exit;
  if (fCol.Menge = ACol) or (fCol.Einheit = ACol) then
    CanEdit := true;
end;


procedure Tfrm_Rezeptzutatenliste.setAbgleich(aAbgleich: TAbgleich);
begin
  fAbgleich := aAbgleich;
  AktualAbgleich;
end;

procedure Tfrm_Rezeptzutatenliste.setDBRezept(aDBRezept: TDBRezept; aZlId: Integer);
begin
  fDBRezept := aDBRezept;
  fZlId := aZlId;
  fDBRezeptzutatenList.Trans := fDBRezept.Trans;
  AktualAbgleich;
end;


procedure Tfrm_Rezeptzutatenliste.AktualAbgleich;
var
  i1: Integer;
  VergleichRezeptZutat: TVergleichRezeptZutat;
begin
  if fAbgleich = nil then
    exit;
  fVergleichRezeptZutatList.Clear;
  fDBRezeptzutatenList.ReadAll(fDBRezept.Id, fZlId);
  for i1 := 0 to fDBRezeptzutatenList.Count -1 do
  begin
    VergleichRezeptZutat := fVergleichRezeptZutatList.Add;
    VergleichRezeptZutat.Id := fDBRezeptzutatenList.Item[i1].Id;
    VergleichRezeptZutat.Menge := fDBRezeptzutatenList.Item[i1].Menge;
    VergleichRezeptZutat.Einheit := FDBRezeptZutatenList.Item[i1].Einheit;
    fAbgleich.FromQuellToZiel(fDBRezeptzutatenList.Item[i1].ZT_ID, VergleichRezeptZutat);
  end;
end;

procedure Tfrm_Rezeptzutatenliste.AktualGrid(aId: Integer);
var
  i1: Integer;
  RowCount: Integer;
  SelRow: Integer;
  VergleichList: TVergleichList;
  VergleichRezeptZutat: TVergleichRezeptZutat;
begin
  SelRow := 0;
  grd.ClearNormalCells;
  for i1 := 0 to grd.RowCount -1 do
    grd.Objects[0, i1] := nil;

  VergleichList := fAbgleich.ZielList;
  RowCount := VergleichList.count;
  if RowCount < 2 then
    RowCount := 1;
  grd.RowCount := RowCount + 1;
  for i1 := 0 to VergleichList.count -1 do
  begin
    grd.Objects[0, i1+1] := VergleichList.Item[i1];
    grd.Cells[fCol.Zutat, i1+1] := VergleichList.Item[i1].Bez;
    if TVergleichRezeptZutat(VergleichList.Item[i1].Objects) = nil then
      VergleichList.Item[i1].Objects := fVergleichRezeptZutatList.Add;
    VergleichRezeptZutat := TVergleichRezeptZutat(VergleichList.Item[i1].Objects);
    grd.Cells[fCol.Menge, i1+1] := FloatToStr(VergleichRezeptZutat.Menge);
    grd.Cells[fCol.Einheit, i1+1] := VergleichRezeptZutat.Einheit;

    if aId = VergleichList.Item[i1].Id then
      SelRow := i1+1;
  end;

  if SelRow > 0 then
    grd.GotoCell(1, SelRow);
end;


end.
