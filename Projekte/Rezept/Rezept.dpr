program Rezept;

uses
  FastMM4 in '..\Log4d\FastMM\FastMM4.pas',
  FastMM4Messages in '..\Log4d\FastMM\Translations\German\by Thomas Speck\FastMM4Messages.pas',
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Form.Rezept in 'Form\Form.Rezept.pas' {frm_Rezept},
  Objekt.Rezept in 'Objekt\Objekt.Rezept.pas',
  Objekt.Logger in 'Objekt\Objekt.Logger.pas' {,
  Objekt.Folderlocation in '..\Allgemein\Objekt\Objekt.Folderlocation.pas';

{$R *.res},
  Objekt.Folderlocation in '..\Allgemein\Objekt\Objekt.Folderlocation.pas',
  Objekt.Ini in '..\Allgemein\Objekt\Objekt.Ini.pas',
  Objekt.IniBase in 'Objekt\Objekt.IniBase.pas',
  Types.Folder in '..\Allgemein\Objekt\Types.Folder.pas',
  Objekt.IniFirebird in 'Objekt\Objekt.IniFirebird.pas',
  Objekt.IniRezept in 'Objekt\Objekt.IniRezept.pas',
  Form.IniFirebird in 'Form\Form.IniFirebird.pas' {frm_IniFirebird},
  Form.Main in 'Form\Form.Main.pas' {frm_Main},
  Datamodul.Bilder in 'Datamodul\Datamodul.Bilder.pas' {dm_Bilder: TDataModule},
  Objekt.Verschluesseln in '..\Allgemein\Objekt\Objekt.Verschluesseln.pas',
  Datamodul.Database in 'Datamodul\Datamodul.Database.pas' {dm: TDataModule},
  Form.Einstellung in 'Form\Form.Einstellung.pas' {frm_Einstellung},
  Form.MainChild in 'Form\Form.MainChild.pas' {frm_MainChild},
  Objekt.FormPointer in 'Objekt\Objekt.FormPointer.pas',
  Objekt.Basislist in '..\Allgemein\Objekt\Objekt.Basislist.pas',
  Objekt.FormPointerList in 'Objekt\Objekt.FormPointerList.pas',
  DB.FBBasis in 'Datenbank\DB.FBBasis.pas',
  Objekt.DBFeld in 'Objekt\Objekt.DBFeld.pas',
  Objekt.DBFeldList in 'Objekt\Objekt.DBFeldList.pas',
  Objekt.Allg in '..\Allgemein\Objekt\Objekt.Allg.pas',
  DB.Rezept in 'Datenbank\DB.Rezept.pas',
  DB.Basis in 'Datenbank\DB.Basis.pas',
  Form.RezeptNeu in 'Form\Form.RezeptNeu.pas' {frm_RezeptNeu},
  Form.Notiz in 'Form\Form.Notiz.pas' {frm_Notiz},
  Form.Zutaten in 'Form\Form.Zutaten.pas' {frm_Zutaten},
  DB.RzZt in 'Datenbank\DB.RzZt.pas',
  DB.Zutaten in 'Datenbank\DB.Zutaten.pas',
  DB.Zutatenlistenname in 'Datenbank\DB.Zutatenlistenname.pas',
  DB.RezeptZutaten in 'Datenbank\DB.RezeptZutaten.pas',
  DB.BasisList in 'Datenbank\DB.BasisList.pas',
  DB.ZutatenList in 'Datenbank\DB.ZutatenList.pas',
  DB.RezeptZutatenlist in 'Datenbank\DB.RezeptZutatenlist.pas',
  Form.Vergleichsliste in 'Form\Form.Vergleichsliste.pas' {frm_Vergleichsliste},
  Objekt.Vergleich in '..\Allgemein\Objekt\Vergleichsliste\Objekt.Vergleich.pas',
  Objekt.VergleichList in '..\Allgemein\Objekt\Vergleichsliste\Objekt.VergleichList.pas',
  Objekt.Abgleich in '..\Allgemein\Objekt\Vergleichsliste\Objekt.Abgleich.pas',
  Form.ZutatenListe in 'Form\Form.ZutatenListe.pas' {frm_Zutatenliste},
  Form.RezeptZutatenListe in 'Form\Form.RezeptZutatenListe.pas' {frm_Rezeptzutatenliste},
  Form.Rezeptlist in 'Form\Form.Rezeptlist.pas' {frm_Rezeptlist},
  DB.RezeptList in 'Datenbank\DB.RezeptList.pas',
  DB.RzZtList in 'Datenbank\DB.RzZtList.pas',
  Objekt.VergleichRezeptZutat in 'Objekt\Objekt.VergleichRezeptZutat.pas',
  Objekt.VergleichRezeptZutatList in 'Objekt\Objekt.VergleichRezeptZutatList.pas',
  Form.IniMySql in 'Form\Form.IniMySql.pas' {frm_IniMySql},
  Objekt.IniMySql in 'Objekt\Objekt.IniMySql.pas',
  Objekt.IniDatenbankAllgemein in 'Objekt\Objekt.IniDatenbankAllgemein.pas',
  Form.IniDatenbankAllgemein in 'Form\Form.IniDatenbankAllgemein.pas' {frm_IniDatenbankAllgemein},
  Objekt.MultiQueryFeld in '..\Allgemein\Objekt\Objekt.MultiQueryFeld.pas',
  Objekt.MultiQueryFeldList in '..\Allgemein\Objekt\Objekt.MultiQueryFeldList.pas',
  Objekt.MultiQuery in '..\Allgemein\Objekt\Objekt.MultiQuery.pas',
  Objekt.Global in '..\Allgemein\Objekt\Objekt.Global.pas',
  Objekt.MultiTrans in '..\Allgemein\Objekt\Objekt.MultiTrans.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //Application.CreateForm(Tdm, dm);
  //Application.CreateForm(Tdm_Bilder, dm_Bilder);
  Application.CreateForm(Tfrm_Rezept, frm_Rezept);
  Application.Run;
end.
