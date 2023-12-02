program Test1Path;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.Test1Path in 'Form.Test1Path.pas' {frm_Test1Path};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_Test1Path, frm_Test1Path);
  Application.Run;
end.
