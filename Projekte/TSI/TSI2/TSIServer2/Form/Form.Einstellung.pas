unit Form.Einstellung;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.DateTimeCtrls, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TMSCustomEdit,
  FMX.TMSEdit, FMX.Edit, System.IOUtils, DB.Schnittstelle, DB.SchnittstelleList,
  Objekt.DownloadKurse, FMX.Layouts, Objekt.CSVKurseToDB, Objekt.SaveTSIWerte,
  fmx.Platform, Objekt.SaveAbwProz, Objekt.SaveKursHochTief, Objekt.SaveGuVJahr,
  DB.Dateiformat, Objekt.SaveEPS_YahooFinance;

type
  Tfrm_Einstellung = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edt_Uhrzeit: TTimeEdit;
    Label2: TLabel;
    cbo_Schnittstelle: TComboBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edt_Downloadpfad: TEdit;
    edt_Zielpfad: TEdit;
    edt_Server: TEdit;
    edt_KurseFDB: TEdit;
    edt_TSIFDB: TEdit;
    btn_Start: TButton;
    Lay_Progress: TLayout;
    lbl_Progress: TLabel;
    pg: TProgressBar;
    Layout1: TLayout;
    cbx_DownloadKurse: TCheckBox;
    cbx_AbwProz: TCheckBox;
    cbx_TSIWerte: TCheckBox;
    cbx_KursHochTief: TCheckBox;
    cbx_CSVKurseToDB: TCheckBox;
    cbx_GuVJahr: TCheckBox;
    lbl_NaechsterStart: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
  private
    fSchnittstelleList: TDBSchnittstelleList;
    fDownloadKurse: TDownloadKurse;
    fCSVKurseToDB: TCSVKurseToDB;
    fSaveTSIWerte: TSaveTSIWerte;
    fSaveAbwProz: TSaveAbwProz;
    fSaveKursHochTief: TSaveKursHochTief;
    fSaveGuVJahr: TSaveGuVJahr;
    fDBDateiFormat : TDBDateiFormat;
    fSaveEPS: TSaveEPS;
    procedure StartProgress(aAnzahl: Integer);
    procedure Progress(aProgress: Integer; aCaption: string);
    procedure ProgressRefreshLabel(aCaption: string);
    procedure CreateObjekte;
    procedure DestroyObjekte;
    procedure CreateSaveEPS;
    procedure CreateDownloadKurse;
    procedure CreateCSVKurseToDB;
    procedure CreateSaveTSIWerte;
    procedure CreateSaveAbwProz;
    procedure CreateSaveKursHochTief;
    procedure CreateSaveGuVJahr;
  public
    procedure LadeSchnittstellen;
    procedure Start;
    procedure setEditToOnExit;
  end;

var
  frm_Einstellung: Tfrm_Einstellung;

implementation

{$R *.fmx}

uses
  Objekt.TSIServer2;


procedure Tfrm_Einstellung.FormCreate(Sender: TObject);
begin  //
  //fSchnittstelleList := nil;
  fDownloadKurse     := nil;
  fCSVKurseToDB      := nil;
  fSaveTSIWerte      := nil;
  fSaveAbwProz       := nil;
  fSaveKursHochTief  := nil;
  fSaveGuVJahr       := nil;
  fSaveEPS           := nil;

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

  fDBDateiFormat := TDBDateiFormat.Create(nil);



end;

procedure Tfrm_Einstellung.FormDestroy(Sender: TObject);
begin //
  if fSchnittstelleList <> nil then
    FreeAndNil(fSchnittstelleList);
  FreeAndNil(fDBDateiFormat);
  DestroyObjekte;
end;

