program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Objekt.Verschluesseln in '..\..\..\..\Projekte\Allgemein\Objekt\Objekt.Verschluesseln.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
