unit Form.MusikOrga;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Einstellung, Vcl.Menus, IBX.IBDatabase,
  Form.Audiofile, Objekt.AudioFileList, sys.Objekt;

type
  Tfrm_MusikOrga = class(TForm)
    MainMenu: TMainMenu;
    men_Einstellung: TMenuItem;
    mnu_Eigenschaft: TMenuItem;
    mnu_Audiodatei: TMenuItem;
    mnu_AudiodateiEinlesen: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure men_EinstellungClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnu_EigenschaftClick(Sender: TObject);
    procedure mnu_AudiodateiEinlesenClick(Sender: TObject);
  private
    fFormEinstellung: Tfrm_Einstellung;
    fFormAudiofile: Tfrm_Audiofile;
    fFormList: TList;
    fTrans: TIBTransaction;
    fAlleAudioDateien: TAudioFileList;
    procedure ShowEinstellung;
    procedure setAllFormsUnvisible;
    procedure ShowDateiEigenschaft;
  public
  end;

var
  frm_MusikOrga: Tfrm_MusikOrga;

implementation

{$R *.dfm}

uses
  Objekt.MusikOrga, Datamodul.Database;

procedure Tfrm_MusikOrga.FormCreate(Sender: TObject);
begin
  MyFunc := TSys.Create;
  MusikOrga := TMusikOrga.Create;
  //MusikOrga.Ini.Firebird.Datenbankname := 'MusikOrga.fdb';
  //MusikOrga.Ini.Firebird.Host := 'localhost';
  //MusikOrga.Ini.Firebird.Datenbankpfad := 'd:\Firebird\Entwicklung-Datenbank\tbMusikOrga\';
  //MusikOrga.Ini.Firebird.Username := 'sysdba';
  //MusikOrga.Ini.Firebird.Passwort := 'masterkey';
  fFormEinstellung := nil;
  fFormAudiofile   := nil;
  fFormList := TList.Create;
  fTrans := TIBTransaction.Create(Self);
  fTrans.DefaultDatabase := dm.IB_MusikOrga;
  fAlleAudioDateien := TAudioFileList.Create;
end;

procedure Tfrm_MusikOrga.FormDestroy(Sender: TObject);
begin
  FreeAndNil(MusikOrga);
  FreeAndNil(fFormList);
  FreeAndNil(fTrans);
  if fFormAudiofile <> nil then
    FreeAndNil(fFormAudiofile);
  FreeAndNil(fAlleAudioDateien);
  FreeAndNil(MyFunc);
end;

procedure Tfrm_MusikOrga.FormShow(Sender: TObject);
begin
  dm.setEinstellung;
  dm.Connect;
  if not dm.IB_MusikOrga.Connected then
    ShowEinstellung;
end;

procedure Tfrm_MusikOrga.men_EinstellungClick(Sender: TObject);
begin
  ShowEinstellung;
end;

procedure Tfrm_MusikOrga.mnu_AudiodateiEinlesenClick(Sender: TObject);
var
  i1: Integer;
begin
  for i1 := 0 to  do

  //MyFunc.Disk.GetAllFiles(
end;

procedure Tfrm_MusikOrga.mnu_EigenschaftClick(Sender: TObject);
begin
  ShowDateiEigenschaft;
end;

procedure Tfrm_MusikOrga.setAllFormsUnvisible;
var
  i1: Integer;
begin
  for i1 := 0 to fFormList.Count -1 do
    TForm(fFormList.Items[i1]).Visible := false;
end;

procedure Tfrm_MusikOrga.ShowEinstellung;
begin
  setAllFormsUnvisible;
  if fFormEinstellung = nil then
  begin
    fFormEinstellung := Tfrm_Einstellung.Create(Self);
    fFormEinstellung.Parent := Self;
    fFormEinstellung.Align  := alClient;
    fFormEinstellung.Trans  := fTrans;
  end;
  fFormEinstellung.Show;
end;

procedure Tfrm_MusikOrga.ShowDateiEigenschaft;
begin
  setAllFormsUnvisible;
  if fFormAudiofile = nil then
  begin
    fFormAudiofile := Tfrm_Audiofile.Create(Self);
    fFormAudiofile.Parent := Self;
    fFormAudiofile.Align  := alClient;
    fFormAudiofile.Trans  := fTrans;
  end;
  fFormAudiofile.Show;
  //fFormAudiofile.LadeAudio('D:\Musik\save\Achim Reichel\Melancholie und Sturmflut (Bonus Tracks Edition)\Aloha Heja He.mp3');
  fFormAudiofile.LadeAudio('D:\Musik\save\Achim Reichel\Melancholie und Sturmflut (Bonus Tracks Edition)\Aloha Heja He.m4a');
end;

end.
