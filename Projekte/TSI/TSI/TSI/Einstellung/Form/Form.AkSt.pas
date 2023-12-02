unit Form.AkSt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, Vcl.ExtCtrls, DBObj.SchnittstelleList, DBObj.Schnittstelle,
  DBObj.Boersenindex, DBObj.BoersenIndexList, DBObj.Aktie, DBObj.AktieList, DBObj.AkSt,
  AdvUtil;


type
  RCol = Record
    Index: Integer;
    ISIN: Integer;
    WKN: Integer;
    Aktie: Integer;
    Aktiv: Integer;
    Param1: Integer;
    ColCount: Integer;
  End;

type
  Tfrm_AkSt = class(TForm)
    Panel1: TPanel;
    lbl_Schnittstelle: TLabel;
    Panel2: TPanel;
    pnl_Boersenindex: TLabel;
    grd: TAdvStringGrid;
    cbo_Schnittstelle: TComboBox;
    cbo_Boersenindex: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure cbo_BoersenindexChange(Sender: TObject);
    procedure cbo_SchnittstelleChange(Sender: TObject);
    procedure grdEditingDone(Sender: TObject);
    procedure grdEditCellDone(Sender: TObject; ACol, ARow: Integer);
    procedure grdCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
  private
    fCol: RCol;
    fSchnittstelleList: TSchnittstelleList;
    fSchnittstelle: TSchnittstelle;
    fBoersenindexList: TBoersenindexList;
    fBoersenindex: TBoersenindex;
    fAktieList: TAktieList;
    fAktie: TAktie;
    fAkSt: TAkSt;
    procedure LadeGrid;
  public
  end;

var
  frm_AkSt: Tfrm_AkSt;

implementation

{$R *.dfm}

uses
  Datamodul.TSI;



procedure Tfrm_AkSt.FormCreate(Sender: TObject);
begin
  fSchnittstelleList := TSchnittstelleList.Create(nil);
  fSchnittstelleList.Trans := dm.IBT;
  fSchnittstelle := TSchnittstelle.Create(nil);
  fSchnittstelle.Trans := dm.IBT;

  fBoersenindexList := TBoersenindexList.Create(nil);
  fBoersenindexList.Trans := dm.IBT;
  fBoersenindex := TBoersenindex.Create(nil);
  fBoersenindex.Trans := dm.IBT;

  fCol.Index := 0;
  fCol.ISIN   := 1;
  fCol.WKN   := 2;
  fCol.Aktie := 3;
  fCol.Aktiv := 4;
  fCol.Param1 := 5;
  fCol.ColCount := 6;

  grd.ColCount := fCol.ColCount;
  grd.FixedColWidth := 10;
  grd.Cells[fCol.ISIN, 0] := 'ISIN';
  grd.Cells[fCol.WKN, 0] := 'WKN';
  grd.Cells[fCol.Aktie, 0] := 'Aktie';
  grd.Cells[fCol.Aktiv, 0] := 'Aktiv';
  grd.Cells[fCol.Param1, 0] := 'Param1';

  grd.ColWidths[fCol.ISIN] := 120;
  grd.ColWidths[fCol.WKN] := 100;
  grd.ColWidths[fCol.Aktie] := 200;
  grd.ColWidths[fCol.Aktiv] := 80;
  grd.ColWidths[fCol.Param1] := 200;

  grd.RowCount := 2;

  grd.Options := grd.Options + [goEditing];

  fAktieList := TAktieList.Create(nil);
  fAktieList.Trans := dm.IBT;

  fAktie := TAktie.Create(nil);
  fAktie.Trans := dm.IBT;

  fAkSt := TAkSt.Create(nil);
  fAkSt.Trans := dm.IBT;




end;

procedure Tfrm_AkSt.FormDestroy(Sender: TObject);
begin  //
  FreeAndNil(fSchnittstelleList);
  FreeAndNil(fSchnittstelle);
  FreeAndNil(fBoersenindexList);
  FreeAndNil(fBoersenindex);
  FreeAndNil(fAktieList);
  FreeAndNil(fAktie);
  FreeAndNil(fAkSt);
