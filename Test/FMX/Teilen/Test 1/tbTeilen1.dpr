program tbTeilen1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.tbTeilen1 in 'Form.tbTeilen1.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
