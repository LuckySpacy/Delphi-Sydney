unit Objekt.Bibliothek;

interface

uses
  System.Classes, System.SysUtils;

type
  TBibliothek = class
  private
    fList: TStringList;
    fMadCollectionList: TStringList;
    fTMSList: TStringList;
    fRichviewList: TStringList;
    fGnosticeList: TStringList;
    fFastreportList: TStringList;
    function getDelimitedText: string;
    procedure setDelimitedText(const Value: string);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property DelimitedText: string read getDelimitedText write setDelimitedText;
    function Find(aValue: String): Integer;
    procedure Add(aValue: string);
    function getText: string;
    procedure Clear;
    procedure LadeMadCollectionPfade;
    function MadCollectionList: TStringList;
    procedure LadeTMSPfade;
    procedure LadeRichview;
    procedure LadeGnosticePfade;
    procedure LadeFastreportPfade;
    function RichviewList: TStringList;
    function TMSList: TStringList;
    function GnosticeList: TStringList;
    function FastreportList: TStringList;
  end;

implementation

{ TBibliothek }

//



constructor TBibliothek.Create;
begin
  fList := TStringList.Create;
  fList.Delimiter := ';';
  fList.StrictDelimiter := true;
  fList.Duplicates := dupIgnore;
  fList.Sorted := true;

  fMadCollectionList := TStringList.Create;
  fMadCollectionList.Delimiter := ';';
  fMadCollectionList.StrictDelimiter := true;
  fMadCollectionList.Duplicates := dupIgnore;
  fMadCollectionList.Sorted := true;

  fTMSList := TStringList.Create;
  fTMSList.Delimiter := ';';
  fTMSList.StrictDelimiter := true;
  fTMSList.Duplicates := dupIgnore;
  fTMSList.Sorted := true;

  fRichviewList := TStringList.Create;
  fRichviewList.Delimiter := ';';
  fRichviewList.StrictDelimiter := true;
  fRichviewList.Duplicates := dupIgnore;
  fRichviewList.Sorted := true;

  fGnosticeList := TStringList.Create;
  fGnosticeList.Delimiter := ';';
  fGnosticeList.StrictDelimiter := true;
  fGnosticeList.Duplicates := dupIgnore;
  fGnosticeList.Sorted := true;

  fFastreportList := TStringList.Create;
  fFastreportList.Delimiter := ';';
  fFastreportList.StrictDelimiter := true;
  fFastreportList.Duplicates := dupIgnore;
  fFastreportList.Sorted := true;




end;

destructor TBibliothek.Destroy;
begin
  FreeAndNil(fTMSList);
  FreeAndNil(fMadCollectionList);
  FreeAndNil(fList);
  FreeAndNil(fRichviewList);
  FreeAndNil(fGnosticeList);
  FreeAndNil(fFastreportList);
  inherited;
end;

procedure TBibliothek.Clear;
begin
  fList.Clear;
end;


function TBibliothek.getDelimitedText: string;
begin
  Result := fList.DelimitedText;
end;


procedure TBibliothek.setDelimitedText(const Value: string);
begin
  fList.DelimitedText := Value;
end;



function TBibliothek.Find(aValue: String): Integer;
var
  i1: Integer;
begin
  Result := -1;
  for i1 := 0 to fList.Count -1 do
  begin
    if SameText(aValue, fList.Strings[i1]) then
    begin
      Result := i1;
      exit;
    end;
  end;
end;

procedure TBibliothek.Add(aValue: string);
var
  Index: Integer;
  Suche: string;
begin
  Suche := aValue;
  if aValue[Length(Suche)] = ';' then
    Suche := copy(Suche, 1, Length(Suche)-1);

  Index := Find(Suche);
  if Index = -1 then
    fList.Add(Suche+';');
end;

function TBibliothek.getText: string;
var
  i1: Integer;
  s: string;
begin
  Result := '';
  for i1 := 0 to fList.Count -1 do
  begin
    s := fList.Strings[i1];
    if s = '' then
      continue;
    if s[Length(s)] = ';' then
      Result := Result + fList.Strings[i1]
    else
      Result := Result + fList.Strings[i1] + ';';
  end;
