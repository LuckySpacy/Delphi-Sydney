unit Form.IniDatenbankAllgemein;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  Tfrm_IniDatenbankAllgemein = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label6: TLabel;
    RadioGroup1: TRadioGroup;
    rb_Firebird: TRadioButton;
    rb_MySql: TRadioButton;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure rb_FirebirdClick(Sender: TObject);
    procedure rb_MySqlClick(Sender: TObject);
  private
    procedure Save;
  public
  end;

var
  frm_IniDatenbankAllgemein: Tfrm_IniDatenbankAllgemein;

implementation

{$R *.dfm}

uses
  Objekt.Rezept;

procedure Tfrm_IniDatenbankAllgemein.FormCreate(Sender: TObject);
begin
  rb_Firebird.Checked := Rezept.Ini.DatenbankAllgemein.UseFireBird;
  rb_MySql.Checked    := Rezept.Ini.DatenbankAllgemein.UseMySql;
end;

procedure Tfrm_IniDatenbankAllgemein.rb_FirebirdClick(Sender: TObject);
begin
  save;
end;

procedure Tfrm_IniDatenbankAllgemein.rb_MySqlClick(Sender: TObject);
begin
  save;
end;

procedure Tfrm_IniDatenbankAllgemein.Save;
begin
  Rezept.Ini.DatenbankAllgemein.UseFireBird := rb_Firebird.Checked;
  Rezept.Ini.DatenbankAllgemein.UseMySql    := rb_MySql.Checked;
end;


end.
