program PhotoOrga;

uses
  FastMM4 in '..\..\Komponenten\Log4d\FastMM\FastMM4.pas',
  FastMM4Messages in '..\..\Komponenten\Log4d\FastMM\Translations\German\by Thomas Speck\FastMM4Messages.pas',
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Form.PhotoOrga in 'Form\Form.PhotoOrga.pas' {frm_PhotoOrga},
  Objekt.PhotoOrga in 'Objekt\Objekt.PhotoOrga.pas',
  Objekt.Logger in 'Objekt\Objekt.Logger.pas',
  Objekt.IniPhotoOrga in 'Objekt\Objekt.IniPhotoOrga.pas',
  Objekt.IniBase in 'Objekt\Objekt.IniBase.pas',
  Objekt.IniFirebird in 'Objekt\Objekt.IniFirebird.pas',
  Datamodul.Database in 'Datamodul\Datamodul.Database.pas' {dm: TDataModule},
  Form.ChildBase in 'Form\Form.ChildBase.pas' {frm_ChildBase},
  Form.Base in 'Form\Form.Base.pas' {frm_Base},
  Form.IniFirebird in 'Form\Form.IniFirebird.pas' {frm_IniFirebird},
  Form.MainToolbar in 'Form\Form.MainToolbar.pas' {frm_MainToolbar},
  Datamodul.Bilder in 'Datamodul\Datamodul.Bilder.pas' {dm_Bilder: TDataModule},
  Form.Photo in 'Form\Form.Photo.pas' {frm_Photo},
  Form.PhotoBaum in 'Form\Form.PhotoBaum.pas' {frm_PhotoBaum},
  Form.Bilder in 'Form\Form.Bilder.pas' {frm_Bilder},
  Objekt.DBFeld in 'Objekt\Objekt.DBFeld.pas',
  Objekt.DBFeldList in 'Objekt\Objekt.DBFeldList.pas',
  DB.Basis in 'DB\DB.Basis.pas',
  DB.BasisList in 'DB\DB.BasisList.pas',
  DB.TBTransaction in 'DB\DB.TBTransaction.pas',
  DB.PhotoBaum in 'DB\DB.PhotoBaum.pas',
  DB.TBQuery in 'DB\DB.TBQuery.pas',
  DB.PhotoBaumList in 'DB\DB.PhotoBaumList.pas',
  Form.Einstellung in 'Form\Form.Einstellung.pas' {frm_Einstellung},
  Objekt.FormPointerList in 'Objekt\Objekt.FormPointerList.pas',
  Objekt.FormPointer in 'Objekt\Objekt.FormPointer.pas',
  Objekt.IniEinstellung in 'Objekt\Objekt.IniEinstellung.pas',
  Form.IniEinstellung in 'Form\Form.IniEinstellung.pas' {frm_IniEinstellung},
  Objekt.Types in 'Objekt\Objekt.Types.pas',
  DB.Photo in 'DB\DB.Photo.pas',
  DB.PhotoList in 'DB\DB.PhotoList.pas',
  Objekt.BilderEinlesen in 'Objekt\Objekt.BilderEinlesen.pas',
  Objekt.Datei in '..\Allgemein\Objekt\Objekt.Datei.pas',
  Objekt.DateiList in '..\Allgemein\Objekt\Objekt.DateiList.pas',
  Objekt.Dateisystem in '..\Allgemein\Objekt\Objekt.Dateisystem.pas',
  Objekt.Dateidatum in '..\Allgemein\Objekt\Objekt.Dateidatum.pas',
  DB.PhotoUndBaum in 'DB\DB.PhotoUndBaum.pas',
  DB.PhotoUndBaumList in 'DB\DB.PhotoUndBaumList.pas',
  VW.Base in 'View\VW.Base.pas',
  VW.PhotoUndBaum in 'View\VW.PhotoUndBaum.pas',
  VW.PhotoUndBaumList in 'View\VW.PhotoUndBaumList.pas',
  Form.Bild in 'Form\Form.Bild.pas' {frm_Bild},
  Form.BildOri in 'Form\Form.BildOri.pas' {frm_BildOri};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tdm_Bilder, dm_Bilder);
  Application.CreateForm(Tfrm_PhotoOrga, frm_PhotoOrga);
  Application.Run;
end.
