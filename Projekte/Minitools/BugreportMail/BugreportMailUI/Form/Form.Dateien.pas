unit Form.Dateien;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.StdCtrls, Vcl.ExtCtrls,
  Objekt.DateiList, Objekt.Datei, System.UITypes;

type
  RCol = Record const
    Indicator = 0;
    Datei = 1;
    ColCount = 2;
  End;


type
  Tfrm_Dateien = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btn_Neu: TButton;
    btn_Loeschen: TButton;
    grd: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_NeuClick(Sender: TObject);
    procedure grdDblClick(Sender: TObject);
    procedure btn_LoeschenClick(Sender: TObject);
  private
    fCol: RCol;
    fDateiList: TDateiList;
    fDateiListname: string;
    procedure AktualGrid;
    procedure ShowDatei(aDatei: TDatei);
  public
  end;

var
  frm_Dateien: Tfrm_Dateien;

implementation

{$R *.dfm}

uses
  Objekt.BugreportMail, Form.Datei;



procedure Tfrm_Dateien.FormCreate(Sender: TObject);
begin
  grd.ColCount := fCol.ColCount;
  grd.FixedCols := 1;
  grd.FixedColWidth := 10;
  grd.DefaultRowHeight := 18;
  grd.rowcount := 2;
  grd.Options := grd.Options + [goRowSelect];
  grd.Options := grd.Options + [goColSizing];
  grd.Cells[fCol.Datei,0] := 'Datei';
  grd.SortSettings.Show := true;

  grd.ColWidths[fCol.Datei] := 400;

  fDateiListname := BugreportMail.Pfad + 'DateiList.dat';
  fDateiList := TDateiList.Create;

end;

procedure Tfrm_Dateien.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDateiList);
end;


procedure Tfrm_Dateien.FormShow(Sender: TObject);
begin
  AktualGrid;
end;

procedure Tfrm_Dateien.grdDblClick(Sender: TObject);
var
  Datei: TDatei;
begin
  if grd.Objects[0, grd.Row] = nil then
    exit;
  Datei := TDatei(grd.Objects[0, grd.Row]);
  ShowDatei(Datei);
end;

procedure Tfrm_Dateien.btn_LoeschenClick(Sender: TObject);
var
  Datei: TDatei;
begin
  if grd.Objects[0, grd.Row] = nil then
    exit;
  Datei := TDatei(grd.Objects[0, grd.Row]);
  if MessageDlg('Die Datei "' + Datei.Datei + '" wirklich löschen?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;
  fDateiList.Delete(Datei.id);
  fDateiList.SaveToFile(fDateiListname);
  AktualGrid;
end;

procedure Tfrm_Dateien.btn_NeuClick(Sender: TObject);
begin
  ShowDatei(nil);
end;


procedure Tfrm_Dateien.ShowDatei(aDatei: TDatei);
var
  Form: Tfrm_Datei;
  Datei: TDatei;
begin
  Form := Tfrm_Datei.Create(Self);
  try
    Form.setDatei(aDatei);
    Form.ShowModal;
    if Form.Cancel then
      exit;
    Datei := aDatei;
    if Datei = nil then
      Datei := fDateiList.Add;
    Datei.Betreff := Form.edt_Betreff.Text;
    Datei.Datei   := Form.edt_Datei.Text;
    Datei.EMail   := Form.edt_EMail.Text;
    fDateiList.SaveToFile(fDateiListname);
    AktualGrid;
  finally
    FreeAndNil(Form);
  end;
end;

procedure Tfrm_Dateien.AktualGrid;
var
  i1: Integer;
  Rows: Integer;
begin
  for i1 := 0 to grd.RowCount -1 do
    grd.Objects[0, i1] := nil;
  grd.ClearNormalCells;

  fDateiList.LoadFromFile(fDateiListname);
  Rows := fDateiList.Count;
  if Rows < 2 then
    Rows := 1;

  grd.RowCount := Rows + 1;

  for i1 := 0 to fDateiList.Count -1 do
  begin
    grd.Objects[0, i1+1] := fDateiList.Item[i1];
    grd.Cells[fCol.Datei, i1+1] := fDateiList.Item[i1].Datei;
  end;


end;


end.
