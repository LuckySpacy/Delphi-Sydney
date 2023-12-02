unit Form.IgnorePfad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.StdCtrls, Vcl.ExtCtrls,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DB.Job, DB.IgnorePfad, DB.IgnorePfadList,
  DB.DateiList, DB.JobDateiList, DB.JobDatei;


type
  RCol = Record
    Fix: Integer;
    Pfad: Integer;
    Exakt: Integer;
    Count: Integer;
  End;

type
  Tfrm_IgnorePfad = class(Tfrm_Base)
    Panel1: TPanel;
    btn_neu: TButton;
    btn_Cancel: TButton;
    btn_Delete: TButton;
    grd: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_neuClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure grdGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure grdEditCellDone(Sender: TObject; ACol, ARow: Integer);
    procedure grdCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure grdCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
  private
    fDBJob: TDBJob;
    fDBDateiList: TDBDateiList;
    fDBJobDateiList: TDBJobDateiList;
    fCol: RCol;
    fDBIgnorePfadList: TDBIgnorePfadList;
    fDBJobDatei: TDBJobdatei;
    procedure AktualGrid;
  public
    procedure setJob(aDBJob: TDBJob);
    procedure AktualForm; override;
  end;

var
  frm_IgnorePfad: Tfrm_IgnorePfad;

implementation

{$R *.dfm}

{ Tfrm_IgnorePfad }

uses
  dm.Datenbank;


procedure Tfrm_IgnorePfad.FormCreate(Sender: TObject);
begin
  inherited;
  fDBJob := nil;
  fCol.Fix := 0;
  fCol.Pfad := 1;
  fCol.Exakt := 2;
  fCol.Count := 3;
  grd.ColCount := fCol.Count;
  grd.rowCount := 2;
  grd.Cells[fCol.Pfad, 0 ] := 'Pfad';
  grd.ColWidths[fCol.Fix] := 10;
  grd.ColWidths[fCol.Pfad] := 500;
  grd.Cells[fCol.Exakt, 0 ] := 'Exakt';
  grd.ColWidths[fCol.Exakt] := 80;
  fDBIgnorePfadList := TDBIgnorePfadList.Create;
  fDBIgnorePfadList.Trans := dm_Datenbank.IBTrans_Write;

  fDBDateiList    := TDBDateiList.Create;
  fDBJobDateiList := TDBJobDateiList.Create;

  fDBDateiList.Trans    := dm_Datenbank.IBTrans_Write;
  fDBJobDateiList.Trans := dm_Datenbank.IBTrans_Write;

  fDBJobDatei := TDBJobdatei.Create(nil);
  fDBJobDatei.Trans := dm_Datenbank.IBTrans_Write;


end;

procedure Tfrm_IgnorePfad.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDBIgnorePfadList);
  FreeAndNil(fDBDateiList);
  FreeAndNil(fDBJobDateiList);
  FreeAndNil(fDBJobDatei);
  inherited;
end;

procedure Tfrm_IgnorePfad.FormShow(Sender: TObject);
begin
  AktualGrid;
end;

procedure Tfrm_IgnorePfad.grdCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol = fCol.Exakt then
    CanEdit := true
  else
    CanEdit := false;
end;

procedure Tfrm_IgnorePfad.grdCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
  State: Boolean);
var
  DBIgnorePfad: TDBIgnorePfad;
  i1: Integer;
  DeleteDateien: Boolean;
