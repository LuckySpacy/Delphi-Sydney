unit Form.Reportdesigner;

interface

{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Objekt.Dateien, frxDesgn,
  frxClass, frxPreview, Vcl.ExtCtrls, Vcl.ShellAnimations, frxIBXComponents,
  System.Actions, Vcl.ActnList, frxExportImage, frxExportBaseDialog,
  frxDBXComponents, frxRich, frxCrypt, frxChart, frxDMPExport, frxGradient,
  frxChBox, frxCellularTextObject, frxMap, frxGaugeView, frxCross, frxBarcode,
  frxTableObject, frxZipCode;

type
  Tfrm_Reportdesigner = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    NewMI: TMenuItem;
    NewReportMI: TMenuItem;
    NewPageMI: TMenuItem;
    NewDialogMI: TMenuItem;
    N9: TMenuItem;
    OpenMI: TMenuItem;
    mnu_Open2: TMenuItem;
    SaveMI: TMenuItem;
    save1: TMenuItem;
    SaveasMI: TMenuItem;
    N1: TMenuItem;
    PreviewMI: TMenuItem;
    PagesettingsMI: TMenuItem;
    N2: TMenuItem;
    ExitMI: TMenuItem;
    ESt1: TMenuItem;
    RecentFiles1: TMenuItem;
    N10: TMenuItem;
    mnu_LastFiles: TMenuItem;
    mnu_File1: TMenuItem;
    mnu_File2: TMenuItem;
    mnu_File3: TMenuItem;
    mnu_File4: TMenuItem;
    mnu_File5: TMenuItem;
    mnu_File6: TMenuItem;
    mnu_File7: TMenuItem;
    mnu_File8: TMenuItem;
    mnu_File9: TMenuItem;
    mnu_File10: TMenuItem;
    Edit1: TMenuItem;
    UndoMI: TMenuItem;
    RedoMI: TMenuItem;
    N3: TMenuItem;
    CutMI: TMenuItem;
    CopyMI: TMenuItem;
    PasteMI: TMenuItem;
    N4: TMenuItem;
    DeleteMI: TMenuItem;
    DeletePageMI: TMenuItem;
    SelectAllMI: TMenuItem;
    GroupMI: TMenuItem;
    UngroupMI: TMenuItem;
    EditMI: TMenuItem;
    N6: TMenuItem;
    FindMI: TMenuItem;
    ReplaceMI: TMenuItem;
    FindNextMI: TMenuItem;
    N5: TMenuItem;
    BringtoFrontMI: TMenuItem;
    SendtoBackMI: TMenuItem;
    Report1: TMenuItem;
    DataMI: TMenuItem;
    VariablesMI: TMenuItem;
    StylesMI: TMenuItem;
    ReportOptionsMI: TMenuItem;
    View1: TMenuItem;
    ToolbarsMI: TMenuItem;
    StandardMI: TMenuItem;
    TextMI: TMenuItem;
    FrameMI: TMenuItem;
    AlignmentPaletteMI: TMenuItem;
    ObjectInspectorMI: TMenuItem;
    DataTreeMI: TMenuItem;
    ReportTreeMI: TMenuItem;
    N7: TMenuItem;
    RulersMI: TMenuItem;
    GuidesMI: TMenuItem;
    DeleteGuidesMI: TMenuItem;
    N8: TMenuItem;
    OptionsMI: TMenuItem;
    Help1: TMenuItem;
    HelpContentsMI: TMenuItem;
    AboutFastReportMI: TMenuItem;
    frxDesigner1: TfrxDesigner;
    frxReport1: TfrxReport;
    frxPreview1: TfrxPreview;
    Panel1: TPanel;
    ActionList1: TActionList;
    actOpen: TAction;
    frxRichObject1: TfrxRichObject;
    frxDBXComponents1: TfrxDBXComponents;
    frxIBXComponents1: TfrxIBXComponents;
    frxBMPExport1: TfrxBMPExport;
    frxTIFFExport1: TfrxTIFFExport;
    frxPNGExport1: TfrxPNGExport;
    frxZipCodeObject1: TfrxZipCodeObject;
    frxReportTableObject1: TfrxReportTableObject;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxCrossObject1: TfrxCrossObject;
    frxGaugeObject1: TfrxGaugeObject;
    frxMapObject1: TfrxMapObject;
    frxReportCellularTextObject1: TfrxReportCellularTextObject;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxGradientObject1: TfrxGradientObject;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxChartObject1: TfrxChartObject;
    frxCrypt1: TfrxCrypt;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnu_Open2Click(Sender: TObject);
    procedure mnu_LoadReportClick(Sender: TObject);
    procedure RecentFiles1Click(Sender: TObject);
    procedure save1Click(Sender: TObject);
    procedure SaveMIClick(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure ESt1Click(Sender: TObject);
    procedure ExitMIClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fFileItemList: TList;
    fCaption: string;
    fIniPath: string;
    fIniName: string;
    fLastFiles: TStringList;
    fLastFilesName: string;
    fCurrentFilename: string;
    fDateien: TDateien;
    fDs: TfrxDesignerForm;
    procedure LoadLastFilesInMenu;
    function LoadReport(aFileName: string): Boolean;
    //procedure LoadFile(Sender: TObject);
    procedure SetFileName(aFileName: string);
    function GetDatabase(aName: string): TfrxIBXDatabase;
  public
  end;

var
  frm_Reportdesigner: Tfrm_Reportdesigner;

implementation

{$R *.dfm}

uses
  Konstanten.Dateien, frxRes, frxCustomDB, System.UITypes;

procedure Tfrm_Reportdesigner.actOpenExecute(Sender: TObject);
begin
  mnu_Open2Click(Sender);
end;

procedure Tfrm_Reportdesigner.ESt1Click(Sender: TObject);
begin
  if fds.OpenDialog.Execute then
  begin
    LoadReport(fDs.OpenDialog.FileName);
  end;
end;


procedure Tfrm_Reportdesigner.ExitMIClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Reportdesigner.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frxReport1.Designer.Close;
end;

procedure Tfrm_Reportdesigner.FormCreate(Sender: TObject);
begin  //
  fDateien := TDateien.Create;
  fFileItemList := TList.Create;
  fIniPath := IncludeTrailingBackslash(fDateien.GetShellFolder(cCSIDL_APPDATA)) + 'frReportDesigner';
  fIniName := fIniPath + '\frReportDesigner.ini';
  fLastFilesName := fIniPath + '\LastFiles.txt';
  fCurrentFilename := '';
  if not DirectoryExists(fIniPath) then
    ForceDirectories(fIniPath);
  fLastFiles := TStringList.Create;
  if FileExists(fLastFilesName) then
    fLastFiles.LoadFromFile(fLastFilesName);
  fCaption := Caption;
end;

procedure Tfrm_Reportdesigner.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDateien);
  FreeAndNil(fFileItemList);
end;

procedure Tfrm_Reportdesigner.FormShow(Sender: TObject);
  procedure AddMenuItem(aName: string);
  var
    i1: Integer;
    MI: TMenuItem;
  begin
    for i1 := 0 to MainMenu1.Items.Count - 1 do
    begin
      MI := MainMenu1.Items[i1];
      if SameText(MI.Name, aName) then
      begin
        fFileItemList.Add(MI);
        exit;
      end;
    end;
  end;

var
  Designer: TfrxDesignerForm;
  //i1, i2: Integer;
  MenuItem: TMenuItem;
  //NewItem: TMenuItem;
  //MI: TMenuItem;

begin
  // prevent saving/restoring a report when previewing. This will destroy
  // objects that are loaded in the designer and will lead to AV.
  frxReport1.EngineOptions.DestroyForms := False;
  // set the custom preview
  frxReport1.Preview := frxPreview1;
  // display the designer
  frxReport1.DesignReportInPanel(Panel1);

