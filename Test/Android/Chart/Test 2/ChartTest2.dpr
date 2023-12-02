program ChartTest2;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.Chart_Test2 in 'Form.Chart_Test2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
