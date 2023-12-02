unit Objekt.Dateicheck;

interface

uses
  SysUtils, Classes, Objekt.Datei, Objekt.DateiList, Vcl.ExtCtrls,
  Vcl.Controls, Vcl.Forms, Windows;

type
  TDateicheck = class
  private
    fDateiList: TDateiList;
    fDataPfad: string;
    fCheckTimer: TTimer;
    fTimerEnabled: Boolean;
    fDateiListname: string;
    fDebugMode: Boolean;
    procedure setTimerEnabled(const Value: Boolean);
    procedure Check(Sender: TObject);
    procedure SendMail(aDatei: TDatei);
  public
    constructor Create;
    destructor Destroy; override;
    property TimerEnabled: Boolean read fTimerEnabled write setTimerEnabled;
  end;

implementation

{ TDateicheck }

uses
  Objekt.BugreportMail, Objekt.Allgemein, Objekt.Mail, Allgemein.RegIni;


constructor TDateicheck.Create;
var
  s: string;
begin
  fDebugMode := false;
  fDateiList := TDateiList.Create;
  fDataPfad  := '';
  fCheckTimer := TTimer.Create(nil);
  fCheckTimer.Enabled := false;
  fCheckTimer.OnTimer := Check;
  fCheckTimer.Interval := 1000 * 60 * 10;
  fTimerEnabled := false;
  fDateiListname := BugreportMail.Pfad + 'DateiList.dat';
  fDateiList.LoadFromFile(fDateiListname);
             // AllgemeinObj
  if FileExists(BugreportMail.Pfad + 'BugreportMail.Ini') then
  begin
    s := ReadIni(BugreportMail.Pfad + 'BugreportMail.Ini', 'Dienst', 'DebugMode', 'X');
    if s = 'X' then
      WriteIni(BugreportMail.Pfad + 'BugreportMail.Ini', 'Dienst', 'DebugMode', '0');
    fDebugMode := s = '1';
    fCheckTimer.Interval := StrToInt(ReadIni(BugreportMail.Pfad + 'BugreportMail.Ini', 'Dienst', 'Interval', '0'));
    if fCheckTimer.Interval = 0 then
    begin
      WriteIni(BugreportMail.Pfad + 'BugreportMail.Ini', 'Dienst', 'Interval', '600000');
      fCheckTimer.Interval := 600000;
    end;
  end
  else
    WriteIni(BugreportMail.Pfad + 'BugreportMail.Ini', 'Dienst', 'Interval', '600000');
  AllgemeinObj.Log.DienstInfo('TimerInterval = ' + IntToStr(fCheckTimer.Interval));
end;

destructor TDateicheck.Destroy;
begin
  FreeAndNil(fCheckTimer);
  inherited;
end;


procedure TDateicheck.setTimerEnabled(const Value: Boolean);
begin
  fTimerEnabled := Value;
  fCheckTimer.Enabled := fTimerEnabled;
end;

procedure TDateicheck.Check(Sender: TObject);
var
  i1: Integer;
  Datei: TDatei;
  Pfad: string;
  BackupPfad: string;
  BackupDatei: string;
  Ext: string;
  s: string;
begin
  try
    if fDebugMode then
      AllgemeinObj.Log.DienstInfo('TDateicheck.Check(Sender: TObject)');
    for i1 := 0 to fDateiList.Count -1 do
    begin
      Datei := fDateiList.Item[i1];
      Pfad  := IncludeTrailingPathDelimiter(ExtractFileDir(Datei.Datei));
      BackupPfad := Pfad + 'BugreportSicherung\';
      if fDebugMode then
        AllgemeinObj.Log.DienstInfo('Überwachungsdatei = ' + Datei.Datei);
      if not FileExists(Datei.Datei) then
      begin
        if fDebugMode then
          AllgemeinObj.Log.DienstInfo('Datei nicht vorhanden');
        continue;
      end;
      if not DirectoryExists(BackupPfad) then
        ForceDirectories(BackupPfad);
      Ext := ExtractFileExt(Datei.Datei);
      s := copy(ExtractFileName(Datei.Datei), 1, Length(ExtractFileName(Datei.Datei)) - Length(Ext));
      s := s + '_' + FormatDateTime('yyyy-mm-dd-hhnnss', now) + Ext;
      BackupDatei := BackupPfad + s;
      if fDebugMode then
        AllgemeinObj.Log.DienstInfo('Backupdatei = ' + BackupDatei);
      SendMail(Datei);
      copyFile(PWideChar(Datei.Datei), PWideChar(BackupDatei), true);
      DeleteFile(PWideChar(Datei.Datei));
      if FileExists(Datei.Datei) then
        setTimerEnabled(false);
    end;
  except
    on E:Exception do
    begin
      AllgemeinObj.Log.DienstInfo('Fehler: ' + E.Message);
    end;
  end;
end;


procedure TDateicheck.SendMail(aDatei: TDatei);
var
  Mail: TMail;
  Anhang: TStringList;
begin
  Anhang := TStringList.Create;
  Mail := TMail.Create;
  try
    Mail.AbsSmtp := BugreportMail.Ini.AbsMail.Smtp;
    Mail.AbsEMail := BugreportMail.Ini.AbsMail.AbsenderMail;
    Mail.AbsUsername := BugreportMail.Ini.AbsMail.Benutzer;
    Mail.AbsPasswort := BugreportMail.Ini.AbsMail.Passwort;
    Mail.AbsPort := StrToInt(BugreportMail.Ini.AbsMail.Port);
    Mail.AbsTLS := StrToInt(BugreportMail.Ini.AbsMail.TLS);
    Mail.AbsSSLVersion := StrToInt(BugreportMail.Ini.AbsMail.SSLVersion);
    Mail.Betreff := aDatei.Betreff;
    Mail.Nachricht := 'Server - Bugreport';
    Mail.EMailAdresse := aDatei.EMail;
   // Mail.OnMailError := MailError;
   Anhang.Add(aDatei.Datei);
    Mail.Verschicken(Anhang);
   // if not fMailError then
   //   ShowMessage('Mail wurde versendet');
  finally
    FreeAndNil(Mail);
    FreeAndNil(Anhang);
  end;

end;



end.
