program RestClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.RestClient in 'Form.RestClient.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
