program ThreadTest1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.ThreadTest1 in 'Form.ThreadTest1.pas' {Form2},
  Objekt.Hauptverarbeitung in 'Objekt.Hauptverarbeitung.pas',
  Objekt.Verarbeitung1 in 'Objekt.Verarbeitung1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
