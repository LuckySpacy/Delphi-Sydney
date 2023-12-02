program TSIDepot2;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.MainTSIDepot2 in 'Form\Form.MainTSIDepot2.pas' {frm_MainTSIDepot2},
  dm.Style in 'Datenmodul\dm.Style.pas' {dm_Style: TDataModule},
  ClientModul.Classes in 'Clientmodul\ClientModul.Classes.pas',
  ClientModule.Module in 'Clientmodul\ClientModule.Module.pas' {ClientModule1: TDataModule},
  Rest.Benutzer in '..\Rest\Rest.Benutzer.pas',
  Rest.BenutzerList in '..\Rest\Rest.BenutzerList.pas',
  Rest.Depotname in '..\Rest\Rest.Depotname.pas',
  Rest.DepotnameList in '..\Rest\Rest.DepotnameList.pas',
  Rest.Basis in '..\Rest\Rest.Basis.pas',
  Mobil.Feld in '..\..\Allgemein\Mobil\Mobil.Feld.pas',
  Mobil.FeldList in '..\..\Allgemein\Mobil\Mobil.FeldList.pas',
  Mobil.BasisList in '..\..\Allgemein\Mobil\Mobil.BasisList.pas',
  Mobil.ObjectList in '..\..\Allgemein\Mobil\Mobil.ObjectList.pas',
  Rest.Ansicht in '..\Rest\Rest.Ansicht.pas',
  Rest.AnsichtList in '..\Rest\Rest.AnsichtList.pas',
  Form.TSIDepot in 'Form\Form.TSIDepot.pas' {frm_TSIDepot},
  Form.TSIDepotname in 'Form\Form.TSIDepotname.pas' {frm_TSIDepotname},
  Rest.Depotwerte in '..\Rest\Rest.Depotwerte.pas',
  Rest.DepotwerteList in '..\Rest\Rest.DepotwerteList.pas',
  Objekt.GridAktie in 'Objekt\Objekt.GridAktie.pas',
  Objekt.GridAktieList in 'Objekt\Objekt.GridAktieList.pas',
  Objekt.DBFeld in '..\Objekt\Objekt.DBFeld.pas',
  DB.Basis in '..\Datenbank\DB.Basis.pas',
  Objekt.DBFeldList in '..\Objekt\Objekt.DBFeldList.pas'

  {$IFDEF WIN32}
  ,DB.BasisList in '..\Datenbank\DB.BasisList.pas',
  View.Base in '..\View\View.Base.pas'
  {$ENDIF WIN32}

  ;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm_Style, dm_Style);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.CreateForm(Tfrm_MainTSIDepot2, frm_MainTSIDepot2);
  Application.Run;
end.
