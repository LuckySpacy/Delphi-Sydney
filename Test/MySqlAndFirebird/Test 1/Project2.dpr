program Project2;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  DB.Basis in 'Datenbank\DB.Basis.pas',
  DB.BasisList in 'Datenbank\DB.BasisList.pas',
  DB.Rezept in 'Datenbank\DB.Rezept.pas',
  Objekt.MultiQuery in 'Objekt\Objekt.MultiQuery.pas',
  Objekt.MultiTrans in 'Objekt\Objekt.MultiTrans.pas',
  Objekt.MultiQueryFeld in 'Objekt\Objekt.MultiQueryFeld.pas',
  Objekt.MultiQueryFeldList in 'Objekt\Objekt.MultiQueryFeldList.pas',
  DB.RezeptList in 'Datenbank\DB.RezeptList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