  // set FR images for our menu
  MainMenu1.Images := frxResources.MainButtonImages;
  // get the reference to the Designer
  Designer := TfrxDesignerForm(frxReport1.Designer);

  // assign FR actions to our menu items
  NewMI.Action := Designer.NewItemCmd;
  NewReportMI.Action := Designer.NewReportCmd;
  NewPageMI.Action := Designer.NewPageCmd;
  NewDialogMI.Action := Designer.NewDialogCmd;
  //OpenMI.Action := actOpen;
  //OpenMI.Action := Designer.OpenCmd;
  SaveMI.Action := Designer.SaveCmd;
  //SaveasMI.Action := Designer.SaveAsCmd;
  PreviewMI.Action := Designer.PreviewCmd;
  PageSettingsMI.Action := Designer.PageSettingsCmd;

  UndoMI.Action := Designer.UndoCmd;
  RedoMI.Action := Designer.RedoCmd;
  CutMI.Action := Designer.CutCmd;
  CopyMI.Action := Designer.CopyCmd;
  PasteMI.Action := Designer.PasteCmd;
  DeleteMI.Action := Designer.DeleteCmd;
  DeletePageMI.Action := Designer.DeletePageCmd;
  SelectAllMI.Action := Designer.SelectAllCmd;
  GroupMI.Action := Designer.GroupCmd;
  UngroupMI.Action := Designer.UngroupCmd;
  EditMI.Action := Designer.EditCmd;
  FindMI.Action := Designer.FindCmd;
  ReplaceMI.Action := Designer.ReplaceCmd;
  FindNextMI.Action := Designer.FindNextCmd;
  BringtoFrontMI.Action := Designer.BringToFrontCmd;
  SendtoBackMI.Action := Designer.SendToBackCmd;

