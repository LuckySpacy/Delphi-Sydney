unit Objekt.BasisRestlist;

interface

uses
(*
  {$IFNDEF ANDROID}
    Contnrs,
    Objekt.DBFeldList,
    DB.BasisList, DB.Basis, View.Base,
  {$ENDIF}
 *)
  SysUtils, Classes, Rest.Basis, Mobil.ObjectList, System.Math;

type
  TBasisRestList = class
  private
    function GetCount: Integer;
  protected
    fList: TMobilObjectList;
    fId: Integer;
    fStream: TMemoryStream;
    fTrenner: String;
    fListTrenner: string;
    function AddNew: TRestBasis; virtual; abstract;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    (*
   {$IFNDEF ANDROID}
    procedure CopyFromDBFeldList(aDBBasisList: TDBBasisList; const aView: Boolean = false);
   {$ENDIF}
   *)
    function getStream: TMemoryStream;
    procedure LoadFromStream(aStream: TMemoryStream);
    function Count: Integer;
    procedure Clear;
    function Runden(aValue: real; aAnzahlStellen: Integer): real;
    procedure MoveItem(aCurIndex, aNewIndex: Integer);
  end;

implementation

{ TBasisRestList }



constructor TBasisRestList.Create;
begin
  fList := TMobilObjectList.Create;
  fId := 0;
  fStream := TMemoryStream.Create;
  fTrenner := ' ';
  fListTrenner := '·'; //alt+250
end;

destructor TBasisRestList.Destroy;
begin
  FreeAndNil(fStream);
  FreeAndNil(fList);
  inherited;
end;

function TBasisRestList.GetCount: Integer;
begin
  Result := fList.Count;
end;

function TBasisRestList.Count: Integer;
begin
  Result := GetCount;
end;


procedure TBasisRestList.Clear;
begin
  fList.Clear;
end;

(*
{$IFNDEF ANDROID}
procedure TBasisRestList.CopyFromDBFeldList(aDBBasisList: TDBBasisList; const aView: Boolean = false);
var
  i1, i2: Integer;
  RestBasis: TRestBasis;
begin
  for i1 := 0 to aDBBasisList.List.Count -1 do
  begin
    RestBasis := AddNew;
    if not aView then
    begin
      for i2 := 0 to TDBBasis(aDBBasisList.list.Items[i1]).FeldList.count -1 do
      begin
        RestBasis.FeldList.Feld[i2].AsString := TDBBasis(aDBBasisList.list.Items[i1]).FeldList.Feld[i2].AsString;
      end;
    end;
    if aView then
    begin
      for i2 := 0 to TVWBasis(aDBBasisList.list.Items[i1]).FeldList.count -1 do
        RestBasis.FeldList.Feld[i2].AsString := TVWBasis(aDBBasisList.list.Items[i1]).FeldList.Feld[i2].AsString;
    end;
  end;
end;

{$ENDIF}
*)

function TBasisRestList.getStream: TMemoryStream;
var
  i1: Integer;
  List: TStringList;
  s: string;
begin
  List := TStringList.Create;
  try
    fStream.Clear;
    s := '';
    for i1 := 0 to fList.Count -1 do
    begin
      s := s + TRestBasis(fList.Items[i1]).getTextZeile + fListTrenner;
    end;
    List.Add(s);
    List.SaveToStream(fStream, TEncoding.UTF8);
    fStream.Position := 0;
    Result := fStream;
    if DirectoryExists('d:\Bachmann\Daten\OneDrive\Asus-PC-2018\Programmierung\Delphi\Sydney\Projekte\TSI2\TSISnapServer\bin\') then
      List.SaveToFile('d:\Bachmann\Daten\OneDrive\Asus-PC-2018\Programmierung\Delphi\Sydney\Projekte\TSI2\TSISnapServer\bin\x.txt');

  finally
    FreeAndNil(List);
  end;
end;

procedure TBasisRestList.LoadFromStream(aStream: TMemoryStream);
var
  i1: Integer;
  ListStream: TStringList;
  ListZeilen: TStringList;
  Rest: TRestBasis;
begin
  fList.Clear;
  ListStream  := TStringList.Create;
  ListZeilen  := TStringList.Create;
  try
    aStream.Position := 0;
    ListStream.LoadFromStream(aStream);
    ListZeilen.StrictDelimiter := true;
    ListZeilen.Delimiter  := fListTrenner[1];
    ListZeilen.DelimitedText := Trim(ListStream.Text);

    for i1 := 0 to ListZeilen.Count -1 do
    begin
      if Trim(ListZeilen.Strings[i1]) = '' then
        continue;
      Rest := TRestBasis(AddNew);
      Rest.TextZeile := Trim(ListZeilen.Strings[i1]);
    end;

  finally
    FreeAndNil(ListStream);
    FreeAndNil(ListZeilen);
  end;
end;



procedure TBasisRestList.MoveItem(aCurIndex, aNewIndex: Integer);
begin
  fList.Move(aCurIndex, aNewIndex);
end;

function TBasisRestList.Runden(aValue: real; aAnzahlStellen: Integer): real;
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
