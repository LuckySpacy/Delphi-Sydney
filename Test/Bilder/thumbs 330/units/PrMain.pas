unit PrMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, ExtCtrls, ComCtrls, jpeg, ClipBrd, Menus, ShellAPI,
  Buttons, Spin;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    DriveComboBox1: TDriveComboBox;
    DirBox: TDirectoryListBox;
    FileBox: TFileListBox;
    ThEdit: TSpinEdit;
    Label1: TLabel;
    ThPathEdit: TEdit;
    Label2: TLabel;
    LabelDir: TLabel;
    Label3: TLabel;
    ThPreEdit: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    NormEdit: TSpinEdit;
    NormPathEdit: TEdit;
    NormPreEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    BigEdit: TSpinEdit;
    BigPathEdit: TEdit;
    BigPreEdit: TEdit;
    indexBox: TCheckBox;
    StartButton: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure Erstellen1Click(Sender: TObject);
    procedure FileBoxDblClick(Sender: TObject);
    procedure DirBoxChange(Sender: TObject);
  private
    { Private declarations }
    FileListe: TStringList;
    procedure ThumbsGenerieren;
    procedure DisableControls;
    procedure EnableControls;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses PrConstVars, PrShowUnit, PrJpegConv;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Icon:=Application.Icon;
  Caption:=Application.Title;
  DirBox.Directory:=ProgPath;
  FileBox.Directory:=ProgPath;
  StatusBar.SimpleText:='';
end;

procedure TMainForm.DisableControls;
begin
  StartButton.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  DirBox.Enabled:=False;
  FileBox.Enabled:=False;
  ThEdit.Enabled:=False;
  ThPathEdit.Enabled:=False;
  ThPreEdit.Enabled:=False;
  NormEdit.Enabled:=False;
  NormPathEdit.Enabled:=False;
  NormPreEdit.Enabled:=False;
  BigEdit.Enabled:=False;
  BigPathEdit.Enabled:=False;
  BigPreEdit.Enabled:=False;
  indexBox.Enabled:=False;
  FileListe:=TStringList.Create;
end;

procedure TMainForm.EnableControls;
begin
  FileListe.Free;
  Screen.Cursor:=crDefault;
  DirBox.Enabled:=True;
  FileBox.Enabled:=True;
  ThEdit.Enabled:=True;
  ThPathEdit.Enabled:=True;
  ThPreEdit.Enabled:=True;
  NormEdit.Enabled:=True;
  NormPathEdit.Enabled:=True;
  NormPreEdit.Enabled:=True;
  BigEdit.Enabled:=True;
  BigPathEdit.Enabled:=True;
  BigPreEdit.Enabled:=True;
  indexBox.Enabled:=True;
  StartButton.Enabled:=True;
end;

procedure TMainForm.Erstellen1Click(Sender: TObject);
var i: Integer;
begin
  if FileBox.Items.Count = 0 then Exit;
  DisableControls;
  ThumbsGenerieren;
  FileBox.Update;
  DirBox.Update;
  EnableControls;
end;

procedure TMainForm.ThumbsGenerieren;
var
  i, cnt: Integer;
  indexhtml: TStringList;
  InFileName, OutFileName, OriFileName, WorkPath, tmpName, tmpExt: string;
