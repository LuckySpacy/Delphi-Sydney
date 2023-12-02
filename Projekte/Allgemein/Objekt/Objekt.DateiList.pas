unit Objekt.DateiList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Objekt.Datei;

type
  TDateiList = class(TBasisList)
  private
    function getDatei(Index: Integer): TDatei;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: TDatei; overload;
    function Add(aFullFilename: string): TDatei; overload;
    property Item[Index: Integer]: TDatei read getDatei;
    procedure NachDateinameSortieren;
    procedure NachLastWriteTimeSortieren(const Asc:Boolean= true);
  end;

implementation

{ TDateiList }


function DateinameSortieren(Item1, Item2: Pointer): Integer;
begin
  Result := AnsiCompareText(LowerCase(TDatei(Item1).Dateiname), LowerCase(TDatei(Item2).Dateiname));
end;

function LastWriteTimeSortieren(Item1, Item2: Pointer): Integer;
begin
  if TDatei(Item1).Datum.LastWriteTime = TDatei(Item2).Datum.LastWriteTime then
  begin
    Result := 0;
    exit;
  end;
  if TDatei(Item1).Datum.LastWriteTime < TDatei(Item2).Datum.LastWriteTime then
    Result := -1
  else
    Result := 1;
end;

function LastWriteTimeSortierenDesc(Item1, Item2: Pointer): Integer;
begin
  if TDatei(Item1).Datum.LastWriteTime = TDatei(Item2).Datum.LastWriteTime then
  begin
    Result := 0;
    exit;
  end;
  if TDatei(Item1).Datum.LastWriteTime > TDatei(Item2).Datum.LastWriteTime then
    Result := -1
  else
    Result := 1;
end;


constructor TDateiList.Create;
begin
  inherited;
end;


destructor TDateiList.Destroy;
begin

  inherited;
end;

function TDateiList.getDatei(Index: Integer): TDatei;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TDatei(fList[Index]);
end;



function TDateiList.Add(aFullFilename: string): TDatei;
begin
  Result := Add;
  Result.FullDateiname := aFullFilename;
end;

function TDateiList.Add: TDatei;
begin
  Result := TDatei.Create;
  inc(fId);
  Result.Id := fId;
  fList.Add(Result);
end;

procedure TDateiList.NachDateinameSortieren;
begin
  fList.sort(@DateinameSortieren);
end;


procedure TDateiList.NachLastWriteTimeSortieren(const Asc:Boolean= true);
begin
  if Asc then
    fList.sort(@LastWriteTimeSortieren)
  else
    fList.sort(@LastWriteTimeSortierenDesc);
end;

end.