  DataMI.Action := Designer.ReportDataCmd;
  VariablesMI.Action := Designer.VariablesCmd;
  StylesMI.Action := Designer.ReportStylesCmd;
  ReportOptionsMI.Action := Designer.ReportOptionsCmd;

  ToolbarsMI.Action := Designer.ToolbarsCmd;
  StandardMI.Action := Designer.StandardTBCmd;
  TextMI.Action := Designer.TextTBCmd;
  FrameMI.Action := Designer.FrameTBCmd;
  AlignmentPaletteMI.Action := Designer.AlignTBCmd;
  ObjectInspectorMI.Action := Designer.InspectorTBCmd;
  DataTreeMI.Action := Designer.DataTreeTBCmd;
  ReportTreeMI.Action := Designer.ReportTreeTBCmd;
  RulersMI.Action := Designer.ShowRulersCmd;
  GuidesMI.Action := Designer.ShowGuidesCmd;
  DeleteGuidesMI.Action := Designer.DeleteGuidesCmd;
  OptionsMI.Action := Designer.OptionsCmd;

  HelpContentsMI.Action := Designer.HelpContentsCmd;
  AboutFastReportMI.Action := Designer.AboutCmd;


  MenuItem := MainMenu1.Items.Find('File');
  MenuItem := MenuItem.Find('Last Reports');
  fFileItemList.Add(MenuItem.Find('file1'));
  fFileItemList.Add(MenuItem.Find('file2'));
  fFileItemList.Add(MenuItem.Find('file3'));
  fFileItemList.Add(MenuItem.Find('file4'));
  fFileItemList.Add(MenuItem.Find('file5'));
  fFileItemList.Add(MenuItem.Find('file6'));
  fFileItemList.Add(MenuItem.Find('file7'));
  fFileItemList.Add(MenuItem.Find('file8'));
  fFileItemList.Add(MenuItem.Find('file9'));
  fFileItemList.Add(MenuItem.Find('file10'));

  fDs := Designer;
  fds.OpenB.Action := actOpen;

  LoadLastFilesInMenu;

  Designer.SaveCmd.OnExecute := SaveMIClick;

 // ShowMessage(IntToStr(Designer.OpenCmd.ImageIndex));
end;


procedure Tfrm_Reportdesigner.LoadLastFilesInMenu;
var
  i1, i2: Integer;
begin
  for i1 := 0 to fFileItemList.Count - 1 do
    TMenuItem(fFileItemList.Items[i1]).Visible := false;

