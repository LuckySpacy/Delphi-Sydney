unit Form.SydneyInstaller;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvEdit, AdvEdBtn,
  AdvDirectoryEdit, Objekt.Ini, Vcl.ExtCtrls, Objekt.Registry, Objekt.Bibliothek,
  LockProvider, ExecOnTime, NFSCustomEdit, NFSCustomMaskEdit,
  NFSMaskButtonedEdit, NFSDatePicker, NFSComboBox, clisted, nfsCheckListEdit,
  Ueberschriftenpanel_norm, NewFrontiers.Vcl.Ueberschrift, NFSEditFloat,
  NFSEditBtn, nfsEditAutoComplete, Vcl.ComCtrls, NFSMonthCalendar, nfsButton,
  NFSRichViewHunspell, NFSRichViewtoolbar, Vcl.Menus, NFSRichviewPopUp,
  RVScroll, RichView, RVEdit, nfsRichView, NfsLabel;

type
  Tfrm_SydneyInstaller = class(TForm)
    edt_Optimapfad: TAdvDirectoryEdit;
    Label1: TLabel;
    pnl_Button: TPanel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    fPfad: string;
    fIniFilename: string;
    fIni: TASSIni;
    fReg: TAssRegistry;
    fBibliothek: TBibliothek;
    fBibliothek64: TBibliothek;
    procedure Installieren;
    function CheckPfad: Boolean;
  public
  end;

var
  frm_SydneyInstaller: Tfrm_SydneyInstaller;

implementation

{$R *.dfm}


procedure Tfrm_SydneyInstaller.FormCreate(Sender: TObject);
begin
  fPfad := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  fIniFilename := fPfad + 'SydneyInstaller.Ini';
  fIni := TASSIni.Create;
  fReg := TAssRegistry.Create;
  fBibliothek   := TBibliothek.create;
  fBibliothek64 := TBibliothek.Create;
end;

procedure Tfrm_SydneyInstaller.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fIni);
  FreeAndNil(fReg);
  FreeAndNil(fBibliothek);
  FreeAndNil(fBibliothek64);
end;

procedure Tfrm_SydneyInstaller.FormShow(Sender: TObject);
begin
  edt_Optimapfad.Text := fIni.ReadIni(fIniFilename, 'Installer', 'Optimapfad', '');
end;


procedure Tfrm_SydneyInstaller.Button1Click(Sender: TObject);
begin
  Installieren;
end;

