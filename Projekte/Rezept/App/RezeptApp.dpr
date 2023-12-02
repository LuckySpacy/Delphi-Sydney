program RezeptApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.Uebersicht in 'Form\Form.Uebersicht.pas' {frm_Uebersicht},
  ClientModul.Classes in 'ClientModul\ClientModul.Classes.pas',
  ClientModul.Module in 'ClientModul\ClientModul.Module.pas' {ClientModule1: TDataModule},
  Rest.ObjectList in '..\RezeptServer\Rest\Rest.ObjectList.pas',
  Mobil.ObjectList in '..\..\Allgemein\Mobil\Mobil.ObjectList.pas',
  Mobil.BasisList in '..\..\Allgemein\Mobil\Mobil.BasisList.pas',
  Mobil.Feld in '..\..\Allgemein\Mobil\Mobil.Feld.pas',
  Mobil.FeldList in '..\..\Allgemein\Mobil\Mobil.FeldList.pas',
  Form.Rezept in 'Form\Form.Rezept.pas' {frm_Rezept},
  Form.Zutaten in 'Form\Form.Zutaten.pas' {frm_Zutaten},
  Form.Zutat in 'Form\Form.Zutat.pas' {frm_Zutat},
  Objekt.RestSchnittstelle in 'Objekt\Objekt.RestSchnittstelle.pas',
  Form.Notiz in 'Form\Form.Notiz.pas' {frm_Notiz};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_Uebersicht, frm_Uebersicht);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
