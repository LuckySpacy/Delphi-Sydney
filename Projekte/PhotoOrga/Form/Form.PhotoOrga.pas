unit Form.PhotoOrga;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Objekt.PhotoOrga, Form.IniFirebird,
  Vcl.ExtCtrls, Form.MainToolbar, Form.Photo, Form.Einstellung, Objekt.FormPointerList,
  Objekt.FormPointer, Vcl.Menus, Form.ChildBase, Objekt.BilderEinlesen;

type
  Tfrm_PhotoOrga = class(TForm)
    pnl_Toolbar: TPanel;
    pnl_Forms: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fFormMainToolbar: Tfrm_MainToolbar;
    fFormPhoto: Tfrm_Photo;
    fFormEinstellung : Tfrm_Einstellung;
    fFormVerlauf: TList;
    fFormList: TFormPointerList;
    fBilderEinlesen: TBilderEinlesen;
    procedure CreateFormEinstellung;
    procedure CreateFormPhoto;
    procedure ShowIniFirebird;
    procedure Schliessen(Sender: TObject);
    procedure ShowEinstellung(Sender: TObject);
    procedure RegisterForm(aFormPointer, aPointerMainMenu: Pointer);
    procedure FormAnzeigen(Sender: TObject);
    procedure CreateForms(aForm: TForm);
    procedure SetzeMainToolbar(aForm: TForm);
    procedure BilderEinlesen(Sender: TObject);
  public
  end;

var
  frm_PhotoOrga: Tfrm_PhotoOrga;

implementation

{$R *.dfm}

uses
  Datamodul.Database, fmx.Types;


procedure Tfrm_PhotoOrga.FormCreate(Sender: TObject);
begin

  fFormEinstellung := nil;
  fFormList    := TFormPointerList.Create;
  fFormVerlauf := TList.Create;


  PhotoOrga := TPhotoOrga.Create;
  PhotoOrga.Log.Info('Tfrm_PhotoOrga.FormCreate(Sender: TObject);');


  dm.Host  := PhotoOrga.Ini.Firebird.Host;
  dm.Port  := 3050;
  dm.Datenbankname := PhotoOrga.Ini.Firebird.Datenbankname;
  dm.Datenbankpfad := PhotoOrga.Ini.Firebird.Datenbankpfad;
  dm.Username      := PhotoOrga.Ini.Firebird.Username;
  dm.Passwort      := PhotoOrga.Ini.Firebird.Passwort;

  if (Trim(PhotoOrga.Ini.Firebird.Datenbankpfad) = '')
  or (not DirectoryExists(PhotoOrga.Ini.Firebird.Datenbankpfad))
  or (not FileExists(IncludeTrailingPathDelimiter(PhotoOrga.Ini.Firebird.Datenbankpfad) + PhotoOrga.Ini.Firebird.Datenbankname)) then
  begin
    ShowIniFirebird;
  end;
  if not dm.ConnectFirebirdDB then
    ShowIniFirebird;
  if not dm.CheckFirebird then
    ShowIniFirebird;


  fFormMainToolbar := Tfrm_MainToolbar.Create(Self);
  fFormMainToolbar.Parent := pnl_Toolbar;
  fFormMainToolbar.Align  := alClient;
  fFormMainToolbar.OnSchliessen := Schliessen;
  fFormMainToolbar.OnEinstellung := ShowEinstellung;
  fFormMainToolbar.OnBilderEinlesen := BilderEinlesen;
  fFormMainToolbar.Show;

  {
  fFormPhoto := Tfrm_Photo.Create(Self);
  fFormPhoto.Parent := pnl_Forms;
  fFormPhoto.Align  := alClient;
  fFormPhoto.Show;
  RegisterForm(Pointer(fFormPhoto), nil);
  }

  CreateFormPhoto;

  fBilderEinlesen := TBilderEinlesen.Create;


end;

procedure Tfrm_PhotoOrga.FormDestroy(Sender: TObject);
var
  i1: Integer;
  x: TForm;
