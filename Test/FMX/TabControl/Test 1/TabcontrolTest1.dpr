program TabcontrolTest1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.TabControlTest1 in 'Form.TabControlTest1.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