  i2 := 0;
  //for i1 := Designer.RecentFiles.Count - 1 downto 0 do
  for i1 := fLastFiles.Count - 1 downto 0 do
  begin
    if i2 > 9 then
      break;

    if not FileExists(fLastFiles.Strings[i1]) then
    begin
      fLastFiles.Delete(i1);
      continue;
    end;
    TMenuItem(fFileItemList.Items[i2]).Visible := true;
    TMenuItem(fFileItemList.Items[i2]).Caption := fLastFiles.Strings[i1];
    TMenuItem(fFileItemList.Items[i2]).OnClick := mnu_LoadReportClick;
    inc(i2);
  end;

end;


function Tfrm_Reportdesigner.LoadReport(aFileName: string): Boolean;
var
  db: TfrxIBXDatabase;
begin
  Result := false;
  if not FileExists(aFileName) then
  begin
    ShowMessage('Datei existiert nicht');
    exit;
  end;
  fds.LoadFile(aFileName, true);
  SetFileName(aFileName);
  db := GetDatabase('db');
  if Assigned(db) then
    db.Connected := false;
  Result := true;
end;

procedure Tfrm_Reportdesigner.mnu_LoadReportClick(Sender: TObject);
var
  s: string;
begin
  s := TMenuItem(Sender).Caption;
  if s = '' then
    exit;
  if s[1] = '&' then
    s := copy(s, 2, Length(s));
  if FileExists(s) then
    LoadReport(s);
end;


procedure Tfrm_Reportdesigner.mnu_Open2Click(Sender: TObject);
begin
  if fds.OpenDialog.Execute then
  begin
    LoadReport(fDs.OpenDialog.FileName);
  end;
end;

procedure Tfrm_Reportdesigner.RecentFiles1Click(Sender: TObject);
begin
  ShowMessage(fds.RecentFiles.Text);
end;

procedure Tfrm_Reportdesigner.save1Click(Sender: TObject);
begin
  if fCurrentFilename > '' then
  begin
    fds.SaveAsCmd.Execute;
    //fds.SaveDialog.InitialDir := ExtractFilePath(fCurrentFilename);
    //fds.SaveDialog.FileName := fCurrentFilename;
  end;

  if fDs.SaveFile(true, false) then
    fDs.SaveCmd.Execute;
    {
  if fDs.SaveFile(true, false) then
    SetFilename(ds.SaveDialog.FileName);
    }
end;

procedure Tfrm_Reportdesigner.SaveMIClick(Sender: TObject);
var
  Path: string;
  db: TfrxIBXDatabase;
begin
  Path := ExtractFilePath(fCurrentFilename);
  if not DirectoryExists(Path) then
  begin
    MessageDlg('Pfad "' + Path + '" existiert nicht!', mtError, [mbOk], 0);
    exit;
  end;
  db := GetDatabase('db');
  if Assigned(db) then
    db.Connected := false;
  fDs.SaveFile(false, false)
end;

procedure Tfrm_Reportdesigner.SetFileName(aFileName: string);
var
  i1: Integer;
begin
  fCurrentFilename := aFileName;
  for i1 := fLastFiles.Count - 1 downto 0 do
  begin
    if SameText(fLastFiles.Strings[i1], aFileName) then
      fLastFiles.Delete(i1);
  end;
  fLastFiles.Add(aFileName);
  fLastFiles.SaveToFile(fLastFilesName);
  Caption := fCaption + ' (' + aFileName + ')';
  LoadLastFilesInMenu;
end;

{
procedure Tfrm_Reportdesigner.LoadFile(Sender: TObject);
var
  FileName: string;
begin
  if Sender is TMenuItem then
  begin
    FileName := StringReplace(TMenuItem(Sender).Caption, '&', '', [rfReplaceAll]);
    LoadReport(FileName);
  end;
end;
}

function Tfrm_Reportdesigner.GetDatabase(aName: string): TfrxIBXDatabase;
var
  x: TfrxComponent;
begin
  Result := nil;
  x := frxReport1.FindObject(aName);
  if Assigned(x) then
  begin
    if x is TfrxIBXDatabase then
      Result := TfrxIBXDatabase(x);
  end;
end;


end.
