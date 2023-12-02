program RezeptServer;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Form.ServerRezept in 'Form\Form.ServerRezept.pas' {frm_ServerRezept},
  Servermodul.RezeptMethods in 'Servermodul\Servermodul.RezeptMethods.pas',
  Servermodul.RezeptContainer in 'Servermodul\Servermodul.RezeptContainer.pas' {RezeptServerContainer: TDataModule},
  Servermodul.RezeptWeb in 'Servermodul\Servermodul.RezeptWeb.pas' {RezeptWeb: TWebModule},
  Datamodul.Database in '..\Datamodul\Datamodul.Database.pas' {dm: TDataModule},
  Rest.Rezept in 'Rest\Rest.Rezept.pas',
  Rest.Basis in 'Rest\Rest.Basis.pas',
  Rest.RezeptList in 'Rest\Rest.RezeptList.pas',
  Objekt.Feld in '..\..\Allgemein\Objekt\Objekt.Feld.pas',
  Objekt.FeldList in '..\..\Allgemein\Objekt\Objekt.FeldList.pas',
  Objekt.BasisRestlist in '..\..\Allgemein\Objekt\Objekt.BasisRestlist.pas',
  Rest.Zutatenlistenname in 'Rest\Rest.Zutatenlistenname.pas',
  Rest.ZutatenlistennameList in 'Rest\Rest.ZutatenlistennameList.pas',
  Rest.Rezeptzutaten in 'Rest\Rest.Rezeptzutaten.pas',
  Rest.RezeptzutatenList in 'Rest\Rest.RezeptzutatenList.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfrm_ServerRezept, frm_ServerRezept);
  Application.Run;
end.