procedure Tfrm_Einstellung.CreateObjekte;
begin
  fDownloadKurse := nil;
  fCSVKurseToDB  := nil;
  fSaveTSIWerte  := nil;
  fSaveAbwProz   := nil;
  fSaveKursHochTief := nil;
  fSaveGuVJahr := nil;
  fSaveEPS := nil;
          {
  fDownloadKurse := TDownloadKurse.Create;
  fDownloadKurse.OnStartProgress := StartProgress;
  fDownloadKurse.OnProgress := Progress;

  fCSVKurseToDB := TCSVKurseToDB.Create;
  fCSVKurseToDB.OnStartProgress := StartProgress;
  fCSVKurseToDB.OnProgress := Progress;
  fCSVKurseToDB.OnProgressRefreshLabel := ProgressRefreshLabel;

  fSaveTSIWerte := TSaveTSIWerte.Create;
  fSaveTSIWerte.OnStartProgress := StartProgress;
  fSaveTSIWerte.OnProgress := Progress;
  fSaveTSIWerte.OnProgressRefreshLabel := ProgressRefreshLabel;

  fSaveAbwProz := TSaveAbwProz.Create;
  fSaveAbwProz.OnStartProgress := StartProgress;
  fSaveAbwProz.OnProgress := Progress;
  fSaveAbwProz.OnProgressRefreshLabel := ProgressRefreshLabel;

  fSaveKursHochTief := TSaveKursHochTief.Create;
  fSaveKursHochTief.OnStartProgress := StartProgress;
  fSaveKursHochTief.OnProgress := Progress;
  fSaveKursHochTief.OnProgressRefreshLabel := ProgressRefreshLabel;

  fSaveGuVJahr := TSaveGuVJahr.Create;
  fSaveGuVJahr.OnStartProgress := StartProgress;
  fSaveGuVJahr.OnProgress := Progress;
  fSaveGuVJahr.OnProgressRefreshLabel := ProgressRefreshLabel;
           }
end;


procedure Tfrm_Einstellung.CreateSaveEPS;
begin
  fSaveEPS := TSaveEPS.Create;
  fSaveEPS.OnStartProgress := StartProgress;
  fSaveEPS.OnProgress := Progress;
end;

procedure Tfrm_Einstellung.CreateDownloadKurse;
begin
  fDownloadKurse := TDownloadKurse.Create;
  fDownloadKurse.OnStartProgress := StartProgress;
  fDownloadKurse.OnProgress := Progress;
end;

procedure Tfrm_Einstellung.CreateCSVKurseToDB;
begin
  fCSVKurseToDB := TCSVKurseToDB.Create;
  fCSVKurseToDB.OnStartProgress := StartProgress;
  fCSVKurseToDB.OnProgress := Progress;
  fCSVKurseToDB.OnProgressRefreshLabel := ProgressRefreshLabel;
end;

procedure Tfrm_Einstellung.CreateSaveTSIWerte;
begin
  fSaveTSIWerte := TSaveTSIWerte.Create;
  fSaveTSIWerte.OnStartProgress := StartProgress;
  fSaveTSIWerte.OnProgress := Progress;
  fSaveTSIWerte.OnProgressRefreshLabel := ProgressRefreshLabel;
end;

procedure Tfrm_Einstellung.CreateSaveAbwProz;
begin
  fSaveAbwProz := TSaveAbwProz.Create;
  fSaveAbwProz.OnStartProgress := StartProgress;
  fSaveAbwProz.OnProgress := Progress;
  fSaveAbwProz.OnProgressRefreshLabel := ProgressRefreshLabel;
end;

procedure Tfrm_Einstellung.CreateSaveKursHochTief;
begin
  fSaveKursHochTief := TSaveKursHochTief.Create;
  fSaveKursHochTief.OnStartProgress := StartProgress;
  fSaveKursHochTief.OnProgress := Progress;
  fSaveKursHochTief.OnProgressRefreshLabel := ProgressRefreshLabel;
end;

procedure Tfrm_Einstellung.CreateSaveGuVJahr;
begin
  fSaveGuVJahr := TSaveGuVJahr.Create;
  fSaveGuVJahr.OnStartProgress := StartProgress;
  fSaveGuVJahr.OnProgress := Progress;
  fSaveGuVJahr.OnProgressRefreshLabel := ProgressRefreshLabel;
end;




procedure Tfrm_Einstellung.DestroyObjekte;
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
  if fSaveEPS <> nil then
    FreeAndNil(fSaveEPS);
end;

procedure Tfrm_Einstellung.LadeSchnittstellen;
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

procedure Tfrm_Einstellung.Progress(aProgress: Integer; aCaption: string);
begin
  pg.Value := aProgress;
  lbl_Progress.Text := aCaption;
  Application.ProcessMessages;
end;

procedure Tfrm_Einstellung.ProgressRefreshLabel(aCaption: string);
begin
  lbl_Progress.Text := aCaption;
  Application.ProcessMessages;
end;

procedure Tfrm_Einstellung.setEditToOnExit;
begin
  edt_Uhrzeit.OnExit := EditExit;
  edt_Downloadpfad.OnExit := EditExit;
  edt_Zielpfad.OnExit     := EditExit;
  edt_Server.OnExit       := EditExit;
  edt_KurseFDB.OnExit     := EditExit;
  edt_TSIFDB.OnExit       := EditExit;
end;

procedure Tfrm_Einstellung.Start;
begin
  btn_StartClick(nil);