end;




procedure TBibliothek.LadeMadCollectionPfade;
  procedure AddToMadCollection(aValue: string);
  var
    s: string;
  begin
    s := StringReplace(aValue, '\win32', '\win64', [rfReplaceAll, rfIgnoreCase]);
    fMadCollectionList.Add(s);
  end;
var
  i1: Integer;
begin
  fMadCollectionList.Clear;
  for i1 := 0 to fList.Count -1 do
  begin
    if Pos('madBasic\BDS21\win32', fList.Strings[i1]) > 0 then
      AddToMadCollection(fList.Strings[i1]);
    if Pos('madDisAsm\BDS21\win32', fList.Strings[i1]) > 0 then
      AddToMadCollection(fList.Strings[i1]);
    if Pos('madExcept\BDS21\win32', fList.Strings[i1]) > 0 then
      AddToMadCollection(fList.Strings[i1]);
    if Pos('madKernel\BDS21\win32', fList.Strings[i1]) > 0 then
      AddToMadCollection(fList.Strings[i1]);
    if Pos('madSecurity\BDS21\win32', fList.Strings[i1]) > 0 then
      AddToMadCollection(fList.Strings[i1]);
    if Pos('madShell\BDS21\win32', fList.Strings[i1]) > 0 then
      AddToMadCollection(fList.Strings[i1]);
    if Pos('Plugins\BDS21\win32', fList.Strings[i1]) > 0 then
      AddToMadCollection(fList.Strings[i1]);
  end;
end;

procedure TBibliothek.LadeRichview;
var
  i1: Integer;
  s: string;
begin
  fRichviewList.Clear;
  for i1 := 0 to fList.Count -1 do
  begin
    s := fList.Strings[i1];
    if Pos('$(TRichViewVCL)', s) > 0 then
      fRichviewList.Add(s);
  end;
end;

procedure TBibliothek.LadeTMSPfade;
var
  i1: Integer;
  s: string;
begin
  fTMSList.Clear;
  for i1 := 0 to fList.Count -1 do
  begin
    s := fList.Strings[i1];
    if Pos('TMS VCL UI Pack\', s) > 0 then
    begin
      if Pos('\Win32\', s) > 0 then
        s := StringReplace(s, '\win32\', '\win64\', [rfReplaceAll, rfIgnoreCase]);
      fTMSList.Add(s);
    end;
  end;
end;


procedure TBibliothek.LadeGnosticePfade;
  procedure AddToGnostice(aValue: string);
  var
    s: string;
  begin
    s := StringReplace(aValue, '\win32', '\win64', [rfReplaceAll, rfIgnoreCase]);
    fGnosticeList.Add(s);
  end;
var
  i1: Integer;
begin
  fGnosticeList.Clear;
  for i1 := 0 to fList.Count -1 do
  begin
    if Pos('\Gnostice\', fList.Strings[i1]) > 0 then
      AddToGnostice(fList.Strings[i1]);
  end;
end;


procedure TBibliothek.LadeFastreportPfade;
var
  i1: Integer;
  s: string;
begin
  fFastreportList.Clear;
  for i1 := 0 to fList.Count -1 do
  begin
    s := fList.Strings[i1];
    if Pos('\FastReport 6 VCL Professional', s) > 0 then
    begin
      if Pos('\Win32\', s) > 0 then
        s := StringReplace(s, '\win32\', '\win64\', [rfReplaceAll, rfIgnoreCase]);
      if Pos('FastReport 6 VCL Professional\LIBD27', s) > 0 then
        s := s + 'x64';

      fFastreportList.Add(s);
    end;
  end;
end;


function TBibliothek.TMSList: TStringList;
begin
  Result := fTMSList;
end;


function TBibliothek.MadCollectionList: TStringList;
begin
  result := fMadCollectionList;
end;

function TBibliothek.RichviewList: TStringList;
begin
  Result := fRichviewList;
end;

function TBibliothek.GnosticeList: TStringList;
begin
  Result := fGnosticeList;
end;

function TBibliothek.FastreportList: TStringList;
begin
  Result := fFastreportList;
end;



end.
