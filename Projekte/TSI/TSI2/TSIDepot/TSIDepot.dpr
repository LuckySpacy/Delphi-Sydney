program TSIDepot;

uses
  System.StartUpCopy,
  FMX.Forms,
  {$IFDEF WIN32}
  DB.Basis in '..\Datenbank\DB.Basis.pas',
  DB.BasisList in '..\Datenbank\DB.BasisList.pas',
  Objekt.DBFeld in '..\Objekt\Objekt.DBFeld.pas',
  Objekt.DBFeldList in '..\Objekt\Objekt.DBFeldList.pas',
  View.Base in '..\View\View.Base.pas',
  {$ENDIF WIN32}
  Form.MainTSIDepot in 'Form\Form.MainTSIDepot.pas' {frm_MainTSIDepot},
  Form.TSIDepot in 'Form\Form.TSIDepot.pas' {frm_TSIDepot},
  dm.Style in 'Datenmodul\dm.Style.pas' {dm_Style: TDataModule},
  Rest.Benutzer in '..\Rest\Rest.Benutzer.pas',
  Rest.Basis in '..\Rest\Rest.Basis.pas',
  Mobil.Feld in '..\..\Allgemein\Mobil\Mobil.Feld.pas',
  Mobil.BasisList in '..\..\Allgemein\Mobil\Mobil.BasisList.pas',
  Mobil.FeldList in '..\..\Allgemein\Mobil\Mobil.FeldList.pas',
  Mobil.ObjectList in '..\..\Allgemein\Mobil\Mobil.ObjectList.pas',
  Rest.BenutzerList in '..\Rest\Rest.BenutzerList.pas',
  Objekt.BasisRestlist in '..\..\Allgemein\Objekt\Objekt.BasisRestlist.pas',
  Objekt.Basislist in '..\..\Allgemein\Objekt\Objekt.Basislist.pas',
  Objekt.ObjektList in '..\..\Allgemein\Objekt\Objekt.ObjektList.pas',
  Objekt.Allg in '..\..\Allgemein\Objekt\Objekt.Allg.pas',
  ClientModule.Classes in 'Clientmodul\ClientModule.Classes.pas',
  ClientModule.Module in 'Clientmodul\ClientModule.Module.pas' {ClientModule1: TDataModule},
  Form.TSIDepotname in 'Form\Form.TSIDepotname.pas' {frm_TSIDepotname},
  Rest.Depotname in '..\Rest\Rest.Depotname.pas',
  Rest.DepotnameList in '..\Rest\Rest.DepotnameList.pas',
  Rest.Depotwerte in '..\Rest\Rest.Depotwerte.pas',
  Rest.DepotwerteList in '..\Rest\Rest.DepotwerteList.pas',
  Rest.AnsichtList in '..\Rest\Rest.AnsichtList.pas',
  Rest.Ansicht in '..\Rest\Rest.Ansicht.pas',
  Objekt.GridAktie in 'Objekt\Objekt.GridAktie.pas',
  Objekt.GridAktieList in 'Objekt\Objekt.GridAktieList.pas';



{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm_Style, dm_Style);
  Application.CreateForm(Tfrm_MainTSIDepot, frm_MainTSIDepot);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.CreateForm(Tfrm_TSIDepotname, frm_TSIDepotname);
  Application.Run;
end.
