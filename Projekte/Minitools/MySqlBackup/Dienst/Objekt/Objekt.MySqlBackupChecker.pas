unit Objekt.MySqlBackupChecker;

interface

uses
  SysUtils, Classes, Objekt.Option, Objekt.OptionList, Vcl.ExtCtrls,
  Vcl.Controls, Vcl.Forms, Objekt.DateTime, Objekt.DateiSystem, Objekt.DateiList,
  Objekt.Datei;

type
  TBackupchecker = class
  private
    fOptionList: TOptionList;
    fDataPfad: string;
    fCheckTimer: TTimer;
    fDateTime: TTbDateTime;
    fFullDataFilename: string;
    fTimerEnabled: Boolean;
    fAktualData: Boolean;
    fHandle: Thandle;
    fDateisystem: TDateisystem;
    fDateiList: TDateiList;
    fDatei: TDatei;
    procedure Check(Sender: TObject);
    procedure setFullDataFilename(const Value: string);
    function getStartZeit(aStartTime: TDateTime): TDateTime;
    procedure setTimerEnabled(const Value: Boolean);
    procedure ErzeugeBat(aOption: TOption);
    procedure Log(aValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    property FullDataFilename: string read fFullDataFilename write setFullDataFilename;
    property TimerEnabled: Boolean read fTimerEnabled write setTimerEnabled;
    property AktualData: Boolean read fAktualData write fAktualData;
    property Handle: Thandle read fHandle write fHandle;
  end;

implementation

{ TBackupchecker }

uses
  Objekt.Allgemein, Objekt.MySqlBackup, ShellAPI, u_System, Winapi.Windows, DateUtils;

constructor TBackupchecker.Create;
begin
  fOptionList  := TOptionList.Create;
  fDateisystem := TDateisystem.Create;
  fDateiList   := TDateiList.Create;
  fDatei       := TDatei.Create;

  fDataPfad := '';
  fTimerEnabled := false;
  fCheckTimer := TTimer.Create(nil);
  fDateTime := TTbDateTime.Create(nil);
  //fCheckTimer.Interval := 600000; // Alle 10 Minuten
  //fCheckTimer.Interval := 10000; //
  Log('Inifile=' + MySqlBackup.ini.Dienst.IniFilename);
  fCheckTimer.Interval :=  StrToInt(MySqlBackup.ini.Dienst.IntervalInMinuten) * 60 * 1000;
  fCheckTimer.Enabled := fTimerEnabled;
  fCheckTimer.OnTimer := Check;
  fAktualData := false;
  Log('TimerInterval=' + IntToStr(fCheckTimer.Interval));
  fOptionList.LoadFromFile(MySqlBackup.DataFilename);

  if fOptionList.Count <= 0 then
  begin
    Log('OptionListCount=' + IntToStr(fOptionList.Count) + ' / Keine Backupinfo vorhanden.');
    exit;
  end;

end;

destructor TBackupchecker.Destroy;
begin
  FreeAndNil(fOptionList);
  FreeAndNil(fDateiSystem);
  FreeAndNil(fDateTime);
  FreeAndNil(fDateiList);
  FreeAndNil(fDatei);
  inherited;
end;


procedure TBackupchecker.Check(Sender: TObject);
var
  i1: Integer;
  Option: TOption;
  Startzeit : TDateTime;
  s: string;
begin
  //Log('Check ' + IntToStr(fOptionList.Count) );
  fCheckTimer.Enabled := false;
  try
    for i1 := 0 to fOptionList.Count -1 do
    begin
      Option := fOptionList.Item[i1];
      //s := FormatDateTime('dd.mm.yyyy hh:nn:ss', now);
      //Log('now = ' + s);
      //s := FormatDateTime('dd.mm.yyyy hh:nn:ss', Option.LastBackup);
      //Log('Option.LastBackup = ' + s);
      if Option.LastBackup >= now then
      begin
        //Log('LastBackup > now');
        continue;
      end;
      Startzeit := getStartZeit(Option.StartZeit);
      //s := FormatDateTime('dd.mm.yyyy hh:nn:ss', StartZeit);
      //Log('Startzeit = ' + s);
      if now < Startzeit then
      begin
        //Log('now < Startzeit');
        continue;
      end;
      log('ErzeugeBat');
      ErzeugeBat(Option);
      log('ShellExecute Self.Handle, open, ' + MySqlBackup.Pfad + 'MySqlBackup.bat, nil, nil, sw_shownormal)');
      ShellExecute(Self.Handle, 'open', PChar(MySqlBackup.Pfad + 'MySqlBackup.bat'), nil, nil, sw_shownormal);
      Option.LastBackup := IncDay(Startzeit, 1);
      s := FormatDateTime('dd.mm.yyyy hh:nn:ss', Option.LastBackup);
      Log('Option.LastBackup (neu) = ' + s);
      if (Trim(Option.Anzahl) > '') and (StrToInt(Option.Anzahl) > 0) then
      begin
        fDatei.Pfad      := Option.Backupverzeichnis;
        fDatei.Dateiname := Option.Backupname;
        fDateisystem.ReadFiles(Option.Backupverzeichnis, fDateiList, false, fDatei.FullDateinameWithoutExt + '*.' + fDatei.Ext);
        fDateiList.NachLastWriteTimeSortieren(false); // Die neuesten zuerst
        fDateisystem.DeleteFilesAusserDieErstenAnzahl(fDateiList, StrToInt(Option.Anzahl));
      end;
    end;
  finally
    fCheckTimer.Enabled := true;
  end;
end;


function TBackupchecker.getStartZeit(aStartTime: TDateTime): TDateTime;
begin
  Result := fDateTime.SetTimeToDate(now, aStartTime);
end;


procedure TBackupchecker.setFullDataFilename(const Value: string);
begin
  AllgemeinObj.Log.DebugInfo('TBackupchecker.setFullDataFilename / Value = ' + Value);
  AllgemeinObj.Log.DienstInfo('TBackupchecker.setFullDataFilename / Value = ' + Value);


  fFullDataFilename := '';
  if not FileExists(Value) then
  begin
    AllgemeinObj.Log.BackupInfo('Backupdatei exisitiert nicht: ' + Value);
    exit;
  end;
  fDataPfad := ExtractFilePath(Value);
  fFullDataFilename := Value;
  fOptionList.LoadFromFile(fFullDataFilename);
  fAktualData := false;
end;

procedure TBackupchecker.setTimerEnabled(const Value: Boolean);
begin
  fTimerEnabled := Value;
  fCheckTimer.Enabled := fTimerEnabled;
  if Value then
  begin
    AllgemeinObj.Log.DebugInfo('Timer = true');
    AllgemeinObj.Log.DienstInfo('Timer = true');
  end
  else
  begin
    AllgemeinObj.Log.DebugInfo('Timer = false');
    AllgemeinObj.Log.DienstInfo('Timer = false');
  end;
end;

procedure TBackupchecker.ErzeugeBat(aOption: TOption);
var
  Bat: TStringList;
  Backupname: string;
begin
  Bat := TStringList.Create;
  try
    Backupname := GetFileNameWithoutExt(aOption.Backupname);
    Backupname := ChangeFileName(aOption.Backupname, Backupname + '_' + FormatDateTime('yyyy-mm-dd hhnnss', now));
    Bat.Text := '"' + IncludeTrailingPathDelimiter(aOption.MySqlDumpDir) + 'mysqldump.exe" -u' + aOption.Username +
                ' -p' + aOption.Passwort +
                ' -P' + aOption.Port + ' ' + aOption.Datenbankname + ' > "' + IncludeTrailingPathDelimiter(aOption.Backupverzeichnis) +
                Backupname;
    Winapi.Windows.DeleteFile(PWideChar(MySqlBackup.Pfad + 'MySqlBackup.bat'));
    Bat.SaveToFile(MySqlBackup.Pfad + 'MySqlBackup.bat');
  finally
    FreeAndNil(bat);
  end;
end;

procedure TBackupchecker.Log(aValue: string);
begin
  AllgemeinObj.Log.DebugInfo(aValue);
  AllgemeinObj.Log.BackupInfo(aValue);
  AllgemeinObj.Log.Dienstinfo(aValue);
end;


end.
