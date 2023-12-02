unit Rest.Basis;

interface

uses

  {$IFNDEF ANDROID}
  DB.Basis,
  {$ENDIF}

  sysUtils, Classes, Mobil.FeldList, Data.db, Mobil.Feld, System.Math;

type
  TRestBasis = class
  private
    procedure setTextZeile(const Value: string);
  protected
    fStream: TMemoryStream;
    fTrenner: String;
    fFeldList: TMobilFeldList;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Init; virtual;
    function getStream: TMemoryStream;
    procedure LoadFromStream(aStream: TMemoryStream);
    function FieldByName(aValue: String): TMobilFeld;
    function getTextZeile: string;
    function FeldList: TMobilFeldList;
    property TextZeile: string read getTextZeile write setTextZeile;
   {$IFNDEF ANDROID}
    procedure CopyFromDBFeldList(aDBBasis: TDBBasis);
  {$ENDIF}
  function Runden(aValue: real; aAnzahlStellen: Integer): real;
  end;
implementation

{ TRestBasis }



constructor TRestBasis.Create;
begin
  fFeldList := TMobilFeldList.Create;
  fStream := TMemoryStream.Create;
  fTrenner := ' ';
  FFeldList.Add('Id', ftInteger);
  fFeldList.Add('UPDATE', ftString);
  fFeldList.Add('DELETE', ftString);
end;

destructor TRestBasis.Destroy;
begin
  FreeAndNil(fFeldList);
  FreeAndNil(fStream);
  inherited;
end;




procedure TRestBasis.Init;
var
  i1: Integer;
begin
  for i1 := 0 to fFeldList.Count -1 do
  begin
    if (fFeldList.Feld[i1].DataType = ftInteger)
    or (fFeldList.Feld[i1].DataType = ftCurrency)
    or (fFeldList.Feld[i1].DataType = ftFloat) then
      fFeldList.Feld[i1].AsInteger := 0;
    if fFeldList.Feld[i1].DataType = ftBoolean then
      fFeldList.Feld[i1].AsBoolean := false;
    if fFeldList.Feld[i1].DataType = ftString then
      fFeldList.Feld[i1].AsString := '';
  end;
end;

function TRestBasis.getStream: TMemoryStream;
var
  fList: TStringList;
begin
  fStream.Clear;
  fList := TStringList.Create;
  try
    fList.Text := getTextZeile;
    fList.SaveToStream(fStream);
    Result := fStream;
  finally
    FreeAndNil(fList);
  end;
end;

function TRestBasis.getTextZeile: string;
var
  i1: Integer;
  s: string;
begin
  s := '';
  for i1 := 0 to fFeldList.Count -1 do
  begin
    if i1 > 0 then
      s := s + fTrenner;
    s := s + fFeldList.Feld[i1].AsString;
  end;
  Result := s;
end;

procedure TRestBasis.LoadFromStream(aStream: TMemoryStream);
var
  List: TStringList;
  List2: TStringList;
  i1: Integer;
begin
  List2 := TStringList.Create;
  List := TStringList.Create;
  try
    aStream.Position := 0;
    List.LoadFromStream(aStream);

    List2.StrictDelimiter := true;
    List2.Delimiter  := fTrenner[1];
    List2.DelimitedText := List.Text;

    for i1 := 0 to fFeldList.Count -1 do
    begin
      if i1 > List2.Count -1 then
        break;
      fFeldList.Feld[i1].AsString := Trim(List2.Strings[i1]);
    end;

  finally
    FreeAndNil(List);
    FreeAndNil(List2);
  end;
end;

procedure TRestBasis.setTextZeile(const Value: string);
var
  List2: TStringList;
  i1: Integer;
begin
  List2 := TStringList.Create;
  try
    List2.StrictDelimiter := true;
    List2.Delimiter  := fTrenner[1];
    List2.DelimitedText := Value;
    for i1 := 0 to fFeldList.Count -1 do
    begin
      if i1 > List2.Count -1 then
        break;
      fFeldList.Feld[i1].AsString := Trim(List2.Strings[i1]);
    end;
  finally
    FreeAndNil(List2);
  end;
end;

function TRestBasis.FeldList: TMobilFeldList;
begin
  Result := fFeldList;
end;

function TRestBasis.FieldByName(aValue: String): TMobilFeld;
begin
  Result := fFeldList.FieldByName(aValue);
end;

{$IFNDEF ANDROID}
procedure TRestBasis.CopyFromDBFeldList(aDBBasis: TDBBasis);
var
  i1: Integer;
begin
  for i1 := 0 to aDBBasis.FeldList.Count -1 do
    fFeldList.Feld[i1].AsString := aDBBasis.FeldList.Feld[i1].AsString;
end;
{$ENDIF}


function TRestBasis.Runden(aValue: real; aAnzahlStellen: Integer): real;
var
  LFactor: Extended;
  e: Extended;
  i: Int64;
begin
  LFactor := IntPower(10.0, aAnzahlStellen*-1);
  e := AValue / LFactor;

  if AValue < 0 then
    e := e - 0.5
  else
    e := e + 0.5;

  i := Trunc(e);
  Result := i * LFactor;

end;








end.
