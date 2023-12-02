unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Objekt.Dateisystem,
  Objekt.DateiList, Objekt.Datei;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    mem: TMemo;
    btn_Start: TButton;
    btn_Test: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
  private
    fDateiSystem: TDateisystem;
    fDateiList: TDateiList;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
begin
  fDateiSystem := TDateisystem.Create;
  fDateiList   := TDateiList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDateiList);
  FreeAndNil(fDateiSystem);
end;

procedure TForm1.btn_StartClick(Sender: TObject);
var
  i1: Integer;
begin
  //fDateiSystem.ReadFiles('d:\temp\Temp2', fDateiList, false, 'Shop*.sql');
  //fDateiSystem.ReadFiles('b:\backup\Temp', fDateiList, false, 'Shop*.sql');
  //fDateiSystem.ReadFiles('d:\temp\', fDateiList, true, '*.*');
  fDateiSystem.ReadFiles('n:\Datensicherung\HarddriveClone\Asus-PC-2018\',fDateiList, true, '*.*');
  mem.Clear;
  //fDateiList.NachLastWriteTimeSortieren(false);
  for i1 := 0 to fDateiList.Count -1 do
  begin
    mem.Lines.Add(fDateiList.Item[i1].FullDateiname +' - ' + fDateiList.Item[i1].Datum.LastWriteTimeAsString);
    //mem.Lines.Add(FormatDateTime('dd.mm.yyyy hh:nn:ss', fDateiList.Item[i1].Datum.CreationTime));
    //mem.Lines.Add(FormatDateTime('dd.mm.yyyy hh:nn:ss', fDateiList.Item[i1].Datum.LastAccessTime));
    //mem.Lines.Add(FormatDateTime('dd.mm.yyyy hh:nn:ss', fDateiList.Item[i1].Datum.LastWriteTime));
    //mem.Lines.Add(IntToStr(fDateiList.Item[i1].Dateigroesse));
  end;
  mem.Lines.Add('-----------------------------------------------------------------------------------');
  exit;
  fDateiSystem.DeleteFilesAusserDieErstenAnzahl(fDateiList, 4);
  for i1 := 0 to fDateiList.Count -1 do
  begin
    mem.Lines.Add(fDateiList.Item[i1].FullDateiname +' - ' + fDateiList.Item[i1].Datum.LastWriteTimeAsString);
  end;
end;

procedure TForm1.btn_TestClick(Sender: TObject);
var
  Datei: TDatei;
begin
  Datei := TDatei.Create;
  //Datei.FullDateiname := 'c:\temp\Thomas.bat';
  Datei.Dateiname := 'T.bat';
  mem.Clear;
  mem.Lines.Add(Datei.Ext);
  mem.Lines.Add(Datei.DateinameWithoutExt);
  FreeAndNil(Datei);
end;

end.
