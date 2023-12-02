unit Objekt.CSVAktieList;

interface

uses
  SysUtils, Classes, Objekt.BasisList, Objekt.CSVAktie, Objekt.Dateiformat;

type
  TCSVAktieList = class(TBasisList)
  private
    fFileList: TStringList;
    fAktie: string;
    fWKN: string;
    fDateiFormat: TDateiformat;
    function getCSVAktie(Index: Integer): TCSVAktie;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TCSVAktie;
    property Item[Index: Integer]: TCSVAktie read getCSVAktie;
    function LoadFromFile(aFullFilename: string): Boolean;
    property Aktie: string read fAktie write fAktie;
    property WKN: string read fWKN write fWKN;
    procedure setDateiFormat(aDateiformat: TDateiFormat);
  end;

implementation

{ TCSVAktieList }

uses
  FMX.Types, Objekt.TSIServer2;


constructor TCSVAktieList.Create;
begin
  inherited;
  fFileList := TStringList.Create;
end;

destructor TCSVAktieList.Destroy;
begin
  FreeAndNil(fFileList);
  inherited;
end;

function TCSVAktieList.getCSVAktie(Index: Integer): TCSVAktie;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TCSVAktie(fList[Index]);
end;


function TCSVAktieList.Add: TCSVAktie;
begin
  Result := TCSVAktie.Create;
  fList.Add(Result);
end;


function TCSVAktieList.LoadFromFile(aFullFilename: string): Boolean;
var
  i1: Integer;
  CSVAktie: TCSVAktie;
  Filename: string;
begin
  Result := false;
  fFileList.Clear;
  fList.Clear;
  fWKN := '';
  fAktie := '';
  if not FileExists(aFullFilename) then
    exit;
  fFileList.LoadFromFile(aFullFilename);
  Filename := ExtractFileName(aFullFilename);
  i1 := Pos('_', Filename);
  if i1 > 0 then
  begin
    fWkn   := copy(Filename, 1, i1-1);
    fAktie := copy(Filename, i1+1, Length(Filename));
    fAktie := copy(fAktie, 1, Length(fAktie)-4);
  end;

  for i1 := 1 to fFileList.Count -1 do
  begin
    if Trim(fFileList.Strings[i1]) = '' then
      continue;
    CSVAktie := Add;
    CSVAktie.setDateiformat(fDateiFormat);
    if not CSVAktie.Line(fFileList.Strings[i1]) then
    begin
      TSIServer2.Protokoll.write('CSVKurseToDB', 'Fehler in Datei: "' + aFullFilename + '"');
      TSIServer2.Protokoll.write('CSVKurseToDB', 'Zeile: ' + IntToStr(i1));
      TSIServer2.Protokoll.write('CSVKurseToDB', 'Zeile: ' + fFileList.Strings[i1]);
      Result := false;
      exit;
    end;
  end;
  Result := true;
end;



procedure TCSVAktieList.setDateiFormat(aDateiformat: TDateiFormat);
begin
  fDateiFormat := aDateiformat;
end;

end.
