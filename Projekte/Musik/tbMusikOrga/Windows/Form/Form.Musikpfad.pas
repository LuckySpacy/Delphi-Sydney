unit Form.Musikpfad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.MainChild, Vcl.StdCtrls,
  Vcl.ExtCtrls, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DB.Musikpfad, DB.MusikpfadList,
  nfsButton, IBX.IBDatabase;


type
  RCol = Record const
    Indicator = 0;
    Pfad = 1;
    ColCount = 2;
  End;

type
  Tfrm_Musikpfad = class(Tfrm_MainChild)
    Panel1: TPanel;
    Image1: TImage;
    Label6: TLabel;
    pnl_Toolbar: TPanel;
    grd: TAdvStringGrid;
    btn_Neu: TnfsButton;
    btn_Loeschen: TnfsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_NeuClick(Sender: TObject);
    procedure btn_LoeschenClick(Sender: TObject);
    procedure grdEditCellDone(Sender: TObject; ACol, ARow: Integer);
    procedure grdGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    fCol: RCol;
    fDBMusikpfadList: TDBMusikpfadList;
    procedure AktualGrid(aId: Integer);
  public
  end;

var
  frm_Musikpfad: Tfrm_Musikpfad;

implementation

{$R *.dfm}


procedure Tfrm_Musikpfad.FormCreate(Sender: TObject);
begin
  inherited;
  grd.FixedCols := 1;
  grd.FixedColWidth := 10;
  grd.ColCount := fCol.ColCount;
  grd.ColumnHeaders.Add(' ');
  grd.ColumnHeaders.Add('Musikpfad');
  grd.Options := grd.Options + [goColSizing];
  grd.Options := grd.Options - [goRowSelect];
  grd.Options := grd.Options + [goEditing];
  grd.AutoSize := true;
  grd.ColWidths[fCol.Pfad] := 400;
  fDBMusikpfadList := TDBMusikpfadList.Create;
end;

procedure Tfrm_Musikpfad.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDBMusikpfadList);
  inherited;
end;


procedure Tfrm_Musikpfad.FormShow(Sender: TObject);
begin
  inherited;
  fDBMusikpfadList.Trans := fTrans;
  fDBMusikpfadList.ReadAll;
  AktualGrid(0);
end;


procedure Tfrm_Musikpfad.AktualGrid(aId: Integer);
var
  i1: Integer;
  RowCount: Integer;
  SelRow: Integer;
begin
  SelRow := 0;
  grd.ClearNormalCells;
  for i1 := 0 to grd.RowCount -1 do
    grd.Objects[0, i1] := nil;

  RowCount := fDBMusikpfadList.count;
  if RowCount < 2 then
    RowCount := 1;
  grd.RowCount := RowCount + 1;
  for i1 := 0 to fDBMusikpfadList.count -1 do
  begin
    grd.Objects[0, i1+1] := fDBMusikpfadList.Item[i1];
    grd.Cells[fCol.Pfad, i1+1] := fDBMusikpfadList.Item[i1].Pfad;
    if aId = fDBMusikpfadList.Item[i1].Id then
      SelRow := i1+1;
  end;

  if SelRow > 0 then
    grd.GotoCell(1, SelRow);
end;



procedure Tfrm_Musikpfad.btn_NeuClick(Sender: TObject);
var
  Musikpfad: TDBMusikpfad;
begin
  Musikpfad := fDBMusikpfadList.Add;
  Musikpfad.SaveToDB;
  fDBMusikpfadList.ReadAll;
  AktualGrid(Musikpfad.Id);
end;


procedure Tfrm_Musikpfad.btn_LoeschenClick(Sender: TObject);
var
  Musikpfad: TDBMusikpfad;
begin
  if grd.Objects[0, grd.Row] = nil then
    exit;
  if MessageDlg('Diesen Pfad wirklich löschen?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0, mbNo) <> mrYes then
    exit;

  Musikpfad := TDBMusikpfad(grd.Objects[0, grd.Row]);
  Musikpfad.Delete;
  fDBMusikpfadList.ReadAll;
  AktualGrid(0);
  //ShowMessage(IntToStr(Musikpfad.Id));
end;


procedure Tfrm_Musikpfad.grdEditCellDone(Sender: TObject; ACol, ARow: Integer);
var
  Musikpfad: TDBMusikpfad;
begin
  if grd.Objects[0, grd.Row] = nil then
    exit;
  Musikpfad := TDBMusikpfad(grd.Objects[0, ARow]);
  Musikpfad.Pfad := grd.Cells[fCol.Pfad, ARow];
  Musikpfad.SaveToDB;
end;



procedure Tfrm_Musikpfad.grdGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  Pfad: string;
begin
  inherited;
  if (aRow > 0) and (aCol = fCol.Pfad) then
  begin
    Pfad := grd.Cells[fCol.Pfad, ARow];
    if (Pfad > '') and (not DirectoryExists(Pfad)) then
      AFont.Color := clRed
    else
      AFont.Color := clBlack;
  end;
end;

end.
