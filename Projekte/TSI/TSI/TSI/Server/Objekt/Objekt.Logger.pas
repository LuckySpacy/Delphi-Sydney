unit Objekt.Logger;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Log4d;

type
  TLogger = class
  private
    fPath: string;
    fLogPath: string;
    fServerLog: log4d.TLogLogger;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Info(aValue: string);
    procedure Warn(aValue: string);
    procedure Error(aValue: string);
  end;


var
  Logger: TLogger;

implementation

{ TLogger }

constructor TLogger.Create;
begin
  fPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  if (not FileExists(fPath + 'log4d.props')) then
    raise Exception.Create('Log-Konfigurationsdatei (log4d.props) nicht gefunden');

  TLogPropertyConfigurator.Configure(fPath + 'log4d.props');

  fLogPath := fPath + '\LogFiles\';

  if not DirectoryExists(fLogPath) then
    ForceDirectories(fLogPath);

  fServerLog := TLogLogger.GetLogger('TSIServer');

  if fServerLog.Appenders.Count = 1 then
    (fServerLog.Appenders[0] as ILogRollingFileAppender).renameLogfile(fLogPath + 'TSIServer.log');  //<-- Pfad zuweisen


end;

destructor TLogger.Destroy;
begin
  inherited;
end;

procedure TLogger.Error(aValue: string);
begin
  fServerLog.Error(aValue);
end;

procedure TLogger.Info(aValue: string);
begin
  fServerLog.Info(aValue);
end;

procedure TLogger.Warn(aValue: string);
begin
  fServerLog.Warn(aValue);
end;

end.
