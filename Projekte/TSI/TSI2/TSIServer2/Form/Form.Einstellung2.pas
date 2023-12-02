unit Form.Einstellung2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.DateTimeCtrls, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  FMX.Layouts, DB.Schnittstelle, DB.SchnittstelleList,
  Objekt.DownloadKurse, Objekt.CSVKurseToDB, Objekt.SaveTSIWerte,
  fmx.Platform, Objekt.SaveAbwProz, Objekt.SaveKursHochTief, Objekt.SaveGuVJahr;

type
  Tfrm_Einstellung2 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edt_Uhrzeit: TTimeEdit;
    Label2: TLabel;
    cbo_Schnittstelle: TComboBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    edt_Downloadpfad: TEdit;
    edt_Zielpfad: TEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edt_Server: TEdit;
    edt_KurseFDB: TEdit;
    edt_TSIFDB: TEdit;
    Layout1: TLayout;
    cbx_DownloadKurse: TCheckBox;
    cbx_AbwProz: TCheckBox;
    cbx_TSIWerte: TCheckBox;
    cbx_KursHochTief: TCheckBox;
    cbx_CSVKurseToDB: TCheckBox;
    cbx_GuVJahr: TCheckBox;
    Lay_Progress: TLayout;
    lbl_Progress: TLabel;
    pg: TProgressBar;
    btn_Start: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    //procedure EditExit(Sender: TObject);
  private
    fSchnittstelleList: TDBSchnittstelleList;
    fDownloadKurse: TDownloadKurse;
    fCSVKurseToDB: TCSVKurseToDB;
    fSaveTSIWerte: TSaveTSIWerte;
    fSaveAbwProz: TSaveAbwProz;
    fSaveKursHochTief: TSaveKursHochTief;
    fSaveGuVJahr: TSaveGuVJahr;
    procedure StartProgress(aAnzahl: Integer);
    procedure Progress(aProgress: Integer; aCaption: string);
    procedure ProgressRefreshLabel(aCaption: string);
    procedure DestroyObjekte;
    procedure CreateObjekte;
    procedure CreateDownloadKurse;
    procedure CreateCSVKurseToDB;
    procedure CreateSaveTSIWerte;
    procedure CreateSaveAbwProz;
    procedure CreateSaveKursHochTief;
    procedure CreateSaveGuVJahr;
    procedure EditExit(Sender: TObject);
  public
    procedure LadeSchnittstellen;
    procedure Start;
  end;

var
  frm_Einstellung2: Tfrm_Einstellung2;

implementation

{$R *.fmx}

{ Tfrm_Einstellung2 }

uses
  Objekt.TSIServer2, System.IOUtils;

procedure Tfrm_Einstellung2.FormCreate(Sender: TObject);
begin
  fDownloadKurse     := nil;
  fCSVKurseToDB      := nil;
  fSaveTSIWerte      := nil;
  fSaveAbwProz       := nil;
  fSaveKursHochTief  := nil;
  fSaveGuVJahr       := nil;


  fSchnittstelleList := TDBSchnittstelleList.Create;
  edt_Downloadpfad.Text := TSIServer2.Ini.Allg.DownloadPfad;
  edt_Zielpfad.Text := TSIServer2.Ini.Allg.Zielpfad;
  edt_Server.Text := TSIServer2.Ini.Allg.Datenbankserver;
  edt_Uhrzeit.Text := TSIServer2.Ini.Allg.Uhrzeit;
  edt_KurseFDB.Text := TSIServer2.Ini.Kurse.Datenbankpfad + TSIServer2.Ini.Kurse.Datenbankname;
  edt_TSIFDB.Text := TSIServer2.Ini.TSI.Datenbankpfad + TSIServer2.Ini.TSI.Datenbankname;
  Lay_Progress.Visible := false;

  cbx_DownloadKurse.IsChecked := true;
  cbx_AbwProz.IsChecked := true;
  cbx_TSIWerte.IsChecked := true;
  cbx_KursHochTief.IsChecked := true;
  cbx_CSVKurseToDB.IsChecked := true;
  cbx_GuVJahr.IsChecked := true;

  edt_Uhrzeit.OnExit := EditExit;

end;

procedure Tfrm_Einstellung2.FormDestroy(Sender: TObject);
begin
  if fSchnittstelleList <> nil then
    FreeAndNil(fSchnittstelleList);
  DestroyObjekte;
end;


procedure Tfrm_Einstellung2.DestroyObjekte;
begin
  if fDownloadKurse <> nil then
    FreeAndNil(fDownloadKurse);
  if fCSVKurseToDB <> nil then
    FreeAndNil(fCSVKurseToDB);
  if fSaveTSIWerte <> nil then
    FreeAndNil(fSaveTSIWerte);
  if fSaveAbwProz <> nil then
    FreeAndNil(fSaveAbwProz);
  if fSaveKursHochTief <> nil then
    FreeAndNil(fSaveKursHochTief);
  if fSaveGuVJahr <> nil then
    FreeAndNil(fSaveGuVJahr);
end;



