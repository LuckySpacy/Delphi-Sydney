program PaintTest1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.PaintTest2 in 'Form.PaintTest2.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
