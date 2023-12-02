unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, nfsButton, Vcl.ExtCtrls,
  datamodul.Bilder, Form.MainChild, Form.Vergleichsliste, Form.Rezeptlist,
  DB.Rezept;

type
  Tfrm_Main = class(Tfrm_MainChild)
    Panel1: TPanel;
    btn_Einstellung: TnfsButton;
    btn_Close: TnfsButton;
    btn_neu: TnfsButton;
    btn_RezeptDelete: TnfsButton;
    btn_RezeptEdit: TnfsButton;
    procedure btn_EinstellungClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_neuClick(Sender: TObject);
    procedure btn_RezeptEditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_RezeptDeleteClick(Sender: TObject);
  private
    fFormRezeptlist: Tfrm_Rezeptlist;
    fDBRezept: TDBRezept;
    procedure ConnectFirebirdDB;
    procedure ConnectMySql;
    procedure RezeptBearbeiten(Sender: TObject);
  public
    procedure ShowEinstellung;
    procedure ShowNeuesRezept;
  end;

var
  frm_Main: Tfrm_Main;

implementation

{$R *.dfm}

uses
  System.UITypes, Objekt.Rezept,
  Form.IniFirebird, Form.Einstellung, Datamodul.Database, Form.RezeptNeu,
  Objekt.Global;

procedure Tfrm_Main.FormCreate(Sender: TObject);
begin
  inherited;

  if Rezept.Ini.DatenbankAllgemein.UseFirebird then
  begin
    Global.UseFirebird := true;
    ConnectFirebirdDB;
  end;

  if Rezept.Ini.DatenbankAllgemein.UseMySql then
  begin
    Global.UseMySql := true;
    ConnectMySql;
  end;

  fFormRezeptlist := Tfrm_Rezeptlist.Create(nil);
  fFormRezeptList.Parent := Self;
  fFormRezeptList.Align  := alClient;
  fFormRezeptList.BorderStyle := bsNone;
  fFormRezeptList.OnRezeptBearbeiten := RezeptBearbeiten;
  fFormRezeptList.Show;

  fDBRezept := TDBRezept.Create(nil);
  fDBRezept.Trans := dm.getTrans;


end;

procedure Tfrm_Main.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fFormRezeptList);
  FreeAndNil(fDBRezept);
  //inherited;
end;

procedure Tfrm_Main.FormShow(Sender: TObject);
begin  //
  inherited;
end;



procedure Tfrm_Main.btn_EinstellungClick(Sender: TObject);
var
  PointerEinstellung: Pointer;
begin
  if Assigned(fOnCreateEinstellung) then
    fOnCreateEinstellung(Self, PointerEinstellung);
  TForm(PointerEinstellung).Show;
end;




procedure Tfrm_Main.btn_neuClick(Sender: TObject);
var
  PointerRezeptNeu: Pointer;
begin
  if Assigned(fOnCreateRezeptNeu) then
    fOnCreateRezeptNeu(Self, PointerRezeptNeu);
  Tfrm_RezeptNeu(PointerRezeptNeu).setRzId(0);
  TForm(PointerRezeptNeu).Show;
end;

procedure Tfrm_Main.btn_RezeptDeleteClick(Sender: TObject);
begin
  if fFormRezeptlist.AktualRezept = nil then
    exit;
  if MessageDlg('Möchten Sie wirklich das Rezept löschen?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;
  fDBRezept.Read(fFormRezeptlist.AktualRezept.Id);
  fDBRezept.Delete;
  fFormRezeptlist.RefreshGrid(0);
end;

procedure Tfrm_Main.btn_RezeptEditClick(Sender: TObject);
begin
  RezeptBearbeiten(Sender);
end;

procedure Tfrm_Main.RezeptBearbeiten(Sender: TObject);
var
  PointerRezeptNeu: Pointer;
begin
  if fFormRezeptlist.AktualRezept = nil then
    exit;

  if Assigned(fOnCreateRezeptNeu) then
    fOnCreateRezeptNeu(Self, PointerRezeptNeu);
  Tfrm_RezeptNeu(PointerRezeptNeu).setRzId(fFormRezeptlist.AktualRezept.Id);
  TForm(PointerRezeptNeu).Show;
end;


procedure Tfrm_Main.ConnectFirebirdDB;
begin
  dm.IB_Rezept.Databasename := Trim(Rezept.Ini.Firebird.Host) +':' +
                               Trim(IncludeTrailingPathDelimiter(Rezept.Ini.Firebird.Datenbankpfad)) +
                               Trim(Rezept.Ini.Firebird.Datenbankname);
  dm.IB_Rezept.Params.Clear;
  dm.IB_Rezept.Params.Add('user_name=' + Rezept.Ini.Firebird.Username);
  dm.IB_Rezept.Params.Add('password=' + Rezept.Ini.Firebird.Passwort);
  //dm.IB_Rezept.Params.Add('default character set UTF8');
  dm.IB_Rezept.Params.Add('lc_ctype=UTF8');

  dm.IB_Rezept.LoginPrompt := false;
  try
    dm.CheckFirebird;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      MessageDlg('Verbindung zur Datenbank fehlgeschlagen', mtError, [mbOk], 0);
      exit;
    end;
  end;
end;


procedure Tfrm_Main.ConnectMySql;
begin
  dm.DB_MySql.Params.Clear;
  dm.DB_MySql.Params.Add('DriverID=MySQL');
  dm.DB_MySql.Params.Add('Server=' + Rezept.Ini.MySql.Host);
  dm.DB_MySql.Params.Add('Port=' + Rezept.Ini.MySql.Port);
  dm.DB_MySql.Params.Add('Database=' + Rezept.Ini.MySql.Datenbankname);
  dm.DB_MySql.Params.Add('User_Name=' + Rezept.Ini.MySql.Username);
  dm.DB_MySql.Params.Add('Password=' + Rezept.Ini.MySql.Passwort);
  dm.DB_MySql.Params.Add('CharacterSet=UTF8');

  try
    dm.DB_MySql.Open;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      MessageDlg('Verbindung zur Datenbank fehlgeschlagen', mtError, [mbOk], 0);
      exit;
    end;
  end;
end;


procedure Tfrm_Main.ShowEinstellung;
var
  Form: Tfrm_Einstellung;
begin
  Form := Tfrm_Einstellung.Create(nil);
  try
    //if Assigned(fOnCreateNewForm) then
    //  fOnCreateNewForm(Form);
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;

end;


procedure Tfrm_Main.ShowNeuesRezept;
var
  Form: Tfrm_RezeptNeu;
begin
  Form := Tfrm_RezeptNeu.Create(nil);
  try
    Form.setRzId(0);
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;

end;

procedure Tfrm_Main.btn_CloseClick(Sender: TObject);
begin
  inherited;
  close;
end;


end.