begin
  ThumbMass:=ThEdit.Value;
  ThumbPath:=Trim(ThPathEdit.Text);
  ThumbPrefix:=Trim(ThPreEdit.Text);
  NormMass:=NormEdit.Value;
  NormPath:=Trim(NormPathEdit.Text);
  NormPrefix:=Trim(NormPreEdit.Text);
  BigMass:=BigEdit.Value;
  BigPath:=Trim(BigPathEdit.Text);
  BigPrefix:=Trim(BigPreEdit.Text);
  indexhtml:=TStringList.Create;
  indexhtml.Add('Das Verzeichnis ist leer');
  InPath:=IncludeTrailingBackslash(LabelDir.Caption);
  //Alle Dateinamen einsammeln
  for i:=0 to FileBox.Items.Count-1 do begin
    tmpName:=FileBox.Items[i]; //Extender unbedingt klein machen!!
    tmpExt:=ExtractFileExt(tmpName);
    tmpName:=ChangeFileExt(tmpName,AnsiLowerCase(tmpExt));
    FileListe.Add(tmpName);
  end;
  StatusBar.SimpleText:='Kopien der Originalbilder erstellen...';
  URPath:=InPath+'UR';
  if not DirectoryExists(URPath) then begin
    if not ForceDirectories(URPath) then begin
      ShowMessage('Verzeichnis '+URPath+' konnte nicht erstellt werden!');
      EnableControls;
      Exit;
    end;
  end;
  URPath:=URPath+'\';
  cnt:=FileListe.Count;
  for i:=0 to cnt-1 do begin
    OriFileName:=FileListe[i]; //Original-FileName
    StatusBar.SimpleText:='Kopiere '+OriFileName;
    InFileName:=InPath+OriFileName; //Original-Verzeichnis+FileName
    //Zuerst die Originalfiles zur Sicherheit kopieren
    OutFileName:=URPath+OriFileName;
    CopyFile(PChar(InFileName), PChar(OutFileName),True);
    //und jetzt die Original-Datei löschen
    DeleteFile(InPath+FileBox.Items[i]);
  end;
  indexhtml.SaveToFile(URPath+'index.html');
  //WorkPath auf Verzeichnis "UR" setzen, denn da sind jetzt die Dateien
  WorkPath:=URPath; //WorkPath ist jetzt das Source-Verzeichnis
  //Verzeichnis für große Bilder erstellen
  if Trim(BigPathEdit.Text)<>'' then begin
    BigPath:=InPath+Trim(BigPathEdit.Text);
    if not DirectoryExists(BigPath) then
     if not ForceDirectories(BigPath) then begin
       ShowMessage('Verzeichnis '+BigPath+' konnte nicht erstellt werden!');
       EnableControls;
       Exit;
     end;
    BigPath:=BigPath+'\';
  end else
   BigPath:=InPath;
  indexhtml.SaveToFile(BigPath+'index.html');
  //Verzeichnis für normale Bilder erstellen
  if Trim(NormPathEdit.Text)<>'' then begin
    NormPath:=InPath+Trim(NormPathEdit.Text);
    if not DirectoryExists(NormPath) then begin
      if not ForceDirectories(NormPath) then begin
        ShowMessage('Verzeichnis '+NormPath+' konnte nicht erstellt werden!');
        EnableControls;
        Exit;
      end;
    end;
    NormPath:=NormPath+'\';
  end else
   NormPath:=InPath;
  indexhtml.SaveToFile(NormPath+'index.html');
  //Verzeichnis für Thumbs Bilder erstellen
  if Trim(ThPathEdit.Text)<>'' then begin
    ThumbPath:=InPath+Trim(ThPathEdit.Text);
    if not DirectoryExists(ThumbPath) then begin
      if not ForceDirectories(ThumbPath) then begin
        ShowMessage('Verzeichnis '+ThumbPath+' konnte nicht erstellt werden!');
        EnableControls;
        Exit;
      end;
    end;
    ThumbPath:=ThumbPath+'\';
  end else
   ThumbPath:=InPath;
  indexhtml.SaveToFile(ThumbPath+'index.html');
  for i:=0 to cnt-1 do begin
    OriFileName:=FileListe[i];
    StatusBar.SimpleText:='Aktuell: '+OriFileName+', Bild: '+IntToStr(i+1)+' von '+IntToStr(cnt);
    InFileName:=WorkPath+OriFileName; //Ursprungsdatei
    //großes Bild generieren
    OutFileName:=BigPath+Trim(BigPreEdit.Text)+OriFileName;
    MakeBigBilder(InFileName, OutFileName, BigMass, NormMass);
    //normales Bild generieren
    OutFileName:=NormPath+Trim(NormPreEdit.Text)+OriFileName;
    MakeNormalBilder(InFileName, OutFileName, NormMass);
    //Thumbs generieren
    OutFileName:=ThumbPath+Trim(ThPreEdit.Text)+OriFileName;
    MakeThumbBilder(InFileName, OutFileName, ThumbMass);
    //....
    Application.ProcessMessages;
  end;
  indexhtml.Free;
  StatusBar.SimpleText:=IntToStr(cnt)+' Bilder umgewandelt.';
end;

procedure TMainForm.FileBoxDblClick(Sender: TObject);
var BName: String;
begin
  BName:=FileBox.Items[FileBox.ItemIndex];
  if BName<>'' then begin
    ShowForm:=TShowForm.Create(Application);
    ShowForm.BorderStyle:=bsSingle;
    ShowForm.Caption:=BName;
    ShowForm.Image1.Picture.LoadFromFile(BName);
    ShowForm.ClientWidth:=ShowForm.Image1.Picture.Width;
    ShowForm.ClientHeight:=ShowForm.Image1.Picture.Height;
    ShowForm.ShowModal;
  end;
end;

procedure TMainForm.DirBoxChange(Sender: TObject);
begin
  StartButton.Enabled := True;
end;

end.
