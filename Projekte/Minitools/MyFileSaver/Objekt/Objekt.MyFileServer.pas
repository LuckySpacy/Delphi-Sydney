unit Objekt.MyFileServer;

interface

uses
  SysUtils, Classes, Objekt.OptionList, Objekt.Option, Objekt.Dateisystem,
  Objekt.DateiList, Vcl.ExtCtrls;

type
  TMyFileServer = class
  private
    fOptionList: TOptionList;
    fDateiSystem: TDateisystem;
    fDateiList: TDateiList;
    fTimerEnabled: Boolean;
    fCheckTimer: TTimer;
    procedure setTimerEnabled(const Value: Boolean);
    procedure Check(Sender: TObject);
    procedure DeleteFileEvent(aDeleteFile: string);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    function Pfad: string;
    function DataFilename: string;
    procedure CopyStart;
    property TimerEnabled: Boolean read fTimerEnabled write setTimerEnabled;
  end;

var
  MyFileServer: TMyFileServer;


implementation

{ TMyFileServer }

uses
  Objekt.Allgemein, DateUtils, Winapi.Windows;


constructor TMyFileServer.Create;
var
  //fInterval: Integer;
  i1: Integer;
begin
  AllgemeinObj.Pfad := Pfad;
  fOptionList := TOptionList.Create;
  fDateiSystem := TDateisystem.Create;
  fDateiSystem.OnDeleteFile := DeleteFileEvent;
  fDateiList := TDateiList.Create;
  fCheckTimer := TTimer.Create(nil);
  fCheckTimer.Enabled := false;
  fCheckTimer.OnTimer := Check;
  //fInterval := StrToInt(AllgemeinObj.Ini.Dienst.IntervalInMinuten);
  //fCheckTimer.Interval := 1000 * 60 * fInterval;
  //fCheckTimer.Interval := 1000;
  if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
    AllgemeinObj.Log.DebugInfo('Interval = ' + IntToStr(fCheckTimer.Interval));
  fOptionList.LoadFromFile(DataFilename);

  for i1 := 0 to fOptionList.Count -1 do
    fOptionList.Item[i1].LastCopy :=  now;

end;

function TMyFileServer.DataFilename: string;
begin
  Result := Pfad + 'DataFile.dat';
end;


destructor TMyFileServer.Destroy;
begin
  FreeAndNil(fOptionList);
  FreeAndNil(fDateiSystem);
  FreeAndNil(fDateiList);
  FreeAndNil(fCheckTimer);
  inherited;
end;

procedure TMyFileServer.Init;
begin

end;

function TMyFileServer.Pfad: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

procedure TMyFileServer.setTimerEnabled(const Value: Boolean);
begin
  fTimerEnabled := Value;
  fCheckTimer.Enabled := fTimerEnabled;
  if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
  begin
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
end;

procedure TMyFileServer.CopyStart;
var
  i1, i2: Integer;
  sPfad: string;
  Datei: string;
  ZielDatei: string;
  ZielPfad: string;
  s: string;
  Anzahl: Integer;
begin
  if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
    AllgemeinObj.Log.DebugInfo('DataFilename= ' + DataFilename);
  //fOptionList.LoadFromFile(DataFilename);
  if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
    AllgemeinObj.Log.DebugInfo('OptionList.Count= ' + IntToStr(fOptionList.Count));
  for i1 := 0 to fOptionList.Count -1 do
  begin
    if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
    begin
      //s := FormatDateTime('dd.mm.yyyy hh:nn:ss', fOptionList.Item[i1].StartZeit);
      AllgemeinObj.Log.DebugInfo('Startzeit = ' + s);
    end;

    //if fOptionList.Item[i1].StartZeit >= now then
    //  continue;

    sPfad  := ExtractFilePath(fOptionList.Item[i1].Von);
    Datei := ExtractFileName(fOptionList.Item[i1].Von);
    if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
    begin
      AllgemeinObj.Log.DebugInfo('Pfad  = ' + sPfad);
      AllgemeinObj.Log.DebugInfo('Datei = ' + Datei);
    end;
    fDateiSystem.ReadFiles(sPfad, fDateiList, false, Datei);
    if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
      AllgemeinObj.Log.DebugInfo('fDateiList.Count= ' + IntToStr(fDateiList.Count));
    for i2 := 0 to fDateiList.Count -1 do
    begin
      ZielDatei := ExtractFileName(fDateiList.Item[i2].FullDateiname);
      ZielPfad := IncludeTrailingPathDelimiter(fOptionList.Item[i1].Nach);
      ZielDatei := ZielPfad + ZielDatei;
      if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
        AllgemeinObj.Log.DebugInfo('Von: "' + fDateiList.Item[i2].FullDateiname + ' / Nach:' + Zieldatei);
      copyfile(PWideChar(fDateiList.Item[i2].FullDateiname), PWideChar(Zieldatei), false);
      if fOptionList.Item[i1].Verschieben = '1' then
      begin
        DeleteFile(PWideChar(fDateiList.Item[i2].FullDateiname));
        if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
          AllgemeinObj.Log.DebugInfo('DeleteFile = ' + fDateiList.Item[i2].FullDateiname);
      end;
    end;
    {
    fOptionList.Item[i1].StartZeit := IncDay(fOptionList.Item[i1].StartZeit, 1);
    if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
    begin
      s := FormatDateTime('dd.mm.yyyy hh:nn:ss', fOptionList.Item[i1].StartZeit);
      AllgemeinObj.Log.DebugInfo('Neue Startzeit = ' + s);
    end;
     }
    if not TryStrToInt(fOptionList.Item[i1].Anzahl_Quell, Anzahl) then
      Anzahl := 0;
    if Anzahl > 0 then
    begin
      if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
        AllgemeinObj.Log.DebugInfo('Die ersten ' + IntToStr(Anzahl) + ' Quelldatensätze werden gelöscht');
      fDateiList.NachLastWriteTimeSortieren(false);
      fDateiSystem.DeleteFilesAusserDieErstenAnzahl(fDateiList, Anzahl);
    end;



    if not TryStrToInt(fOptionList.Item[i1].Anzahl_Ziel, Anzahl) then
      Anzahl := 0;

    if Anzahl > 0 then
    begin
      fDateiSystem.ReadFiles(ExtractFilePath(Zieldatei), fDateiList, false, Datei);
      fDateiList.NachLastWriteTimeSortieren(false);
      if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
        AllgemeinObj.Log.DebugInfo('Die ersten ' + IntToStr(Anzahl) + ' Zieldatensätze werden gelöscht');
      fDateiSystem.DeleteFilesAusserDieErstenAnzahl(fDateiList, Anzahl);
    end;


  end;
end;


procedure TMyFileServer.Check(Sender: TObject);
begin
  //Log('Check ' + IntToStr(fOptionList.Count) );
  fCheckTimer.Enabled := false;
  try
    CopyStart;
  finally
    fCheckTimer.Enabled := true;
  end;
end;


procedure TMyFileServer.DeleteFileEvent(aDeleteFile: string);
begin
  if AllgemeinObj.Ini.Dienst.DebugInfo = '1' then
    AllgemeinObj.Log.DebugInfo('Datei "' + aDeleteFile + ' wird gelöscht');
end;



end.