begin
  DBIgnorePfad := TDBIgnorePfad(Grd.Objects[0, aRow]);
  if DBIgnorePfad = nil then
    exit;
  if ACol = fCol.Exakt then
  begin
    DBIgnorePfad.Exakt := State;
    DBIgnorePfad.SaveToDB;
  end;
  if State then
  begin
    if fDBDateiList.PfadExist(DBIgnorePfad.Pfad) then
    begin
      if MessageDlg('Sollen die Dateien in der Datenbank gelöscht werden?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        exit;
      if MessageDlg('Sollen die Dateien auf der Festplatte im Zielverzeichnis gelöscht werden?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        DeleteDateien := false
      else
        DeleteDateien := true;
       //Diese Stellen ist zu prüfen
      fDBDateiList.ReadPfadList(DBIgnorePfad.Pfad);
      for i1 := 0 to fDBDateiList.Count -1 do
      begin
         fDBJobDatei.Read_DaId(fDBDateiList.Item[i1].id);
         if (fDBJobDatei.Gefunden) and (DeleteDateien) and (FileExists(fDBJobDatei.Datei)) then
           DeleteFile(fDBJobDatei.Datei);
         if fDBJobDatei.Gefunden then
           fDBJobDatei.DelDB;
         fDBDateiList.Item[i1].DelDB;
      end;
    end;
  end;
end;

procedure Tfrm_IgnorePfad.grdEditCellDone(Sender: TObject; ACol, ARow: Integer);
var
  DBIgnorePfad: TDBIgnorePfad;
begin
  exit;
  DBIgnorePfad := TDBIgnorePfad(Grd.Objects[0, aRow]);
  if DBIgnorePfad = nil then
    exit;
  if ACol = fCol.Exakt then
    DBIgnorePfad.SaveToDB;
end;

procedure Tfrm_IgnorePfad.grdGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  HAlign := taLeftJustify;
  if ACol in [fCol.Exakt] then
    HAlign := taCenter;
end;

procedure Tfrm_IgnorePfad.setJob(aDBJob: TDBJob);
begin
  fDBJob := aDBJob;
end;

procedure Tfrm_IgnorePfad.AktualForm;
begin
  inherited;
  AktualGrid;
end;

procedure Tfrm_IgnorePfad.AktualGrid;
var
  i1: Integer;
  RowCount: Integer;
begin
  grd.ClearNormalCells;
  if fDBJob = nil then
    exit;
  for i1 := 0 to grd.RowCount -1 do
    grd.Objects[0, i1] := nil;
  fDBIgnorePfadList.ReadAll(fDBJob.Id);
  RowCount := fDBIgnorePfadList.Count + 1;
  if RowCount < 2 then
    RowCount := 2;
  grd.RowCount := RowCount;
  for i1 := 0 to fDBIgnorePfadList.Count -1 do
  begin
    grd.Objects[0, i1+1] := fDBIgnorePfadList.Item[i1];
    grd.Cells[fCol.Pfad, i1+1] := fDBIgnorePfadList.Item[i1].Pfad;
    Grd.AddCheckBox(fCol.Exakt, i1+1, fDBIgnorePfadList.Item[i1].Exakt, false);
  end;

  if fDBIgnorePfadList.Count = 0 then
    grd.Options := grd.Options - [goEditing]
  else
    grd.Options := grd.Options + [goEditing];

end;

procedure Tfrm_IgnorePfad.btn_CancelClick(Sender: TObject);
begin
  close;
end;


procedure Tfrm_IgnorePfad.btn_DeleteClick(Sender: TObject);
var
  DBIgnorePfad: TDBIgnorePfad;
begin
  DBIgnorePfad := TDBIgnorePfad(grd.Objects[0, grd.Row]);
  if DBIgnorePfad = nil then
    exit;
  if MessageDlg('Wirklich löschen?', TMsgDlgType.mtConfirmation, [mbyes, mbNo], 0) <> mrYes  then
    exit;
  DBIgnorePfad.Delete;
  AktualGrid;
end;

procedure Tfrm_IgnorePfad.btn_neuClick(Sender: TObject);
var
  Pfadname: string;
  DBIgnorePfad: TDBIgnorePfad;
begin
  InputQuery('Pfad hinzufügen', 'Pfad', Pfadname);
  if Pfadname = '' then
    exit;
  DBIgnorePfad := fDBIgnorePfadList.Add;
  DBIgnorePfad.JoId := fDBJob.Id;
  DBIgnorePfad.Pfad := Pfadname;
  DBIgnorePfad.SaveToDB;
  AktualGrid;
end;

end.
