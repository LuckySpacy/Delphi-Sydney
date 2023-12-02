unit Objekt.Dateidatum;

interface

uses
  SysUtils, Classes, Windows;

type
  TDateidatum = class
  private
    fCreationTime: TDateTime;
    fLastWriteTime: TDateTime;
    fLastAccessTime: TDateTime;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property CreationTime: TDateTime read fCreationTime;
    property LastWriteTime: TDateTime read fLastWriteTime;
    property LastAccessTime: TDateTime read fLastAccessTime;
    function FileDateToDateTime(aFileTime: _FileTime) : TDateTime;
    procedure LeseDatum(aFileAttributeData: TWin32FileAttributeData);
    function LastWriteTimeAsString: string;
  end;

implementation

{ TDateidatum }

constructor TDateidatum.Create;
begin
  Init;
end;

destructor TDateidatum.Destroy;
begin

  inherited;
end;

procedure TDateidatum.Init;
begin
  fCreationTime   := 0;
  fLastWriteTime  := 0;
  fLastAccessTime := 0;
end;


function TDateidatum.LastWriteTimeAsString: string;
begin
  Result := FormatDateTime('dd.mm.yyyy hh:nn:ss', fLastWriteTime);
end;

procedure TDateidatum.LeseDatum(aFileAttributeData: TWin32FileAttributeData);
begin
  fCreationTime   := FileDateToDateTime(aFileAttributeData.ftCreationTime);
  fLastWriteTime  := FileDateToDateTime(aFileAttributeData.ftLastWriteTime);
  fLastAccessTime := FileDateToDateTime(aFileAttributeData.ftLastAccessTime);
end;

function TDateidatum.FileDateToDateTime(aFileTime: _FileTime) : TDateTime;
var
  SystemTime, LocalTime: _SystemTime;
  TZ: _TIME_ZONE_INFORMATION;
begin
  FileTimeToSystemTime(aFileTime, SystemTime);
  GetTimeZoneInformation(TZ);
  SystemTimeToTzSpecificLocalTime(@TZ, SystemTime, LocalTime);
  Result := SystemTimeToDateTime(LocalTime);
end;

end.
