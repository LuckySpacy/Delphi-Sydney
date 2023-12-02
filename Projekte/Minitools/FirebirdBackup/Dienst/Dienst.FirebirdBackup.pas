unit Dienst.FirebirdBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Objekt.Allgemein, Objekt.Backupchecker, Objekt.Option, Objekt.OptionList, Objekt.Maildat,
  Objekt.SendMail;

type
  TtbFirebirdBackup = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
  private
    fDataFile: string;
    fProgrammpfad: string;
    fBackupchecker: TBackupchecker;
    fMaildat: TMailDat;
    procedure BackupLauft(Sender: TObject; aOption: TOption);
    procedure BackupEndet(Sender: TObject; aOption: TOption);
    procedure ErrorBackup(Sender: TObject; aOption: TOption; aError: string);
    procedure MailError(Sender: TObject; aError: string);
  public
    function GetServiceController: TServiceController; override;
    { Public-Deklarationen }
  end;

var
  tbFirebirdBackup: TtbFirebirdBackup;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  tbFirebirdBackup.Controller(CtrlCode);
end;



procedure TtbFirebirdBackup.ServiceCreate(Sender: TObject);
begin
  AllgemeinObj := TAllgemeinObj.create;
  AllgemeinObj.Log.DienstInfo('ServiceCreate');
  AllgemeinObj.Log.DienstInfo('Version 1.0.0 vom 16.01.2021 10:30');
  fProgrammpfad := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  AllgemeinObj.Log.DebugInfo('fProgrammpfad='+fProgrammpfad);
  fDataFile := fProgrammpfad + 'nfsBackup.dat';
  fBackupchecker := TBackupchecker.Create;
  AllgemeinObj.Log.DebugInfo('fDataFile='+fDataFile);
  fBackupChecker.FullDataFilename := fDataFile;
  fBackupchecker.OnStartBackup := BackupLauft;
  fBackupchecker.OnEndBackup   := BackupEndet;
  fBackupchecker.OnBackupError := ErrorBackup;
  fMaildat := TMailDat.Create;
end;



procedure TtbFirebirdBackup.ServiceDestroy(Sender: TObject);
begin
  FreeAndNil(fBackupchecker);
  FreeAndNil(fMaildat);
  FreeAndNil(AllgemeinObj);
end;

procedure TtbFirebirdBackup.ServiceExecute(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('Dienst läuft');
  fBackupchecker.TimerEnabled := true;

  while not Terminated do
  begin
    sleep(100);
    ServiceThread.ProcessRequests(false);
  end;
  fBackupchecker.TimerEnabled := false;

  AllgemeinObj.Log.DienstInfo('Dienst ist beendet');
end;

procedure TtbFirebirdBackup.ServicePause(Sender: TService; var Paused: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('ServicePause');
end;

procedure TtbFirebirdBackup.ServiceShutdown(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('Shutdown');
end;

procedure TtbFirebirdBackup.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('ServiceStart');
end;

procedure TtbFirebirdBackup.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('ServiceStop');
end;

procedure TtbFirebirdBackup.ServiceAfterInstall(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('AfterInstall');
end;


procedure TtbFirebirdBackup.ServiceAfterUninstall(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('AfterUnInstall');
end;

procedure TtbFirebirdBackup.ServiceBeforeInstall(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('BeforeInstall');
end;

procedure TtbFirebirdBackup.ServiceBeforeUninstall(Sender: TService);
begin
  AllgemeinObj.Log.DienstInfo('BeforeUnInstall');
end;

procedure TtbFirebirdBackup.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  AllgemeinObj.Log.DienstInfo('ServiceContinue');
end;


procedure TtbFirebirdBackup.BackupEndet(Sender: TObject; aOption: TOption);
begin
  AllgemeinObj.Log.BackupInfo('Backup beendet - ' + aOption.Datenbank);
  AllgemeinObj.Log.BackupInfo(' ');
end;

procedure TtbFirebirdBackup.BackupLauft(Sender: TObject; aOption: TOption);
begin
  AllgemeinObj.Log.BackupInfo('');
  AllgemeinObj.Log.BackupInfo('Backup läuft - ' + aOption.Datenbank);
end;

procedure TtbFirebirdBackup.ErrorBackup(Sender: TObject; aOption: TOption;
  aError: string);
var
  Mail: TSendMail;
  s: string;
begin
  AllgemeinObj.Log.BackupInfo('Backupfehler: ' +  aError);

  Mail := TSendMail.Create;
  try
    Mail.OnMailError := MailError;
    fMaildat.Load;
    if (Trim(fMaildat.Mail) = '') or (Trim(fMaildat.Passwort) = '') then
    begin
      AllgemeinObj.Log.DienstInfo('Mail kann nicht gesendet werden, da EMail-Adresse und oder EMail-Passwort fehlt');
      AllgemeinObj.Log.DebugInfo('Mail kann nicht gesendet werden, da EMail-Adresse und oder EMail-Passwort fehlt');
      exit;
    end;

    s := 'Backupfehler: ' + sLineBreak +
         'Servername: ' + aOption.Servername + sLineBreak +
         'Datenbank: ' + aOption.Datenbank + sLineBreak +
         'Backupdatei: ' + aOption.Backupdatei + sLineBreak + sLineBreak +
         'Fehlerbeschreibung:' + sLineBreak + aError;

    Mail.Host := fMaildat.Host;
    Mail.MeineEMail := fMaildat.Mail;
    Mail.MeinPasswort := fMaildat.Passwort;
    Mail.MeinUsername := fMaildat.User;
    Mail.Betreff := fMaildat.Betreff;
    Mail.Nachricht := s;
    Mail.EMailAdresse := fMaildat.MailAn;
    Mail.OnMailError := MailError;
    if fMaildat.Provider = pvExchange then
      Mail.SendenUeberExchange;
    if fMaildat.Provider = pvGmail then
      Mail.SendenUeberGMail;
    if fMaildat.Provider = pvWeb then
      Mail.SendenUeberWebDe;
  finally
    FreeAndNil(Mail);
  end;


end;

function TtbFirebirdBackup.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TtbFirebirdBackup.MailError(Sender: TObject; aError: string);
begin
  AllgemeinObj.Log.DebugInfo('Fehler beim Senden einer Mail: ' + aError);
  AllgemeinObj.Log.DienstInfo('Fehler beim Senden einer Mail: ' + aError);
end;


end.
