unit Form.Rezept;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Main, Form.MainChild, Objekt.FormPointerList,
  Objekt.FormPointer, Vcl.Menus, Datamodul.Database, Datamodul.Bilder;

type
  Tfrm_Rezept = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fFormMain: Tfrm_Main;
    fFormVerlauf: TFormPointerList;
    fFormDestroyList: TList;
    procedure RegisterForm(aFormPointer, aPointerMainMenu: Pointer);
    procedure UnvisibleForm;
    procedure ClearDestroyList;
    procedure MainChildFormClosed(Sender: TObject);
    procedure RezeptClosed(Sender: TObject);
    procedure CreateEinstellung(Sender: TObject; var aPointer: Pointer);
    procedure CreateRezeptNeu(Sender: TObject; var aPointer: Pointer);
  public
  end;

var
  frm_Rezept: Tfrm_Rezept;

implementation

{$R *.dfm}

uses
  Objekt.Rezept, Form.Einstellung, Form.RezeptNeu;




procedure Tfrm_Rezept.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not fFormMain.Visible then
  begin
    CanClose := false;
    exit;
  end;
end;

procedure Tfrm_Rezept.FormCreate(Sender: TObject);
begin //
  dm := Tdm.Create(nil);
  dm_Bilder := Tdm_Bilder.Create(nil);
  fFormVerlauf := TFormPointerList.Create;
  fFormDestroyList := TList.Create;
  fFormMain := Tfrm_Main.Create(Self);
  fFormMain.Parent := Self;
  fFormMain.Align  := alClient;
  fFormMain.OnCreateEinstellung := CreateEinstellung;
  fFormMain.OnCloseMainChild := RezeptClosed;
  fFormMain.OnCreateRezeptNeu := CreateRezeptNeu;
  RegisterForm(Pointer(fFormMain), nil);
  fFormMain.Show;
end;

procedure Tfrm_Rezept.FormDestroy(Sender: TObject);
begin //
  FreeAndNil(fFormVerlauf);
  ClearDestroyList;
  FreeAndNil(fFormDestroyList);
  FreeAndNil(fFormMain);
  FreeAndNil(dm);
  FreeAndNil(dm_Bilder);
end;

procedure Tfrm_Rezept.FormShow(Sender: TObject);
begin
  Rezept.Log.Info('Hurra es funktioniert');
end;


procedure Tfrm_Rezept.MainChildFormClosed(Sender: TObject);
var
  Form: TForm;
  x: TFormPointer;
begin
  ClearDestroyList;
  x := fFormVerlauf.Item[fFormVerlauf.Count -1];
  Form := TForm(x.Form);
  fFormVerlauf.Delete(fFormVerlauf.Count -1);
  Form.Visible := false;
  fFormDestroyList.Add(Form);
  x := fFormVerlauf.Item[fFormVerlauf.Count -1];
  Form := TForm(x.Form);
  Self.Menu := nil;
  if x.MainMenu <> nil then
  begin
    Form.Menu := nil;
    Self.Menu := x.MainMenu;
  end;
  Caption := Form.Caption;
  Form.Visible := true;
end;

procedure Tfrm_Rezept.RegisterForm(aFormPointer, aPointerMainMenu: Pointer);
var
  x: TFormPointer;
begin
  x := fFormVerlauf.add;
  x.Form := aFormPointer;
  x.MainMenu := aPointerMainMenu;
  if aPointerMainMenu <> nil then
    Self.Menu := TMainMenu(aPointerMainMenu)
  else
    Self.Menu:= nil;
end;

procedure Tfrm_Rezept.RezeptClosed(Sender: TObject);
begin
  close;
end;

procedure Tfrm_Rezept.UnvisibleForm;
var
  Form: TForm;
  x: TFormPointer;
begin
  x := fFormVerlauf.Item[fFormVerlauf.Count-1];
  Form := TForm(x.Form);
  Form.Visible := false;
end;

procedure Tfrm_Rezept.ClearDestroyList;
var
  i1: Integer;
  Form: TForm;
begin
  for i1 := fFormDestroyList.Count -1  downto 0 do
  begin
    Form := TForm(fFormDestroyList.Items[i1]);
    fFormDestroyList.Delete(i1);
    FreeAndNil(Form);
  end;
end;




procedure Tfrm_Rezept.CreateEinstellung(Sender: TObject; var aPointer: Pointer);
var
  Form: Tfrm_Einstellung;
begin
  UnvisibleForm;
  Form := Tfrm_Einstellung.Create(nil);
  Form.BorderStyle := bsNone;
  Form.Parent := Self;
  Form.Align  := alClient;
  Form.OnCloseMainChild := MainChildFormClosed;
  RegisterForm(Pointer(Form), Pointer(nil));
  Caption := Form.Caption;
  aPointer := Pointer(Form);
end;


procedure Tfrm_Rezept.CreateRezeptNeu(Sender: TObject; var aPointer: Pointer);
var
  Form: Tfrm_RezeptNeu;
begin
  UnvisibleForm;
  Form := Tfrm_RezeptNeu.Create(nil);
  Form.BorderStyle := bsNone;
  Form.Parent := Self;
  Form.Align  := alClient;
  Form.OnCloseMainChild := MainChildFormClosed;
  RegisterForm(Pointer(Form), Pointer(nil));
  Caption := Form.Caption;
  aPointer := Pointer(Form);
end;

end.
