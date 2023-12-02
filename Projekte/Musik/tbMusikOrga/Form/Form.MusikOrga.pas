unit Form.MusikOrga;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
  Objekt.MusikOrga;

type
  Tfrm_MusikOrga = class(TForm)
    MainMenu: TMainMenu;
    mnu_Einstellung: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_MusikOrga: Tfrm_MusikOrga;

implementation

{$R *.fmx}

procedure Tfrm_MusikOrga.FormCreate(Sender: TObject);
begin
  MusikOrga := TMusikOrga.Create;
  MusikOrga.Ini.Firebird.Datenbankname := 'MusikOrga.fdb';
  MusikOrga.Ini.Firebird.Host := 'localhost';
  MusikOrga.Ini.Firebird.Datenbankpfad := 'd:\Firebird\Entwicklung-Datenbank\tbMusikOrga\';
  MusikOrga.Ini.Firebird.Username := 'sysdba';
  MusikOrga.Ini.Firebird.Passwort := 'masterkey';
end;

procedure Tfrm_MusikOrga.FormDestroy(Sender: TObject);
begin
  FreeAndNil(MusikOrga);
end;

end.