begin

  log.d('Tfrm_PhotoOrga.FormDestroy -> Start');
  for i1 := 0 to fFormList.Count -1 do
  begin
    x := TForm(fFormList.Item[i1].Form);
    FreeAndNil(x);
  end;

  FreeAndNil(PhotoOrga);
  FreeAndNil(fFormMainToolbar);
  //FreeAndNil(fFormPhoto);
  //FreeAndNil(fFormEinstellung);
  FreeAndNil(fFormList);
  FreeAndNil(fFormVerlauf);
  FreeAndNil(fBilderEinlesen);

  log.d('Tfrm_PhotoOrga.FormDestroy -> Ende');

end;



procedure Tfrm_PhotoOrga.FormShow(Sender: TObject);
begin //
  fFormPhoto.Anzeigen;
end;

procedure Tfrm_PhotoOrga.FormAnzeigen(Sender: TObject);
var
  i1: Integer;
begin
  for i1 := 0 to fFormList.Count -1 do
  begin
    TForm(fFormList.Item[i1].Form).Visible := false;
    if TForm(Sender).Name = TForm(fFormList.Item[i1].Form).Name then
      fFormVerlauf.Add(fFormList.Item[i1]);
  end;
end;


procedure Tfrm_PhotoOrga.CreateForms(aForm: TForm);
begin
  aForm.Parent := pnl_Forms;
  aForm.Align  := alClient;
  Tfrm_ChildBase(aForm).OnAnzeigen := FormAnzeigen;
end;



procedure Tfrm_PhotoOrga.CreateFormEinstellung;
begin
  fFormEinstellung := Tfrm_Einstellung.Create(Self);
  CreateForms(fFormEinstellung);
  RegisterForm(Pointer(fFormEinstellung), nil);
end;

procedure Tfrm_PhotoOrga.CreateFormPhoto;
begin
  fFormPhoto := Tfrm_Photo.Create(Self);
  CreateForms(fFormPhoto);
  RegisterForm(Pointer(fFormPhoto), nil);
end;



procedure Tfrm_PhotoOrga.RegisterForm(aFormPointer, aPointerMainMenu: Pointer);
var
  x: TFormPointer;
begin
  x := fFormList.add;
  x.Form := aFormPointer;
  x.MainMenu := aPointerMainMenu;
  if aPointerMainMenu <> nil then
    Self.Menu := TMainMenu(aPointerMainMenu)
  else
    Self.Menu:= nil;
end;

procedure Tfrm_PhotoOrga.Schliessen(Sender: TObject);
var
  FormPointer: TFormPointer;
begin
  if fFormVerlauf.Count <= 1 then
  begin
    close;
    exit;
  end;
  fFormVerlauf.Delete(fFormVerlauf.Count-1);
  FormPointer := TFormPointer(fFormVerlauf.Items[fFormVerlauf.Count-1]);
  SetzeMainToolbar(TForm(FormPointer.Form));
  Tfrm_ChildBase(FormPointer.Form).Show;
end;

procedure Tfrm_PhotoOrga.SetzeMainToolbar(aForm: TForm);
begin
  if SameText(aForm.Name, 'frm_Photo') then
  begin
    fFormMainToolbar.btn_Einstellung.Enabled := true;
  end;
  if SameText(aForm.Name, 'frm_Einstellung') then
  begin
    fFormMainToolbar.btn_Einstellung.Enabled := false;
  end;
end;

procedure Tfrm_PhotoOrga.ShowEinstellung(Sender: TObject);
begin
  //ShowIniFirebird;
  if fFormEinstellung = nil then
    CreateFormEinstellung;
  SetzeMainToolbar(TForm(fFormEinstellung));
  fFormEinstellung.Anzeigen;
end;

procedure Tfrm_PhotoOrga.ShowIniFirebird;
var
  Form: Tfrm_IniFirebird;
begin
  Form := Tfrm_IniFirebird.Create(Self);
  try
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
  {
  if not dm.ConnectFirebirdDB then
    close;
  if not dm.CheckFirebird then
    close;
    }
end;

procedure Tfrm_PhotoOrga.BilderEinlesen(Sender: TObject);
var
  Cur: TCursor;
begin
  Cur := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    fBilderEinlesen.Read(PhotoOrga.Ini.Einstellung.Bilderpfad);
  finally
    Screen.Cursor := Cur;
  end;
end;


end.
