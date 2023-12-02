program BugreportUI;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Form.BugreportMailUI in 'Form\Form.BugreportMailUI.pas' {frm_BugreportMailUI},
  Objekt.BugreportMail in '..\Objekt\Objekt.BugreportMail.pas',
  Objekt.Ini in '..\Objekt\Objekt.Ini.pas',
  Form.AbsMail in 'Form\Form.AbsMail.pas' {frm_AbsMail},
  Objekt.IniAbsMail in '..\Objekt\Objekt.IniAbsMail.pas',
  Allgemein.RegIni in '..\Allgemein\Allgemein.RegIni.pas',
  Objekt.Mail in '..\Objekt\Objekt.Mail.pas',
  Form.Dateien in 'Form\Form.Dateien.pas' {frm_Dateien},
  Objekt.Datei in '..\Objekt\Objekt.Datei.pas',
  Objekt.BaseList in '..\Objekt\Objekt.BaseList.pas',
  Objekt.DateiList in '..\Objekt\Objekt.DateiList.pas',
  Objekt.Allgemein in '..\Objekt\Objekt.Allgemein.pas',
  Objekt.Logger in '..\Objekt\Objekt.Logger.pas',
  Form.Datei in 'Form\Form.Datei.pas' {frm_Datei};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_BugreportMailUI, frm_BugreportMailUI);
  Application.Run;
end.
