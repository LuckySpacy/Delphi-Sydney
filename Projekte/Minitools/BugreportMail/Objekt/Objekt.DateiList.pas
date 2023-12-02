unit Objekt.DateiList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BaseList, Objekt.Datei;

type
  TDateiList = class(TBaseList)
  private
    function getDatei(Index: Integer): TDatei;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TDatei;
    property Item[Index: Integer]: TDatei read getDatei;
    procedure SaveToFile(aFullFilename: string);
    procedure LoadFromFile(aFullFilename: string);
    procedure LoadFromString(aValue: string);
    procedure Delete(aId: Integer);
  end;

implementation

{ TDateiList }

uses
  Objekt.Allgemein;

constructor TDateiList.Create;
begin
  inherited;

end;


destructor TDateiList.Destroy;
begin

  inherited;
end;


function TDateiList.Add: TDatei;
begin
  Result := TDatei.Create;
  inc(fId);
  Result.Id := fId;
  fList.Add(Result);
end;


procedure TDateiList.Delete(aId: Integer);
var
  i1: Integer;
begin
  for i1 := 0 to fList.Count -1 do
  begin
    if TDatei(fList.Items[i1]).Id = aId then
    begin
      fList.Delete(i1);
      exit;
    end;
  end;
end;


function TDateiList.getDatei(Index: Integer): TDatei;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDatei(fList[Index]);
end;

procedure TDateiList.LoadFromFile(aFullFilename: string);
var
  Liste : TStringList;
  Plain: string;
begin
  if not FileExists(aFullFilename) then
    exit;
  Liste := TStringList.Create;
  try
    Liste.LoadFromFile(aFullFilename);
    Plain := AllgemeinObj.Entschluesseln(Liste.Text);
    LoadFromString(Plain);
  finally
    FreeAndNil(Liste);
  end;

end;

procedure TDateiList.LoadFromString(aValue: string);
var
  Liste : TStringList;
  i1: Integer;
  Datei: TDatei;
begin
  fList.Clear;
  Liste := TStringList.Create;
  try
    Liste.Text := aValue;
    for i1 := 0 to Liste.Count -1 do
    begin
      Datei := Add;
      Datei.setCSVLine(Liste.Strings[i1]);
    end;
  finally
    FreeAndNil(Liste);
  end;
end;

procedure TDateiList.SaveToFile(aFullFilename: string);
var
  i1: Integer;
  Liste: TStringList;
  s: string;
begin
  if FileExists(aFullFilename) then
    DeleteFile(aFullFilename);
  Liste := TStringList.Create;
  try
    for i1 := 0 to fList.Count -1 do
    begin
      s := TDatei(fList.Items[i1]).getCSVLine;
      Liste.Add(s);
    end;
    Liste.Text := AllgemeinObj.Verschluesseln(Liste.Text);
    Liste.SaveToFile(aFullFilename);
  finally
    FreeAndNil(Liste);
  end;
end;

end.
