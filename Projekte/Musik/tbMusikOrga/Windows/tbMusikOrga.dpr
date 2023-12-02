program tbMusikOrga;

uses
  Vcl.Forms,
  Form.MusikOrga in 'Form\Form.MusikOrga.pas' {frm_MusikOrga},
  Datamodul.Database in 'Datenmodul\Datamodul.Database.pas' {dm: TDataModule},
  Datamodul.Bilder in 'Datenmodul\Datamodul.Bilder.pas' {dm_Bilder: TDataModule},
  Objekt.IniBase in 'Objekt\Objekt.IniBase.pas',
  Objekt.IniFirebird in 'Objekt\Objekt.IniFirebird.pas',
  Objekt.Logger in 'Objekt\Objekt.Logger.pas',
  Objekt.IniMusikOrga in 'Objekt\Objekt.IniMusikOrga.pas',
  Objekt.MusikOrga in 'Objekt\Objekt.MusikOrga.pas',
  Form.IniFirebird in 'Form\Form.IniFirebird.pas' {frm_IniFirebird},
  Form.Einstellung in 'Form\Form.Einstellung.pas' {frm_Einstellung},
  Form.MainChild in 'Form\Form.MainChild.pas' {frm_MainChild},
  Objekt.DBFeld in 'Datenbank\Objekt.DBFeld.pas',
  Objekt.DBFeldList in 'Datenbank\Objekt.DBFeldList.pas',
  DB.Basis in 'Datenbank\DB.Basis.pas',
  DB.BasisList in 'Datenbank\DB.BasisList.pas',
  DB.Musikpfad in 'Datenbank\DB.Musikpfad.pas',
  DB.MusikpfadList in 'Datenbank\DB.MusikpfadList.pas',
  Form.Musikpfad in 'Form\Form.Musikpfad.pas' {frm_Musikpfad},
  Objekt.AudioFile in 'Objekt\Objekt.AudioFile.pas',
  Form.Audiofile in 'Form\Form.Audiofile.pas' {frm_AudioFile},
  Objekt.AudioFileText in 'Objekt\Objekt.AudioFileText.pas',
  Objekt.AudioFilePicture in 'Objekt\Objekt.AudioFilePicture.pas',
  Objekt.AudioFilePictureList in 'Objekt\Objekt.AudioFilePictureList.pas',
  Objekt.MP3 in 'Objekt\Objekt.MP3.pas',
  Objekt.AudioStruktur in 'Objekt\Objekt.AudioStruktur.pas',
  Objekt.MP4 in 'Objekt\Objekt.MP4.pas',
  Objekt.AudioFileList in 'Objekt\Objekt.AudioFileList.pas',
  c_AllgTypes in '..\const\c_AllgTypes.pas',
  sys.Objekt in '..\Sys\sys.Objekt.pas',
  sys.Disk in '..\Sys\sys.Disk.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tdm_Bilder, dm_Bilder);
  Application.CreateForm(Tfrm_MusikOrga, frm_MusikOrga);
  Application.Run;
end.
