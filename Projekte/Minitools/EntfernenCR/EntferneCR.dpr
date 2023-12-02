program EntferneCR;

uses
  Vcl.Forms,
  Form.EntferneCR in 'Form\Form.EntferneCR.pas' {frm_EntferneCR};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_EntferneCR, frm_EntferneCR);
  Application.Run;
end.
