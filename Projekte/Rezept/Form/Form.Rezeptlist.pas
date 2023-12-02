unit Form.Rezeptlist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DB.RezeptList, DB.Rezept;


type
  RCol = Record const
    Indicator = 0;
    Rezept = 1;
    ColCount = 2;
  End;

type
  Tfrm_Rezeptlist = class(TForm)
    grd: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdDblClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    fCol: RCol;
    fRezeptList: TDBRezeptList;
    fOnRezeptBearbeiten: TNotifyEvent;
    procedure AktualGrid(aId: Integer);
  public
    function AktualRezept: TDBRezept;
    property OnRezeptBearbeiten: TNotifyEvent read fOnRezeptBearbeiten write fOnRezeptBearbeiten;
    procedure RefreshGrid(aId: Integer);
  end;

var
  frm_Rezeptlist: Tfrm_Rezeptlist;

implementation

{$R *.dfm}

uses
  System.UITypes, Datamodul.Database;



procedure Tfrm_Rezeptlist.FormCreate(Sender: TObject);
begin
  grd.FixedCols := 1;
  grd.FixedColWidth := 10;
  grd.ColCount := fCol.ColCount;
  grd.ColumnHeaders.Add(' ');
  grd.ColumnHeaders.Add('Rezept');
  grd.Options := grd.Options + [goColSizing];
  grd.Options := grd.Options - [goRowSelect];
  grd.Options := grd.Options - [goEditing];
  grd.AutoSize := true;
  grd.ColWidths[fCol.Rezept] := 500;
  grd.RowCount := 2;

  fRezeptList := TDBRezeptList.Create;
  fRezeptList.Trans := dm.getTrans;
  //fRezeptList.Trans := dm.IBT_Standard;
  //fRezeptList.Trans := nil;

end;

procedure Tfrm_Rezeptlist.FormDestroy(Sender: TObject);
begin //
  FreeAndNil(fRezeptList);
end;

procedure Tfrm_Rezeptlist.FormShow(Sender: TObject);
begin
  fRezeptList.ReadAll;
  AktualGrid(0);
end;


procedure Tfrm_Rezeptlist.grdDblClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  if Assigned(fOnRezeptBearbeiten) then
    fOnRezeptBearbeiten(Self);
end;

procedure Tfrm_Rezeptlist.RefreshGrid(aId: Integer);
begin
  fRezeptList.ReadAll;
  AktualGrid(aId);
end;

procedure Tfrm_Rezeptlist.AktualGrid(aId: Integer);
var
  i1: Integer;
  RowCount: Integer;
  SelRow: Integer;
begin
  SelRow := 0;
  grd.ClearNormalCells;
  for i1 := 0 to grd.RowCount -1 do
    grd.Objects[0, i1] := nil;

  RowCount := fRezeptList.count;
  if RowCount < 2 then
    RowCount := 1;
  grd.RowCount := RowCount + 1;
  for i1 := 0 to fRezeptList.count -1 do
  begin
    grd.Objects[0, i1+1] := fRezeptList.Item[i1];
    grd.Cells[fCol.Rezept, i1+1] := fRezeptList.Item[i1].Rezeptname;
    if aId = fRezeptList.Item[i1].Id then
      SelRow := i1+1;
  end;

  if SelRow > 0 then
    grd.GotoCell(1, SelRow);
end;

function Tfrm_Rezeptlist.AktualRezept: TDBRezept;
begin
  Result := TDBRezept(grd.Objects[0, grd.Row]);
end;



end.