function Tfrm_SydneyInstaller.CheckPfad: Boolean;
begin
  Result := false;
  if not DirectoryExists(edt_Optimapfad.Text) then
  begin
    ShowMessage('Optimapfad existiert nicht.');
    edt_Optimapfad.SetFocus;
    exit;
  end;
  if not DirectoryExists(IncludeTrailingPathDelimiter(edt_Optimapfad.Text) + 'Komponenten\') then
  begin
    ShowMessage('Komponentenpfad "' + IncludeTrailingPathDelimiter(edt_Optimapfad.Text) + 'Komponenten\" existiert nicht.');
    edt_Optimapfad.SetFocus;
    exit;
  end;
  Result := true;
end;

procedure Tfrm_SydneyInstaller.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fIni.WriteIni(fIniFilename, 'Installer', 'Optimapfad', edt_Optimapfad.Text);
end;


procedure Tfrm_SydneyInstaller.Installieren;
var
  i1: Integer;
  s: string;
begin
  if not CheckPfad then
    exit;
//  caption := fReg.ReadRegistry(HKEY_CURRENT_USER_, 'Software\Embarcadero\BDS\21.0\Environment Variables', 'Optima', '');
  fReg.WriteRegistry(HKEY_CURRENT_USER_, 'Software\Embarcadero\BDS\21.0\Environment Variables', 'Optima', IncludeTrailingPathDelimiter(edt_Optimapfad.Text));
  fReg.WriteRegistry(HKEY_CURRENT_USER_, 'Software\Embarcadero\BDS\21.0\Environment Variables', 'Komponenten', IncludeTrailingPathDelimiter(edt_Optimapfad.Text) + 'Komponenten\');

  s := fReg.ReadRegistry(HKEY_CURRENT_USER_, 'Software\Embarcadero\BDS\21.0\Library\Win32', 'Search Path', '');
  if s[1] = ';' then
    s := copy(s, 2, Length(s));
  fBibliothek.DelimitedText := s;
  fBibliothek.Add('$(Komponenten)\ZipMaster\');
  fBibliothek.Add('$(Komponenten)\Drag and Drop\Source\');
  fBibliothek.Add('$(Optima)\Komponenten\VirtualTreeView\Source\');
  fBibliothek.Add('$(Komponenten)\ASS\LockProvider\');
  fBibliothek.Add('$(Komponenten)\ASS\ExecOnTime\');
  fBibliothek.Add('$(Komponenten)\ASS\Ueberschriftenpanel\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSChecklistedit\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSComboBox\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSDatePicker\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSEditAutoComplete\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSEditBtn\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSEditFloat\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Vcl\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Commands\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Configuration\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Database\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Entity\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Events\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.GUI\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Reflection\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Tapi\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Threading\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Utility\');
  fBibliothek.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Validation\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSLabel\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichView\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewPopUp\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewEdit\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewHunspell\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSButton\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewHunspell\Property\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewToolbar\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewEdit\Objekt\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewToolbar\Property\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewEdit\Form\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewToolbar\Objekt\');
  fBibliothek.Add('$(Komponenten)\ASS\NFSRichViewToolbar\Form\');
  fBibliothek.Add('$(Komponenten)\ASS\ProcessQueue\');
  fBibliothek.Add('$(Komponenten)\ASS\GridAdapter\');
  fBibliothek.Add('$(Komponenten)\RegExp\Source\');
  fBibliothek.Add('$(Komponenten)\delphi-rest-client-api-master\src\');

  fReg.WriteRegistry(HKEY_CURRENT_USER_, 'Software\Embarcadero\BDS\21.0\Library\Win32', 'Search Path', fBibliothek.getText);

  fBibliothek64.Clear;
  fBibliothek64.DelimitedText := fReg.ReadRegistry(HKEY_CURRENT_USER_, 'Software\Embarcadero\BDS\21.0\Library\Win', 'Search Path', '');
  fBibliothek64.Add('$(Komponenten)\ZipMaster\');
  fBibliothek64.Add('$(Komponenten)\Drag and Drop\Source\');
  fBibliothek64.Add('$(Optima)\Komponenten\VirtualTreeView\Source\');
  fBibliothek64.Add('$(Komponenten)\ASS\LockProvider\');
  fBibliothek64.Add('$(Komponenten)\ASS\ExecOnTime\');
  fBibliothek64.Add('$(Komponenten)\ASS\Ueberschriftenpanel\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSChecklistedit\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSComboBox\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSDatePicker\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSEditAutoComplete\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSEditBtn\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSEditFloat\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Vcl\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Commands\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Configuration\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Database\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Entity\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Events\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.GUI\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Reflection\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Tapi\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Threading\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Utility\');
  fBibliothek64.Add('$(Komponenten)\ASS\NfsFramework\NewFrontiers.Validation\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSLabel\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichView\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewPopUp\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewEdit\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewHunspell\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSButton\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewHunspell\Property\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewToolbar\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewEdit\Objekt\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewToolbar\Property\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewEdit\Form\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewToolbar\Objekt\');
  fBibliothek64.Add('$(Komponenten)\ASS\NFSRichViewToolbar\Form\');
  fBibliothek64.Add('$(Komponenten)\ASS\ProcessQueue\');
  fBibliothek64.Add('$(Komponenten)\ASS\GridAdapter\');
  fBibliothek64.Add('$(BDSLIB)\$(Platform)\release');
  fBibliothek64.Add('$(Komponenten)\RegExp\Source\');
  fBibliothek64.Add('$(Komponenten)\delphi-rest-client-api-master\src\');
  fBibliothek64.Add('$(Komponenten)\tlb\');
  fBibliothek64.Add('$(Komponenten)\Drag and Drop\Demos\Outlook\MAPI\');
  fBibliothek64.Add('$(Komponenten)\HtmlViewer\');

  fBibliothek.LadeMadCollectionPfade;
  for i1 := 0 to fBibliothek.MadCollectionList.Count -1 do
    fBibliothek64.Add(fBibliothek.MadCollectionList[i1]);

  fBibliothek.LadeTMSPfade;
  for i1 := 0 to fBibliothek.TMSList.Count -1 do
    fBibliothek64.Add(fBibliothek.TMSList[i1]);

  fBibliothek.LadeRichview;
  for i1 := 0 to fBibliothek.RichviewList.Count -1 do
    fBibliothek64.Add(fBibliothek.RichviewList[i1]);

  fBibliothek.LadeGnosticePfade;
  for i1 := 0 to fBibliothek.GnosticeList.Count -1 do
    fBibliothek64.Add(fBibliothek.GnosticeList[i1]);

  fBibliothek.LadeFastreportPfade;
  for i1 := 0 to fBibliothek.FastreportList.Count -1 do
    fBibliothek64.Add(fBibliothek.FastreportList[i1]);

  fReg.WriteRegistry(HKEY_CURRENT_USER_, 'Software\Embarcadero\BDS\21.0\Library\Win64', 'Search Path', fBibliothek64.getText);


//  caption := fBibliothek.getText;

  ShowMessage('Installation erfolgreich abgeschlossen');
end;


end.
