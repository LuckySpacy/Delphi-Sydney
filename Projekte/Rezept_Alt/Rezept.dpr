program Rezept;

uses
  FastMM4 in '..\Log4d\FastMM\FastMM4.pas',
  FastMM4Messages in '..\Log4d\FastMM\Translations\German\by Thomas Speck\FastMM4Messages.pas',
  Vcl.Forms,
  Form.Rezept in 'Form\Form.Rezept.pas' {frm_Rezept},
  Datenmodul.DM in 'Datenbank\Datenmodul.DM.pas' {dm: TDataModule},
  Objekt.Logger in 'Objekt\Objekt.Logger.pas',
  Objekt.Rezept in 'Objekt\Objekt.Rezept.pas',
  Objekt.Verschluesseln in 'Objekt\Objekt.Verschluesseln.pas',
  Objekt.IniEinstellung in 'Objekt\Objekt.IniEinstellung.pas',
  Objekt.Ini in 'Objekt\Objekt.Ini.pas',
  Objekt.Filefunction in 'Objekt\Objekt.Filefunction.pas',
  Objekt.Folderlocation in 'Objekt\Objekt.Folderlocation.pas',
  c.Folder in 'const\c.Folder.pas',
  Form.Einstellung in 'Form\Form.Einstellung.pas' {frm_Einstellung},
  Form.Uebersicht in 'Form\Form.Uebersicht.pas' {frm_Uebersicht},
  Frame.Kategorie in 'Frame\Frame.Kategorie.pas' {fra_Kategorie},
  Form.NeuesRezept in 'Form\Form.NeuesRezept.pas' {frm_NeuesRezept},
  Objekt.DBFeldList in 'Objekt\Objekt.DBFeldList.pas',
  Objekt.BasisList in 'Objekt\Objekt.BasisList.pas',
  Objekt.DBFeld in 'Objekt\Objekt.DBFeld.pas',
  DB.Basis in 'Datenbank\DB.Basis.pas',
  DB.Rezept in 'Datenbank\DB.Rezept.pas',
  DB.RezeptList in 'Datenbank\DB.RezeptList.pas',
  DB.BasisList in 'Datenbank\DB.BasisList.pas',
  Frame.Rezepttitel in 'Frame\Frame.Rezepttitel.pas' {fra_Rezepttitel};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfrm_Rezept, frm_Rezept);
  Application.CreateForm(Tfra_Rezepttitel, fra_Rezepttitel);
  Application.Run;
end.
