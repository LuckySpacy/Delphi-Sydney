program SperreTest1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.SperreTest1 in 'Form.SperreTest1.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
