program RezeptServer;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Form.RezeptServer in 'Form\Form.RezeptServer.pas' {frm_RezeptServer},
  ServerMethodsRezept in 'Servermodul\ServerMethodsRezept.pas',
  ServerContainerRezept in 'Servermodul\ServerContainerRezept.pas' {ContainerRezept: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TContainerRezept, ContainerRezept);
  Application.CreateForm(Tfrm_RezeptServer, frm_RezeptServer);
  Application.Run;
end.

