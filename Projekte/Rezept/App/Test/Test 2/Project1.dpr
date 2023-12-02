program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule},
  Rest.Basis in '..\..\RezeptServer\Rest\Rest.Basis.pas',
  Rest.Rezept in '..\..\RezeptServer\Rest\Rest.Rezept.pas',
  Rest.RezeptList in '..\..\RezeptServer\Rest\Rest.RezeptList.pas',
  Objekt.Basislist in '..\..\..\Allgemein\Objekt\Objekt.Basislist.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