procedure Tfrm_Einstellung2.EditExit(Sender: TObject);
begin
  TSIServer2.Ini.Allg.DownloadPfad := edt_Downloadpfad.Text;
  TSIServer2.Ini.Allg.Zielpfad := edt_Zielpfad.Text;
  TSIServer2.Ini.Allg.Datenbankserver := edt_Server.Text;
  TSIServer2.Ini.Allg.Uhrzeit := edt_Uhrzeit.Text;
  TSIServer2.Ini.Kurse.Host := edt_Server.Text;
  TSIServer2.Ini.TSI.Host := edt_Server.Text;
  TSIServer2.Ini.Kurse.Datenbankpfad := '';
  TSIServer2.Ini.TSI.Datenbankpfad   := '';
  if edt_KurseFDB.Text > '' then
  begin
    TSIServer2.Ini.Kurse.Datenbankpfad := IncludeTrailingPathDelimiter(TPath.GetDirectoryName(edt_KurseFDB.Text));
    TSIServer2.Ini.Kurse.Datenbankname := TPath.GetFileName(edt_KurseFDB.Text);
  end;
  if edt_TSIFDB.Text > '' then
  begin
    TSIServer2.Ini.TSI.Datenbankpfad := IncludeTrailingPathDelimiter(TPath.GetDirectoryName(edt_TSIFDB.Text));
    TSIServer2.Ini.TSI.Datenbankname := TPath.GetFileName(edt_TSIFDB.Text);
  end;
  if cbo_Schnittstelle.ItemIndex = -1 then
    TSIServer2.Ini.Allg.Schnittstelle := '-1'
  else
  begin
    TSIServer2.Ini.Allg.Schnittstelle := IntToStr(TDBSchnittstelle(cbo_Schnittstelle.Items.Objects[cbo_Schnittstelle.ItemIndex]).Id);
  end;
end;


procedure Tfrm_Einstellung2.LadeSchnittstellen;
var
  i1: Integer;
  Id: Integer;
  Index: Integer;
begin
  Index := -1;
  if not TryStrToInt(TSIServer2.Ini.Allg.Schnittstelle, id) then
    id := -1;

  cbo_Schnittstelle.Clear;
  fSchnittstelleList.Trans := TSIServer2.IBT_TSI;
  fSchnittstelleList.ReadAll;
  for i1 := 0 to fSchnittstelleList.Count -1 do
  begin
    cbo_Schnittstelle.Items.AddObject(fSchnittstelleList.Item[i1].Schnittstellename, fSchnittstelleList.Item[i1]);
    if Id = fSchnittstelleList.Item[i1].Id then
      Index := i1;
  end;

  if Index > -1 then
    cbo_Schnittstelle.ItemIndex := Index;
end;




procedure Tfrm_Einstellung2.StartProgress(aAnzahl: Integer);
begin
  Lay_Progress.Visible := true;
  pg.Max := aAnzahl;
end;

procedure Tfrm_Einstellung2.CreateObjekte;
begin
  fDownloadKurse := nil;
  fCSVKurseToDB  := nil;
  fSaveTSIWerte  := nil;
  fSaveAbwProz   := nil;
  fSaveKursHochTief := nil;
  fSaveGuVJahr := nil;
end;


procedure Tfrm_Einstellung2.CreateDownloadKurse;
begin
  fDownloadKurse := TDownloadKurse.Create;
  fDownloadKurse.OnStartProgress := StartProgress;
  fDownloadKurse.OnProgress := Progress;
end;


procedure Tfrm_Einstellung2.CreateCSVKurseToDB;
begin
  fCSVKurseToDB := TCSVKurseToDB.Create;
  fCSVKurseToDB.OnStartProgress := StartProgress;
  fCSVKurseToDB.OnProgress := Progress;
  fCSVKurseToDB.OnProgressRefreshLabel := ProgressRefreshLabel;
end;

procedure Tfrm_Einstellung2.CreateSaveTSIWerte;
begin
  fSaveTSIWerte := TSaveTSIWerte.Create;
  fSaveTSIWerte.OnStartProgress := StartProgress;
  fSaveTSIWerte.OnProgress := Progress;
  fSaveTSIWerte.OnProgressRefreshLabel := ProgressRefreshLabel;
end;

procedure Tfrm_Einstellung2.CreateSaveAbwProz;
begin
  fSaveAbwProz := TSaveAbwProz.Create;
  fSaveAbwProz.OnStartProgress := StartProgress;
  fSaveAbwProz.OnProgress := Progress;
  fSaveAbwProz.OnProgressRefreshLabel := ProgressRefreshLabel;
end;

procedure Tfrm_Einstellung2.CreateSaveKursHochTief;
begin
  fSaveKursHochTief := TSaveKursHochTief.Create;
  fSaveKursHochTief.OnStartProgress := StartProgress;
  fSaveKursHochTief.OnProgress := Progress;
  fSaveKursHochTief.OnProgressRefreshLabel := ProgressRefreshLabel;
end;

procedure Tfrm_Einstellung2.CreateSaveGuVJahr;
begin
  fSaveGuVJahr := TSaveGuVJahr.Create;
  fSaveGuVJahr.OnStartProgress := StartProgress;
  fSaveGuVJahr.OnProgress := Progress;
  fSaveGuVJahr.OnProgressRefreshLabel := ProgressRefreshLabel;
end;



procedure Tfrm_Einstellung2.Progress(aProgress: Integer; aCaption: string);
begin
  pg.Value := aProgress;
  lbl_Progress.Text := aCaption;
  Application.ProcessMessages;
end;

procedure Tfrm_Einstellung2.ProgressRefreshLabel(aCaption: string);
begin
  lbl_Progress.Text := aCaption;
  Application.ProcessMessages;
end;

procedure Tfrm_Einstellung2.Start;
begin
  btn_StartClick(nil);
end;

procedure Tfrm_Einstellung2.btn_StartClick(Sender: TObject);
begin
//  btn_StartClick(nil);
end;




end.