end;

procedure Tfrm_Einstellung.StartProgress(aAnzahl: Integer);
begin
  Lay_Progress.Visible := true;
  pg.Max := aAnzahl;
end;

procedure Tfrm_Einstellung.btn_StartClick(Sender: TObject);
var
  //Liste: TStringDynArray;
  //i1: Integer;
  Cur: TCursor;
begin

  if cbo_Schnittstelle.ItemIndex < 0 then
    exit;

  Cur := Cursor;
  try
    Cursor := crHourglass;
    CreateObjekte;
    {
  Liste := TDirectory.GetFiles(edt_Downloadpfad.Text, '*.csv');

  for i1 := low(Liste) to High(Liste) do
  begin
    TSIServer2.Protokoll.List.Add(Liste[i1]);
  end;
  exit;

  fDownloadKurse.Start(edt_Downloadpfad.Text, TDBSchnittstelle(cbo_Schnittstelle.Items.Objects[cbo_Schnittstelle.ItemIndex]).Link);
  Lay_Progress.Visible := false;
  }

  //TSIServer2.Protokoll.write('Funktion', 'Value');
  //exit;
  //fCSVKurseToDB.Start(edt_Downloadpfad.Text);
    //fSaveTSIWerte.Start;


    TSIServer2.Protokoll.write('Start', FormatDateTime('dd.mm.yyyy hh:nn:ss', now) );

    fDBDateiFormat.Trans := TSIServer2.IBT_TSI;
    fDBDateiFormat.ReadSSId(TDBSchnittstelle(cbo_Schnittstelle.Items.Objects[cbo_Schnittstelle.ItemIndex]).id);
    if fDBDateiFormat.id = 0 then
    begin
      ShowMessage('Dateiformat fehlt');
      exit;
    end;


    CreateSaveEPS;
    fSaveEPS.Start(TDBSchnittstelle(cbo_Schnittstelle.Items.Objects[cbo_Schnittstelle.ItemIndex]).Id);

    CreateDownloadKurse;
    if cbx_DownloadKurse.IsChecked then
      fDownloadKurse.Start(edt_Downloadpfad.Text,
                           TDBSchnittstelle(cbo_Schnittstelle.Items.Objects[cbo_Schnittstelle.ItemIndex]).Link,
                           TDBSchnittstelle(cbo_Schnittstelle.Items.Objects[cbo_Schnittstelle.ItemIndex]).Id);
    FreeAndNil(fDownloadKurse);

    CreateCSVKurseToDB;
    fCSVKurseToDB.DateiFormat.PosDatum      := fDBDateiFormat.PosDatum;
    fCSVKurseToDB.DateiFormat.PosEroeffnung := fDBDateiFormat.PosEroeffnung;
    fCSVKurseToDB.DateiFormat.PosHoch       := fDBDateiFormat.PosHoch;
    fCSVKurseToDB.DateiFormat.PosTief       := fDBDateiFormat.PosTief;
    fCSVKurseToDB.DateiFormat.PosSchluss    := fDBDateiFormat.PosSchluss;
    fCSVKurseToDB.DateiFormat.PosVolumen    := fDBDateiFormat.PosVolumen;
    fCSVKurseToDB.DateiFormat.DatumFormat   := fDBDateiFormat.DatumFormat;
    fCSVKurseToDB.DateiFormat.Trennzeichen  := fDBDateiFormat.Trennzeichen;

    if cbx_CSVKurseToDB.IsChecked then
      fCSVKurseToDB.Start(edt_Downloadpfad.Text);
    FreeAndNil(fCSVKurseToDB);

    CreateSaveTSIWerte;
    if cbx_TSIWerte.IsChecked then
      fSaveTSIWerte.Start;
    FreeAndNil(fSaveTSIWerte);

    CreateSaveAbwProz;
    if cbx_AbwProz.IsChecked then
      fSaveAbwProz.Start;
    FreeAndNil(fSaveAbwProz);

    CreateSaveKursHochTief;
    if cbx_KursHochTief.IsChecked then
      fSaveKursHochTief.Start;
    FreeAndNil(fSaveKursHochTief);

    CreateSaveGuVJahr;
    if cbx_GuVJahr.IsChecked then
      fSaveGuVJahr.Start;
    FreeAndNil(fSaveGuVJahr);

    lbl_Progress.Text := 'Fertig';
    pg.Value := 0;

  finally
    DestroyObjekte;
    Cursor := Cur;
  end;

end;

procedure Tfrm_Einstellung.EditExit(Sender: TObject);
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

end.
