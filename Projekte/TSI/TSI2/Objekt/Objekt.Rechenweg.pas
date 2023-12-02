unit Objekt.Rechenweg;

interface

uses
  System.Classes, System.SysUtils, DateUtils, Rest.KursList;


type
  TRechenweg = class
  private
    fRestKursList: TRestKursList;
    fKursAlt: real;
    fKursNeu: real;
    fKursDatumAlt: TDateTime;
    fKursDatumNeu: TDateTime;
    fResultKursDatum: TDateTime;
    procedure LadeKursList(aAkId: Integer);
    function getKurs(aDatum: TDateTime): real;
    function getLetzterKurs: real;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    procedure Tage365(aAkId: Integer);
    property KursAlt: real read fKursAlt;
    property KursNeu: real read fKursNeu;
    property KursDatumAlt: TDateTime read fKursDatumAlt;
    property KursDatumNeu: TDateTime read fKursDatumNeu;

  end;


implementation

{ TRechenweg }

uses
  ClientModul.Classes, ClientModul.Module, Rest.Kurs;


constructor TRechenweg.Create;
begin
  fRestKursList    := TRestKursList.Create;
  Init;
end;

destructor TRechenweg.Destroy;
begin
  FreeAndNil(fRestKursList);
  inherited;
end;


procedure TRechenweg.Init;
begin
  fKursAlt := 0;
  fKursNeu := 0;
  fKursDatumAlt := 0;
  fKursDatumNeu := 0;
end;


procedure TRechenweg.LadeKursList(aAkId: Integer);
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
  List: TStringList;
  Kurs: TRestKurs;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule2.DSRestConnection1);
  Stream := Temp.Kurs(aAkId);
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestKursList.LoadFromStream(MemStream);
  Kurs := fRestKursList.Item[fRestKursList.Count-1];
  List := TStringList.Create;
  List.Add('KU_ID: ' + Kurs.FieldByName('ID').AsString);
  List.Add('KU_AK_ID: ' + Kurs.FieldByName('KU_AK_ID').AsString);
  List.Add('KU_DATUM: ' + Kurs.FieldByName('KU_DATUM').AsString);
  List.Add('KU_KURS: ' + Kurs.FieldByName('KU_KURS').AsString);
  FreeAndNil(List);
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;

procedure TRechenweg.Tage365(aAkId: Integer);
var
  KursDatum: TDateTime;
begin
  Init;
  LadeKursList(aAkId);

  fKursNeu := getLetzterKurs;
  fKursDatumNeu := fResultKursDatum;

  KursDatum := IncDay(fKursDatumNeu, -365);
  fKursAlt := getKurs(KursDatum);
  fKursDatumAlt := fResultKursDatum;

end;

function TRechenweg.getKurs(aDatum: TDateTime): real;
var
  i1: Integer;
  Kurs: TRestKurs;
begin
  Result := 0;
  for i1 := 0 to fRestKursList.Count -1 do
  begin
    Kurs := fRestKursList.Item[i1];
    if aDatum <= StrToDate(Kurs.FieldByName('KU_DATUM').AsString) then
    begin
      Result := Kurs.FieldByName('KU_KURS').AsFloat;
      fResultKursDatum := Kurs.FieldByName('KU_DATUM').AsDateTime;
      exit;
    end;
  end;
end;


function TRechenweg.getLetzterKurs: real;
var
  Kurs: TRestKurs;
begin
  Result := 0;
  if fRestKursList.Count = 0 then
    exit;

  Kurs := fRestKursList.Item[fRestKursList.Count-1];
  Result := Kurs.FieldByName('KU_KURS').AsFloat;
  fResultKursDatum := Kurs.FieldByName('KU_DATUM').AsDateTime;
end;


end.
