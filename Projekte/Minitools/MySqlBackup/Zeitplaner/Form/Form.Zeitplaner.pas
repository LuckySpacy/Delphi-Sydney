unit Form.Zeitplaner;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.AppEvnts, Objekt.Option,
  Objekt.OptionList, Objekt.MySqlBackup;

type
  RCol = Record const
    Indicator = 0;
    Datenbank = 1;
    Backupdatei = 2;
    Uhrzeit = 3;
    Status = 4;
    ColCount = 5;
  End;


type
  Tfrm_Zeitplaner = class(TForm)
    Panel1: TPanel;
    btn_Neu: TButton;
    btn_Loeschen: TButton;
    btn_Starten: TButton;
    cbx_BackupManuell: TCheckBox;
    Panel3: TPanel;
    Label1: TLabel;
    grd: TAdvStringGrid;
    ApplicationEvents: TApplicationEvents;
    TrayIcon1: TTrayIcon;
    pop: TPopupMenu;
    pop_Show: TMenuItem;
    N1: TMenuItem;
    pop_Close: TMenuItem;
    pop_Einstellung: TPopupMenu;
    pop_EMailEinstellung: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_NeuClick(Sender: TObject);
    procedure grdDblClick(Sender: TObject);
    procedure btn_StartenClick(Sender: TObject);
  private
    fCol: RCol;
    fOptionList: TOptionList;
    procedure ShowOption(aOption: TOption);
    procedure AktualGrid;
    procedure ErzeugeBat(aOption: TOption);
  public
  end;

var
  frm_Zeitplaner: Tfrm_Zeitplaner;

implementation

{$R *.dfm}

uses
  Form.Option, Objekt.Allgemein, ShellAPI, u_System;



procedure Tfrm_Zeitplaner.FormCreate(Sender: TObject);
begin //
  AllgemeinObj := TAllgemeinObj.Create;
  MySqlBackup  := TMySqlBackup.Create;
  fOptionList  := TOptionList.Create;

  grd.ColCount := fCol.ColCount;
  grd.FixedCols := 1;
  grd.FixedColWidth := 10;
  grd.DefaultRowHeight := 18;
  grd.rowcount := 2;
  grd.Options := grd.Options + [goRowSelect];
  grd.Options := grd.Options + [goColSizing];
  grd.Cells[fCol.Datenbank,0] := 'Datenbank';
  grd.Cells[fCol.Backupdatei,0] := 'Backupdatei';
  grd.Cells[fCol.Uhrzeit,0] := 'Uhrzeit';
  grd.Cells[fCol.Status,0] := 'Status';
  grd.SortSettings.Show := true;

  grd.ColWidths[fCol.Datenbank] := 200;
  grd.ColWidths[fCol.Backupdatei] := 200;
  grd.ColWidths[fCol.Uhrzeit] := 60;
  grd.ColWidths[fCol.Status] := 100;


end;

procedure Tfrm_Zeitplaner.FormDestroy(Sender: TObject);
begin
  FreeAndNil(MySqlBackup);
  FreeAndNil(fOptionList);
  FreeAndNil(AllgemeinObj);
end;


procedure Tfrm_Zeitplaner.FormShow(Sender: TObject);
begin
  if not FileExists(MySqlBackup.Ini.Dienst.IniFilename) then
    MySqlBackup.Ini.Dienst.IntervalInMinuten := '10';
  AktualGrid;
end;

procedure Tfrm_Zeitplaner.grdDblClick(Sender: TObject);
begin
  if grd.Objects[0, grd.Row] = nil then
    exit;
  ShowOption(TOption(grd.Objects[0, grd.Row]));
end;

procedure Tfrm_Zeitplaner.btn_NeuClick(Sender: TObject);
begin
  ShowOption(nil);
end;


procedure Tfrm_Zeitplaner.btn_StartenClick(Sender: TObject);
var
  Option: TOption;
begin
  if grd.Objects[0, grd.Row] = nil then
    exit;
  Option := TOption(grd.Objects[0, grd.Row]);
  ErzeugeBat(Option);
  ShellExecute(Handle, 'open', PChar(MySqlBackup.Pfad + 'MySqlBackup.bat'), nil, nil, sw_shownormal);
end;

procedure Tfrm_Zeitplaner.ErzeugeBat(aOption: TOption);
var
  Bat: TStringList;
  Backupname: string;
begin
  Bat := TStringList.Create;
  try
    Backupname := GetFileNameWithoutExt(aOption.Backupname);
    Backupname := ChangeFileName(aOption.Backupname, Backupname + '_' + FormatDateTime('yyyy-mm-dd hhnnss', now));
    Bat.Text := '"' + IncludeTrailingPathDelimiter(aOption.MySqlDumpDir) + 'mysqldump.exe" -u' + aOption.Username +
                ' -p' + aOption.Passwort +
                ' -P' + aOption.Port + ' ' + aOption.Datenbankname + ' > "' + IncludeTrailingPathDelimiter(aOption.Backupverzeichnis) +
                Backupname;
    DeleteFile(MySqlBackup.Pfad + 'MySqlBackup.bat');
    Bat.SaveToFile(MySqlBackup.Pfad + 'MySqlBackup.bat');
  finally
  end;
end;

procedure Tfrm_Zeitplaner.ShowOption(aOption: TOption);
var
  Form: Tfrm_Option;
  Option: TOption;
begin
  //fBackupChecker.TimerEnabled := false;
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
    fOptionList.SaveToFile(MySqlBackup.DataFilename);
    AktualGrid;
    //fBackupChecker.AktualData := true;
    //Aktual(true);
  finally
    FreeAndNil(Form);
    //fBackupChecker.TimerEnabled := not cbx_BackupManuell.Checked;
  end;
end;



procedure Tfrm_Zeitplaner.AktualGrid;
var
  i1: Integer;
  Rows: Integer;
begin
  for i1 := 0 to grd.RowCount -1 do
    grd.Objects[0, i1] := nil;

  grd.ClearNormalCells;

  fOptionList.LoadFromFile(MySqlBackup.DataFileName);


  Rows := fOptionList.Count + 1;
  if Rows < 2 then
    Rows := 2;

  grd.RowCount := Rows;

  for i1 := 0 to fOptionList.Count -1 do
  begin
    grd.Objects[0, i1+1] := fOptionList.Item[i1];
    grd.Cells[fCol.Datenbank, i1+1] := fOptionList.Item[i1].Datenbankname;
    grd.Cells[fcol.Backupdatei, i1+1] := fOptionList.Item[i1].Backupname;
    grd.Cells[fcol.Uhrzeit, i1 + 1] := TimeToStr(fOptionList.Item[i1].StartZeit);
    grd.Cells[fcol.Status, i1 + 1]  := '';
  end;

end;


end.
