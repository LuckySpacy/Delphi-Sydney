unit Mobil.Feld;

interface

uses
  SysUtils, Classes, variants, Data.DB;
type
  TMobilFeld = class(TComponent)
  private
    fValue: string;
    fChanged: Boolean;
    fFeldName: string;
    fNewInit: Boolean;
    fAlwaysTrim: Boolean;
    fDataType: TFieldType;
    fDatum: TDateTime;
    function getAsString: string;
    procedure setAsString(const Value: string);
    function getInteger: Integer;
    procedure setInteger(const Value: Integer);
    function getAsBoolean: Boolean;
    procedure setAsBoolean(const Value: Boolean);
    function getAsDateTime: TDateTime;
    procedure setAsDateTime(const Value: TDateTime);
    function getAsFloat: Extended;
    procedure setAsFloat(const Value: Extended);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitValue;
    property AsFloat: Extended read getAsFloat write setAsFloat;
    property AsString: string read getAsString write setAsString;
    property AsInteger: Integer read getInteger write setInteger;
    property Changed: Boolean read FChanged write fChanged;
    property Feldname: string read FFeldName write fFeldName;
    property AsBoolean: Boolean read getAsBoolean write setAsBoolean;
    property AsDateTime: TDateTime read getAsDateTime write setAsDateTime;
    property AlwaysTrim: Boolean read fAlwaysTrim write fAlwaysTrim;
    property DataType: TFieldType read fDataType write fDataType;
    function AsFirebirdDateTimeStr: string;
  end;

implementation

{ TMobilFeld }

constructor TMobilFeld.Create(AOwner: TComponent);
begin
  inherited;
  InitValue;
end;
destructor TMobilFeld.Destroy;
begin
  inherited;
end;
procedure TMobilFeld.InitValue;
begin
  FChanged := false;
  FValue := '';
  FNewInit := true;
  fAlwaysTrim := false;
  fDatum := 0;
end;

function TMobilFeld.getAsBoolean: Boolean;
begin
  Result := FValue = 'T';
end;
function TMobilFeld.getAsDateTime: TDateTime;
begin
  Result := fDatum;
  if (fDatum = 0) and (fValue > '') then
  begin
    if not TryStrToDateTime(FValue, Result) then
      Result := 0;
  end;
end;
function TMobilFeld.getAsFloat: Extended;
begin
  if not TryStrToFloat(FValue, Result) then
    Result := 0;
end;
function TMobilFeld.AsFirebirdDateTimeStr: string;
var
  Datum: TDateTime;
begin
  Datum := getAsDateTime;
  Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', Datum);
end;

function TMobilFeld.getAsString: string;
begin
  Result := FValue;
  if fAlwaysTrim then
    Result := Trim(FValue);
end;
function TMobilFeld.getInteger: Integer;
begin
  if not TryStrToInt(FValue, Result) then
    Result := 0;
end;

procedure TMobilFeld.setAsBoolean(const Value: Boolean);
begin
  if Value then
    setAsString('T')
  else
    setAsString('F');
end;
procedure TMobilFeld.setAsDateTime(const Value: TDateTime);
begin
  setAsString(DateTimeToStr(Value));
  fDatum := Value;
  //setAsString(FormatDateTime('yyyy-mm-dd hh:nn:ss', Value));
end;
procedure TMobilFeld.setAsFloat(const Value: Extended);
begin
  setAsString(FloatToStr(Value));
end;
procedure TMobilFeld.setAsString(const Value: string);
begin
  if (not FNewInit) and (Value <> fValue) then
    FChanged := true;
  fValue := Value;
  if fAlwaysTrim then
    FValue := Trim(Value);
  FNewInit := false;
end;
procedure TMobilFeld.setInteger(const Value: Integer);
begin
  setAsString(IntToStr(Value));
end;


end.
