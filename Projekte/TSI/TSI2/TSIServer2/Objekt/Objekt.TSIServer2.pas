unit Objekt.TSIServer2;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  Objekt.Allg, Objekt.Verschluesseln, Objekt.IniTSIServer, System.IOUtils,
  IBX.IBDatabase, Objekt.Protokoll;

type
  TTSIServer2 = class
  private
    //fAllg: TAllg;
    fIniTSIServer: TIniTSIServer;
    fIBT_TSI: TIBTransaction;
    fIBT_Kurse: TIBTransaction;
    fProtokoll: TProtokoll;
  public
    constructor Create;
    destructor Destroy; override;
    function ProgrammPfad: string;
    function Ini: TIniTSIServer;
    function Allg: TAllg;
    property IBT_TSI: TIBTransaction read fIBT_TSI write fIBT_TSI;
    property IBT_Kurse: TIBTransaction read fIBT_Kurse write fIBT_Kurse;
    function IniPfad: string;
    function Protokoll: TProtokoll;
  end;


var
  TSIServer2: TTSIServer2;

implementation

{ TTSIServer2 }


constructor TTSIServer2.Create;
begin
  fIBT_TSI   := nil;
  fIBT_Kurse := nil;
  fIniTSIServer := TIniTSIServer.Create;
  fIniTSIServer.Pfad := IncludeTrailingPathDelimiter(GetHomePath) + 'TSIServer2\';
  if not TDirectory.Exists(fIniTSIServer.Pfad) then
    TDirectory.CreateDirectory(fIniTSIServer.Pfad);
  fProtokoll := TProtokoll.Create;
  fProtokoll.Protokollpfad := fIniTSIServer.Pfad;
  fProtokoll.Filename := 'Protokoll.txt';
end;

destructor TTSIServer2.Destroy;
begin
  FreeAndNil(fIniTSIServer);
  FreeAndNil(fProtokoll);
  inherited;
end;

function TTSIServer2.Ini: TIniTSIServer;
begin
  Result := fIniTSIServer;
end;

function TTSIServer2.IniPfad: string;
begin
  Result := fIniTSIServer.Pfad;
end;

function TTSIServer2.Allg: TAllg;
begin
  Result := nil;
end;


function TTSIServer2.ProgrammPfad: string;
begin

end;

function TTSIServer2.Protokoll: TProtokoll;
begin
  Result := fProtokoll;
end;

initialization
  TSIServer2 := TTSIServer2.Create;

finalization
 if TSIServer2 <> nil then
   FreeAndNil(TSIServer2);

end.
