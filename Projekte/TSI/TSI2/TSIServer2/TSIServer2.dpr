program TSIServer2;

uses
  FastMM4 in '..\..\Log4d\FastMM\FastMM4.pas',
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.StartUpCopy,
  FMX.Forms,
  Form.TSIServer2 in 'Form\Form.TSIServer2.pas' {frm_TSIServer2},
  Objekt.TSIServer2 in 'Objekt\Objekt.TSIServer2.pas',
  Objekt.IniTSIServer in 'Objekt\Objekt.IniTSIServer.pas',
  Objekt.IniBase in '..\Objekt\Objekt.IniBase.pas',
  Objekt.IniFirebird in '..\Objekt\Objekt.IniFirebird.pas',
  Form.Einstellung in 'Form\Form.Einstellung.pas' {frm_Einstellung},
  Objekt.IniAllgemein in 'Objekt\Objekt.IniAllgemein.pas',
  Datamodul.Database in '..\Datamodul\Datamodul.Database.pas' {dm: TDataModule},
  Objekt.IBConnectData in '..\..\Allgemein\Objekt\Objekt.IBConnectData.pas',
  Objekt.ObjektList in '..\..\Allgemein\Objekt\Objekt.ObjektList.pas',
  Objekt.DBFeld in '..\Objekt\Objekt.DBFeld.pas',
  Objekt.DBFeldList in '..\Objekt\Objekt.DBFeldList.pas',
  DB.Basis in '..\Datenbank\DB.Basis.pas',
  DB.BasisList in '..\Datenbank\DB.BasisList.pas',
  DB.Schnittstelle in '..\Datenbank\DB.Schnittstelle.pas',
  DB.SchnittstelleList in '..\Datenbank\DB.SchnittstelleList.pas',
  Form.Protokoll in 'Form\Form.Protokoll.pas' {frm_Protokoll},
  View.Aktie in '..\View\View.Aktie.pas',
  View.Base in '..\View\View.Base.pas',
  View.AktieList in '..\View\View.AktieList.pas',
  Objekt.DownloadKurse in 'Objekt\Objekt.DownloadKurse.pas',
  Objekt.Protokoll in '..\Objekt\Objekt.Protokoll.pas',
  Objekt.CSVAktie in 'Objekt\Objekt.CSVAktie.pas',
  Objekt.CSVAktieList in 'Objekt\Objekt.CSVAktieList.pas',
  DB.Kurs in '..\Datenbank\DB.Kurs.pas',
  DB.KursList in '..\Datenbank\DB.KursList.pas',
  DB.TSI in '..\Datenbank\DB.TSI.pas',
  DB.TSIList in '..\Datenbank\DB.TSIList.pas',
  DB.Aktie in '..\Datenbank\DB.Aktie.pas',
  DB.AktieList in '..\Datenbank\DB.AktieList.pas',
  Objekt.CSVKurseToDB in 'Objekt\Objekt.CSVKurseToDB.pas',
  DB.TSILast in '..\Datenbank\DB.TSILast.pas',
  DB.TSILastList in '..\Datenbank\DB.TSILastList.pas',
  Objekt.SaveTSIWerte in 'Objekt\Objekt.SaveTSIWerte.pas',
  DB.AbwProz in '..\Datenbank\DB.AbwProz.pas',
  DB.AbwProzList in '..\Datenbank\DB.AbwProzList.pas',
  Objekt.SaveAbwProz in 'Objekt\Objekt.SaveAbwProz.pas',
  DB.KursHochTief in '..\Datenbank\DB.KursHochTief.pas',
  Objekt.SaveKursHochTief in 'Objekt\Objekt.SaveKursHochTief.pas',
  DB.GuVJahr in '..\Datenbank\DB.GuVJahr.pas',
  DB.GuVJahrList in '..\Datenbank\DB.GuVJahrList.pas',
  Objekt.SaveGuVJahr in 'Objekt\Objekt.SaveGuVJahr.pas',
  DB.GuVJahre in '..\Datenbank\DB.GuVJahre.pas',
  DB.GuVJahreList in '..\Datenbank\DB.GuVJahreList.pas',
  Form.Einstellung2 in 'Form\Form.Einstellung2.pas' {frm_Einstellung2},
  DB.Dateiformat in '..\Datenbank\DB.Dateiformat.pas',
  Objekt.Dateiformat in 'Objekt\Objekt.Dateiformat.pas',
  Objekt.SaveEPS_YahooFinance in 'Objekt\Objekt.SaveEPS_YahooFinance.pas',
  Json.YahooFinance.QuotedSummery in 'Json\YahooFinance\Json.YahooFinance.QuotedSummery.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfrm_TSIServer2, frm_TSIServer2);
  Application.Run;
end.
