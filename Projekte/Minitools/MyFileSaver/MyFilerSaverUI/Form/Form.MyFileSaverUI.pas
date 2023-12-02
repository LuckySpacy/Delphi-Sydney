unit Form.MyFileSaverUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.StdCtrls, Vcl.ExtCtrls, Form.Option, Objekt.OptionList, Objekt.Option,
  Objekt.Dateisystem, Objekt.Zip;


type
  RCol = Record const
    Indicator = 0;
    Von = 1;
    Nach = 2;
    //Uhrzeit = 3;
    ColCount = 3;
  End;

type
  Tfrm_MyFileSaver = class(TForm)
    Panel1: TPanel;
    btn_Neu: TButton;
    btn_Loeschen: TButton;
    btn_Starten: TButton;
    Panel3: TPanel;
    Label1: TLabel;
    grd: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdDblClick(Sender: TObject);
    procedure btn_NeuClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_StartenClick(Sender: TObject);
  private
    fCol: RCol;
    fOptionList: TOptionList;
    fDateisystem: TDateisystem;
    fZip: TZip;
    procedure AktualGrid;
    procedure ShowOption(aOption: TOption);
  public
  end;

var
  frm_MyFileSaver: Tfrm_MyFileSaver;

implementation

{$R *.dfm}

uses
  Objekt.MyFileServer, Objekt.Allgemein, Objekt.DateiList;


procedure Tfrm_MyFileSaver.FormCreate(Sender: TObject);
begin
  AllgemeinObj := TAllgemeinObj.Create;
  MyFileServer := TMyFileServer.Create;
  fOptionList  := TOptionList.Create;
  fDateisystem := TDateisystem.Create;
  fZip := TZip.Create;


  grd.ColCount := fCol.ColCount;
  grd.FixedCols := 1;
  grd.FixedColWidth := 10;
  grd.DefaultRowHeight := 18;
  grd.rowcount := 2;
  grd.Options := grd.Options + [goRowSelect];
  grd.Options := grd.Options + [goColSizing];
  grd.Cells[fCol.von,0] := 'Von';
  grd.Cells[fCol.Nach,0] := 'Nach';
  //grd.Cells[fCol.Uhrzeit,0] := 'Uhrzeit';
  grd.SortSettings.Show := true;
  grd.ColWidths[fCol.Von] := 200;
  grd.ColWidths[fCol.Nach] := 200;
  //grd.ColWidths[fCol.Uhrzeit] := 60;
end;

procedure Tfrm_MyFileSaver.FormDestroy(Sender: TObject);
begin  //
  FreeAndNil(MyFileServer);
  FreeAndNil(fOptionList);
  FreeAndNil(AllgemeinObj);
  FreeAndNil(fDateisystem);
  FreeAndNil(fZip);
end;

procedure Tfrm_MyFileSaver.FormShow(Sender: TObject);
begin
   AktualGrid;;
end;

procedure Tfrm_MyFileSaver.grdDblClick(Sender: TObject);
begin
  if grd.Objects[0, grd.Row] = nil then
    exit;
  ShowOption(TOption(grd.Objects[0, grd.Row]));
end;

procedure Tfrm_MyFileSaver.ShowOption(aOption: TOption);
var
  Form: Tfrm_Option;
  Option: TOption;
begin
  Form := Tfrm_Option.Create(nil);
  try
    Option := aOption;
    Form.setOption(Option);
    Form.ShowModal;
    if Form.Cancel then
      exit;
    if Option = nil then
      Option := fOptionList.Add;
    Form.FillOption(Option);
    fOptionList.SaveToFile(MyFileServer.DataFilename);
    AktualGrid;
  finally
    FreeAndNil(Form);
  end;
end;


procedure Tfrm_MyFileSaver.AktualGrid;
var
  i1: Integer;
  Rows: Integer;
begin
  for i1 := 0 to grd.RowCount -1 do
    grd.Objects[0, i1] := nil;

  grd.ClearNormalCells;

  fOptionList.LoadFromFile(MyFileServer.DataFileName);


  Rows := fOptionList.Count + 1;
  if Rows < 2 then
    Rows := 2;

  grd.RowCount := Rows;

  for i1 := 0 to fOptionList.Count -1 do
  begin
    grd.Objects[0, i1+1] := fOptionList.Item[i1];
    grd.Cells[fCol.Von, i1+1] := fOptionList.Item[i1].Von;
    grd.Cells[fcol.Nach, i1+1] := fOptionList.Item[i1].Nach;
    //grd.Cells[fcol.Uhrzeit, i1 + 1] := TimeToStr(fOptionList.Item[i1].StartZeit);
  end;

end;

procedure Tfrm_MyFileSaver.btn_NeuClick(Sender: TObject);
begin
  ShowOption(nil);
end;


procedure Tfrm_MyFileSaver.btn_StartenClick(Sender: TObject);
var
//  DateiList: TDateiList;
//  i1: Integer;
  Quell: string;
  Ziel: string;
begin
  Quell := 'd:\Temp\shop.bat';
  Ziel := 'd:\temp\temp2\shop.zip';
  fZip.DoZipFile(Ziel, Quell);
//  Ziel  := 'b:\Backup\shop.bat';
//  CopyFile(PWideChar(Quell), PWideChar(Ziel), false);

{
  DateiList := TDateiList.Create;
  try
    fDateisystem.ReadFiles('d:\temp', DateiList, false, '*.sql');
    DateiList.NachLastWriteTimeSortieren(false);
    fDateisystem.DeleteFilesAusserDieErstenAnzahl(DateiList, 4);
  finally
    FreeAndNil(DateiList);
  end;
}
end;

end.
