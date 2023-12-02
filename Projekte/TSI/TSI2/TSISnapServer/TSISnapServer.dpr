program TSISnapServer;
{$APPTYPE GUI}

{$R *.dres}

uses
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Form.TSISnapServer in 'Form\Form.TSISnapServer.pas' {frm_TSISnapServer},
  Servermodul.TSISnapServerMethods in 'Servermodul\Servermodul.TSISnapServerMethods.pas',
  Servermodul.TSISnapServerWeb in 'Servermodul\Servermodul.TSISnapServerWeb.pas' {WebModule1: TWebModule},
  Datamodul.Database in '..\Datamodul\Datamodul.Database.pas' {dm: TDataModule},
  Rest.Basis in '..\Rest\Rest.Basis.pas',
  Rest.Aktie in '..\Rest\Rest.Aktie.pas',
  Rest.AktieList in '..\Rest\Rest.AktieList.pas',
  View.Ansicht in '..\View\View.Ansicht.pas',
  View.AnsichtList in '..\View\View.AnsichtList.pas',
  Rest.Ansicht in '..\Rest\Rest.Ansicht.pas',
  Rest.AnsichtList in '..\Rest\Rest.AnsichtList.pas',
  DB.KursList in '..\Datenbank\DB.KursList.pas',
  Rest.Kurs in '..\Rest\Rest.Kurs.pas',
  Rest.KursList in '..\Rest\Rest.KursList.pas',
  Rest.TSI in '..\Rest\Rest.TSI.pas',
  Rest.TSIList in '..\Rest\Rest.TSIList.pas',
  DB.GuVJahrList in '..\Datenbank\DB.GuVJahrList.pas',
  DB.GuVJahr in '..\Datenbank\DB.GuVJahr.pas',
  DB.GuVJahre in '..\Datenbank\DB.GuVJahre.pas',
  View.GuVJahre in '..\View\View.GuVJahre.pas',
  View.GuVJahreList in '..\View\View.GuVJahreList.pas',
  Rest.GuVJahre in '..\Rest\Rest.GuVJahre.pas',
  Rest.GuVJahreList in '..\Rest\Rest.GuVJahreList.pas',
  DB.Benutzer in '..\Datenbank\DB.Benutzer.pas',
  DB.BenutzerList in '..\Datenbank\DB.BenutzerList.pas',
  Rest.Benutzer in '..\Rest\Rest.Benutzer.pas',
  Rest.BenutzerList in '..\Rest\Rest.BenutzerList.pas',
  DB.Depotname in '..\Datenbank\DB.Depotname.pas',
  DB.DepotnameList in '..\Datenbank\DB.DepotnameList.pas',
  Rest.Depotname in '..\Rest\Rest.Depotname.pas',
  Rest.DepotnameList in '..\Rest\Rest.DepotnameList.pas',
  DB.Depotwerte in '..\Datenbank\DB.Depotwerte.pas',
  DB.DepotwerteList in '..\Datenbank\DB.DepotwerteList.pas',
  View.Depotwerte in '..\View\View.Depotwerte.pas',
  View.DepotwerteList in '..\View\View.DepotwerteList.pas',
  Rest.Depotwerte in '..\Rest\Rest.Depotwerte.pas',
  Rest.DepotwerteList in '..\Rest\Rest.DepotwerteList.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfrm_TSISnapServer, frm_TSISnapServer);
  Application.Run;
end.
