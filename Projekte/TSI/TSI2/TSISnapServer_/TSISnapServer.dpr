program TSISnapServer;

uses
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Form.TSISnapServer in 'Form\Form.TSISnapServer.pas' {Form1},
  Servermodul.Methods in 'Servermodul\Servermodul.Methods.pas',
  Servermodul.Container in 'Servermodul\Servermodul.Container.pas' {ServerContainer1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

