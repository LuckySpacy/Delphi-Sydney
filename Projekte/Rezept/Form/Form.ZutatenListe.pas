unit Form.ZutatenListe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, nfsButton, Vcl.StdCtrls,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.ExtCtrls, DB.Rezept, DB.Zutaten, DB.ZutatenList,
  Objekt.Abgleich;


type
  RCol = Record const
    Indicator = 0;
    Zutat = 1;
    ColCount = 2;
  End;


type
  Tfrm_Zutatenliste = class(TForm)
    Panel4: TPanel;
    grd_Zutaten: TAdvStringGrid;
    Panel8: TPanel;
    Label2: TLabel;
    btn_Loeschen: TnfsButton;
    btn_Neu: TnfsButton;
    btn_Edit: TnfsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_ZutatenCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure grd_ZutatenEditCellDone(Sender: TObject; ACol, ARow: Integer);
    procedure btn_NeuClick(Sender: TObject);
    procedure btn_LoeschenClick(Sender: TObject);
    procedure grd_ZutatenDblClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
  private
    fCol: RCol;
    fDBRezept: TDBRezept;
    fDBZutatenList: TDBZutatenList;
    fAbgleich: TAbgleich;
    fDBZutaten: TDBZutaten;
    fEditMode: Boolean;
  public
    procedure setDBRezept(aDBRezept: TDBRezept);
    procedure setAbgleich(aAbgleich: TAbgleich);
    procedure AktualGrid(aId: Integer);
  end;

var
  frm_Zutatenliste: Tfrm_Zutatenliste;

implementation

{$R *.dfm}

uses
  Objekt.Vergleich, Objekt.VergleichList, System.UITypes;



procedure Tfrm_Zutatenliste.FormCreate(Sender: TObject);
begin //
  grd_Zutaten.FixedCols := 1;
  grd_Zutaten.FixedColWidth := 10;
  grd_Zutaten.ColCount := fCol.ColCount;
  grd_Zutaten.ColumnHeaders.Add(' ');
  grd_Zutaten.ColumnHeaders.Add('Zutat');
  grd_Zutaten.Options := grd_Zutaten.Options + [goColSizing];
  grd_Zutaten.Options := grd_Zutaten.Options - [goRowSelect];
  grd_Zutaten.Options := grd_Zutaten.Options + [goEditing];
  grd_Zutaten.AutoSize := true;
  grd_Zutaten.ColWidths[fCol.Zutat] := 200;
  grd_Zutaten.RowCount := 2;

  fDBZutatenList := TDBZutatenList.Create;
  fDBZutaten := TDBZutaten.Create(nil);
  fEditMode := false;


end;

procedure Tfrm_Zutatenliste.FormDestroy(Sender: TObject);
begin  //
  FreeAndNil(fDBZutatenList);
  FreeAndNil(fDBZutaten);
end;

procedure Tfrm_Zutatenliste.FormShow(Sender: TObject);
begin //

end;


procedure Tfrm_Zutatenliste.setAbgleich(aAbgleich: TAbgleich);
var
   i1: Integer;
begin
  fAbgleich := aAbgleich;
  fAbgleich.QuellList.Clear;
  fDBZutatenList.ReadAll;
  for i1 := 0 to fDBZutatenList.Count -1 do
    fAbgleich.AddQuelllist(fDBZutatenList.Item[i1].Id, fDBZutatenList.Item[i1].ZutatenName, fDBZutatenList.Item[i1]);
  fAbgleich.QuellList.SortBez;
end;

procedure Tfrm_Zutatenliste.setDBRezept(aDBRezept: TDBRezept);
begin
  fDBRezept := aDBRezept;
  fDBZutatenList.Trans := fDBRezept.Trans;
  fDBZutaten.Trans     := FDBRezept.Trans;
end;


procedure Tfrm_Zutatenliste.AktualGrid(aId: Integer);
var
  i1: Integer;
  RowCount: Integer;
  SelRow: Integer;
  VergleichList: TVergleichList;
begin
  SelRow := 0;
  grd_Zutaten.ClearNormalCells;
  for i1 := 0 to grd_Zutaten.RowCount -1 do
    grd_Zutaten.Objects[0, i1] := nil;

  VergleichList := fAbgleich.QuellList;
  RowCount := VergleichList.count;
  if RowCount < 2 then
    RowCount := 1;
  grd_Zutaten.RowCount := RowCount + 1;
  for i1 := 0 to VergleichList.count -1 do
  begin
    grd_Zutaten.Objects[0, i1+1] := VergleichList.Item[i1];
    grd_Zutaten.Cells[fCol.Zutat, i1+1] := VergleichList.Item[i1].Bez;
    if aId = VergleichList.Item[i1].Id then
      SelRow := i1+1;
  end;

  if SelRow > 0 then
    grd_Zutaten.GotoCell(1, SelRow);
end;


procedure Tfrm_Zutatenliste.grd_ZutatenCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin //
  CanEdit := (grd_Zutaten.Objects[0, ARow] <> nil) and (fEditMode);
end;



procedure Tfrm_Zutatenliste.grd_ZutatenDblClick(Sender: TObject);
var
  Vergleich: TVergleich;
begin //
  Vergleich := TVergleich(grd_Zutaten.Objects[0, grd_Zutaten.Row]);
  if Vergleich = nil then
    exit;
  fAbgleich.FromQuellToZiel(Vergleich.Id);
end;

procedure Tfrm_Zutatenliste.grd_ZutatenEditCellDone(Sender: TObject; ACol,
  ARow: Integer);
var
  //Zutaten: TDBZutaten;
  Vergleich: TVergleich;
begin
  Vergleich := TVergleich(grd_Zutaten.Objects[0, ARow]);
  if Vergleich = nil then
    exit;
  fDBZutaten.Read(Vergleich.id);
  if not fDBZutaten.Gefunden then
    exit;
  fDBZutaten.ZutatenName := Trim(grd_Zutaten.Cells[fCol.Zutat, ARow]);
  fDBZutaten.SaveToDB;
  Vergleich.Bez := fDBZutaten.ZutatenName;
  fEditMode := false;
end;

procedure Tfrm_Zutatenliste.btn_EditClick(Sender: TObject);
begin
  fEditMode := true;
end;

procedure Tfrm_Zutatenliste.btn_LoeschenClick(Sender: TObject);
var
  Zutaten: TDBZutaten;
  Vergleich: TVergleich;
begin
  Vergleich := TVergleich(grd_Zutaten.Objects[0, grd_Zutaten.Row]);
  if Vergleich = nil then
    exit;
  Zutaten := TDBZutaten(Vergleich.Objects);
  if Zutaten = nil then
    exit;

  if MessageDlg('Zutat "' + Zutaten.ZutatenName + '" wirklich löschen?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;
  Zutaten.Delete;
  AktualGrid(0);
end;

procedure Tfrm_Zutatenliste.btn_NeuClick(Sender: TObject);
begin //
  fDBZutaten.Init;
  fDBZutaten.SaveToDB;
  fAbgleich.AddQuelllist(fDBZutaten.Id, fDBZutaten.ZutatenName, fDBZutaten);
  AktualGrid(FDBZutaten.Id);
  fEditMode := true;
end;

end.
