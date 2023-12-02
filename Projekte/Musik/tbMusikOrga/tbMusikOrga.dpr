program tbMusikOrga;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.MusikOrga in 'Form\Form.MusikOrga.pas' {frm_MusikOrga},
  Datenmodul.Database in 'Datenmodul\Datenmodul.Database.pas' {dm: TDataModule},
  Objekt.MusikOrga in 'Objekt\Objekt.MusikOrga.pas',
  Objekt.Logger in 'Objekt\Objekt.Logger.pas',
  Objekt.IniMusikOrga in 'Objekt\Objekt.IniMusikOrga.pas',
  Objekt.IniFirebird in 'Objekt\Objekt.IniFirebird.pas',
  Objekt.IniBase in 'Objekt\Objekt.IniBase.pas',
  Form.Einstellung.Firebird in 'Form\Form.Einstellung.Firebird.pas' {frm_EinstellungFirebird};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_MusikOrga, frm_MusikOrga);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfrm_EinstellungFirebird, frm_EinstellungFirebird);
  Application.Run;
end.
