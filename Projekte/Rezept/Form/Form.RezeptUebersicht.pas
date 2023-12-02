unit Form.RezeptUebersicht;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.ExtCtrls, VirtualTrees;

type
  RCol = Record const
    Indicator = 0;
    Rezept = 1;
    ColCount = 2;
  End;

type
  Tfrm_RezeptUebersicht = class(TForm)
    VirtualStringTree1: TVirtualStringTree;
    Splitter1: TSplitter;
    AdvStringGrid1: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fCol: RCol;
  public
  end;

var
  frm_RezeptUebersicht: Tfrm_RezeptUebersicht;

implementation

{$R *.dfm}

procedure Tfrm_RezeptUebersicht.FormCreate(Sender: TObject);
begin //
{
  grd.FixedCols := 1;
  grd.FixedColWidth := 10;
  grd.ColCount := fCol.ColCount;
  grd.ColumnHeaders.Add(' ');
  grd.ColumnHeaders.Add('Rezept');
  grd.Options := grd.Options + [goColSizing];
  grd.Options := grd.Options + [goRowSelect];
  grd.AutoSize := true;
  grd.ColWidths[fCol.Rezept] := 200;
  grd.RowCount := 2;
  }
end;

procedure Tfrm_RezeptUebersicht.FormDestroy(Sender: TObject);
begin //

end;

end.
