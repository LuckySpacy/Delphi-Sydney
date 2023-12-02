unit Objekt.Option;

interface

uses
  SysUtils, Classes;

type
  TOption = class
  private
    fVon: string;
    //fStartZeit: TDateTime;
    fNach: string;
    fId: Integer;
    fAnzahl_Quell: string;
    fAnzahl_Ziel: string;
    fVerschieben: String;
    fLastCopy: TDateTime;
    fZippen: string;
    function SetTimeToDate(aDate, aTime: TDateTime): TDateTime;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property Von: string read fVon write fVon;
    property Nach: string read fNach write fNach;
    property Id: Integer read fId write fId;
    property Anzahl_Quell: string read fAnzahl_Quell write fAnzahl_Quell;
    property Anzahl_Ziel: string read fAnzahl_Ziel write fAnzahl_Ziel;
    property Zippen: string read fZippen write fZippen;
    //property StartZeit: TDateTime read fStartZeit write fStartzeit;
    property Verschieben: String read fVerschieben write fVerschieben;
    property LastCopy: TDateTime read fLastCopy write fLastCopy;
    function getCSVLine: string;
    procedure setCSVLine(aValue: string);
  end;

implementation

{ TOption }

uses
  DateUtils;

constructor TOption.Create;
begin
  Init;
end;

destructor TOption.Destroy;
begin

  inherited;
end;


procedure TOption.Init;
begin
  fVon := '';
  //fStartZeit := 0;
  fNach := '';
  fId := 0;
  fAnzahl_Quell := '0';
  fAnzahl_Ziel  := '0';
  fVerschieben := '0';
  fZippen := '0';
  fLastCopy := now;
end;

function TOption.getCSVLine: string;
begin
  Result := IntToStr(fId) + ';' +
            fVon + ';' +
            fNach + ';' +
            //TimeToStr(fStartZeit) + ';' +
            fAnzahl_Quell + ';' +
            fAnzahl_Ziel + ';' +
            fVerschieben  + ';' +
            fZippen;
end;


procedure TOption.setCSVLine(aValue: string);
var
  List: TStringList;
begin
  List := TStringList.Create;
  try
    List.StrictDelimiter := true;
    List.Delimiter := ';';
    List.DelimitedText := aValue;
    fId := StrToInt(List.Strings[0]);
    fVon := List.Strings[1];
    fNach := List.Strings[2];
    //fStartZeit := StrToTime(List.Strings[3]);
    fAnzahl_Quell  := List.Strings[3];
    fAnzahl_Ziel   := List.Strings[4];
    fVerschieben   := List.Strings[5];
    if List.Count > 6  then
      fZippen        := List.Strings[6];
    //fStartZeit := SetTimeToDate(now, fStartZeit);
  finally
    FreeAndNil(List);
  end;
end;


function TOption.SetTimeToDate(aDate, aTime: TDateTime): TDateTime;
var
  Tag: Word;
  Monat: Word;
  Jahr: Word;
  Stunde: Word;
  Minute: Word;
  Sekunde: Word;
  Milli: Word;
begin
  DecodeDate(aDate, Jahr, Monat, Tag);
  DecodeTime(aTime, Stunde, Minute, Sekunde, Milli);
  Result := EncodeDateTime(Jahr, Monat, Tag, Stunde, Minute, Sekunde, Milli);
end;

end.
