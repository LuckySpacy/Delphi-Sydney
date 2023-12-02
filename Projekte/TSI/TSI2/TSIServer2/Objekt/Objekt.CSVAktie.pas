unit Objekt.CSVAktie;

interface

uses
  SysUtils, Classes, Objekt.Dateiformat;

type
  TCSVAktie = class
  private
    fHoch: string;
    fSchluss: Currency;
    fTief: string;
    fDatum: TDateTime;
    fVolumen: string;
    fEroeffnung: string;
    Liste: TStringList;
    fDateiFormat: TDateiFormat;
    function GetDatum(aValue: string): TDateTime;
    function GetDatumValue(aValue: string; aSign: String): String;
    function GetStrNummeric(aValue: string): string;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Datum: TDateTime read fDatum write fDatum;
    property Eroeffnung: string read fEroeffnung write fEroeffnung;
    property Hoch: string read fHoch write fHoch;
    property Tief: string read fTief write fTief;
    property Schluss: Currency read fSchluss write fSchluss;
    property Volumen: string read fVolumen write fVolumen;
    function Line(aValue: string): Boolean;
    procedure setDateiformat(aDateiFormat: TDateiFormat);
  end;


implementation

{ TCSVAktie }

uses
  DateUtils, Objekt.TSIServer2;

constructor TCSVAktie.Create;
begin
  fHoch       := '';
  fSchluss    := 0;
  fTief       := '';
  fDatum      := 0;
  fVolumen    := '';
  fEroeffnung := '';
  Liste := TStringList.Create;
  Liste.Delimiter := ';';
  Liste.StrictDelimiter := true;
  fDateiFormat := nil;
end;

destructor TCSVAktie.Destroy;
begin
  FreeAndNil(Liste);
  inherited;
end;

function TCSVAktie.Line(aValue: string): Boolean;
var
  s: String;
  LastValue: Integer;
begin
  Result := false;
  if fDateiFormat = nil then
    exit;
  if Trim(aValue) = '' then
    exit;

  if fDateiFormat.Trennzeichen = '' then
    exit;


//  Liste.DelimitedText := aValue;

//  if not TryStrToDate(Trim(Liste.Strings[0]), fDatum) then
//    fDatum := 0;
{
  s := Liste.Strings[4];
  s := StringReplace(s, '.', '', [rfReplaceAll]);
  if not TryStrToCurr(s, fSchluss) then
    fSchluss := 0;

  fEroeffnung := Trim(Liste.Strings[1]);
  fHoch       := Trim(Liste.Strings[2]);
  fTief       := Trim(Liste.Strings[3]);
  fVolumen    := Trim(Liste.Strings[5]);

}
  try
    Liste.Clear;
    Liste.Delimiter := fDateiFormat.Trennzeichen[1];
    Liste.DelimitedText := aValue;

    LastValue := 0;
    if LastValue < fDateiFormat.PosDatum-1 then
      LastValue := fDateiFormat.PosDatum-1;
    if LastValue < fDateiFormat.PosSchluss-1 then
      LastValue := fDateiFormat.PosSchluss-1;
    if LastValue < fDateiFormat.PosEroeffnung-1 then
      LastValue := fDateiFormat.PosEroeffnung-1;
    if LastValue < fDateiFormat.PosHoch-1 then
      LastValue := fDateiFormat.PosHoch-1;
    if LastValue < fDateiFormat.PosTief-1 then
      LastValue := fDateiFormat.PosTief-1;
    if LastValue < fDateiFormat.PosVolumen-1 then
      LastValue := fDateiFormat.PosVolumen-1;


    // Hier mal schauen warum das auf dem STRATOSERVER zum Fehler kommmt
    if Liste.Count < LastValue + 1 then
    begin
      TSIServer2.Protokoll.write('CSVKurseToDB', 'In Zeile sind weniger als : ' + IntToStr(LastValue) + ' Einträge vorhanden');
      exit;
    end;

    s := Liste.Strings[fDateiFormat.PosDatum-1];
    fDatum := getDatum(s);

    if SameText(Liste.Strings[fDateiFormat.PosSchluss-1], 'null') then
    begin // Wenn an einem Tag keine Kurse vorhanden sind, dann gibt Yahoo finance den Wert Null zurück
      fSchluss := -1;
      fEroeffnung := '-1';
      fHoch := '-1';
      fTief := '-1';
      fVolumen := '-1';
      Result := true;
      exit;
    end;

    s := GetStrNummeric(Liste.Strings[fDateiFormat.PosSchluss-1]);
    TryStrToCurr(s, fSchluss);

    fEroeffnung := GetStrNummeric(Liste.Strings[fDateiFormat.PosEroeffnung-1]);
    fHoch       := GetStrNummeric(Liste.Strings[fDateiFormat.PosHoch-1]);
    fTief       := GetStrNummeric(Liste.Strings[fDateiFormat.PosTief-1]);
    fVolumen    := GetStrNummeric(Liste.Strings[fDateiFormat.PosVolumen-1]);
    Result := true;
  except
    on e: Exception do
    begin
      TSIServer2.Protokoll.write('CSVKurseToDB', 'Fehler in TCSVAktie.Line: "' + e.Message + '"');
      Result := false;
    end;
  end;
end;

function TCSVAktie.GetStrNummeric(aValue: string): string;
var
  c: Currency;
begin
  Result := StringReplace(aValue, '.', ',', [rfReplaceAll]);
  if not TryStrToCurr(Result, c) then
    Result := '0'
  else
    Result := CurrToStr(c);
end;


function TCSVAktie.GetDatum(aValue: string): TDateTime;
var
  sJahr : string;
  sMonat: string;
  sTag  : string;
  sDatum: string;
begin
  Result := 0;
  sJahr  := GetDatumValue(aValue, 'y');
  sMonat := GetDatumValue(aValue, 'm');
  sTag   := GetDatumValue(aValue, 'd');
  if (sJahr = '') or (sMonat = '') or (sTag = '') then
    exit;
  if Length(sMonat) = 1 then
    sMonat := '0' + sMonat;
  if Length(sTag) = 1 then
    sTag := '0' + sTag;
  if Length(sJahr) = 2 then
    sJahr := '20' + sJahr;
  if length(sMonat) > 2 then
    exit;
  if length(sTag) > 2 then
    exit;
  if length(sJahr) > 4 then
    exit;
  sDatum := sTag + '.' + sMonat + '.' + sJahr;
  if not TryStrToDate(sDatum, Result) then
    Result := 0;
end;

function TCSVAktie.GetDatumValue(aValue: string; aSign: String): String;
var
  iPosStart: Integer;
  iPosEnde: Integer;
  i1: Integer;
  DatumFormat: string;
begin
  Result := '';
  iPosStart := 0;
  iPosEnde  := 0;
  i1 := 0;
  DatumFormat := LowerCase(fDateiFormat.DatumFormat);
  while i1 < Length(DatumFormat) do
  begin
    inc(i1);
    if DatumFormat[i1] <> aSign then
       continue;
    if iPosStart = 0 then
    begin
      iPosStart := i1;
      continue;
    end;
    iPosEnde := i1;
  end;
  if (iPosStart = 0) or (iPosEnde = 0) then
    exit;
  iPosEnde := iPosEnde - iPosStart + 1;
  Result := copy(aValue, iPosStart, iPosEnde);
end;


procedure TCSVAktie.setDateiformat(aDateiFormat: TDateiFormat);
begin
  fDateiFormat := aDateiFormat;
end;

end.