end;

procedure Tfrm_AkSt.FormShow(Sender: TObject);
begin
  fSchnittstelleList.LadeCombobox(cbo_Schnittstelle.Items);
  fBoersenindexList.LadeCombobox(cbo_Boersenindex.Items);
end;

procedure Tfrm_AkSt.grdCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := false;
  if (fCol.WKN = ACol) or (fCol.Aktie = ACol) then
    exit;
  CanEdit := true;
end;



procedure Tfrm_AkSt.grdCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
  State: Boolean);
var
  Aktie: TAktie;
  Cur: TCursor;
 begin
  if (fCol.Aktiv <> ACol) then
    exit;

  Cur := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    Aktie := TAktie(grd.Objects[0, ARow]);
    if Aktie = nil then
      exit;

    if fCol.Aktiv = ACol then
      Aktie.Aktiv := State;

    Aktie.SaveToDB;
  finally
    Screen.Cursor := Cur;
  end;
end;

procedure Tfrm_AkSt.cbo_BoersenindexChange(Sender: TObject);
begin
  LadeGrid;
end;

procedure Tfrm_AkSt.cbo_SchnittstelleChange(Sender: TObject);
begin
  LadeGrid;
end;



procedure Tfrm_AkSt.LadeGrid;
var
  BiId: Integer;
  SSId: Integer;
  i1: Integer;
begin
  grd.ClearNormalCells;
  grd.RowCount := 2;
  if cbo_Boersenindex.ItemIndex < 0 then
    exit;

  if cbo_Schnittstelle.ItemIndex < 0 then
    exit;


  BiId := Integer(cbo_Boersenindex.Items.Objects[cbo_Boersenindex.ItemIndex]);
  SSId := Integer(cbo_Schnittstelle.Items.Objects[cbo_Schnittstelle.ItemIndex]);

  fAktieList.ReadAllInBoersenindex(BiId);

  if fAktieList.Count <= 1 then
    grd.RowCount := 2
  else
    grd.RowCount := fAktieList.Count + 1;


  for i1 := 0 to fAktieList.Count -1 do
  begin
    fAkSt.ReadSchnittstelleAktie(SSId, fAktieList.Item[i1].Id);
    if fAkSt.Gefunden then
      grd.Cells[fCol.Param1, i1+1] := fAkSt.Param1;
    grd.Cells[fCol.ISIN, i1+1] := fAktieList.Item[i1].ISIN;
    grd.Cells[fCol.WKN, i1+1] := fAktieList.Item[i1].WKN;
    grd.Cells[fCol.Aktie, i1+1] := fAktieList.Item[i1].Aktie;
    grd.AddCheckBox(fCol.Aktiv, i1+1, fAktieList.Item[i1].Aktiv, false);
    grd.Objects[0, i1+1] := fAktieList.Item[i1];
  end;

end;


procedure Tfrm_AkSt.grdEditCellDone(Sender: TObject; ACol, ARow: Integer);
var
  Aktie: TAktie;
begin
  if aCol = fcol.ISIN then
  begin
    Aktie := TAktie(grd.Objects[0, ARow]);
    Aktie.ISIN := grd.Cells[fCol.Isin, ARow];
    Aktie.SaveToDB;
  end;
end;

procedure Tfrm_AkSt.grdEditingDone(Sender: TObject);
var
  Aktie: TAktie;
  SSId: Integer;
begin
  if grd.Objects[0, grd.Row] = nil then
    exit;

  if cbo_Schnittstelle.ItemIndex < 0 then
    exit;

  SSId := Integer(cbo_Schnittstelle.Items.Objects[cbo_Schnittstelle.ItemIndex]);

  Aktie := TAktie(grd.Objects[0, grd.Row]);
  fAkSt.ReadSchnittstelleAktie(SSId, Aktie.Id);
  fAkSt.AK_ID := Aktie.Id;
  fAkSt.SS_ID := SSId;
  fAkSt.Param1 := grd.Cells[fCol.Param1, grd.Row];
  fAkSt.SaveToDB;

end;


end.
