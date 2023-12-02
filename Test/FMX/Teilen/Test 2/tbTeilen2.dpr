program tbTeilen2;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.tbTeilen2 in 'Form.tbTeilen2.pas' {frm_Teilen2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_Teilen2, frm_Teilen2);
  Application.Run;
end.
