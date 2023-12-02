program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Objekt.Datei in '..\..\..\Projekte\Allgemein\Objekt\Objekt.Datei.pas',
  Objekt.Dateidatum in '..\..\..\Projekte\Allgemein\Objekt\Objekt.Dateidatum.pas',
  Objekt.Basislist in '..\..\..\Projekte\Allgemein\Objekt\Objekt.Basislist.pas',
  Objekt.DateiList in '..\..\..\Projekte\Allgemein\Objekt\Objekt.DateiList.pas',
  Objekt.Dateisystem in '..\..\..\Projekte\Allgemein\Objekt\Objekt.Dateisystem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
