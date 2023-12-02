unit Objekt.MultiQueryFeld;

interface

uses
  SysUtils, Classes, variants, Data.DB, IBX.IBQuery, FireDAC.Comp.Client,
  FireDAC.Stan.Param;

type
  TMultiQueryFeld = class(TComponent)
  private
    fIBParam: TParam;
    fFDParam: TFDParam;
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
    property AsBoolean: Boolean read getAsBoolean write setAsBoolean;
    property AsDateTime: TDateTime read getAsDateTime write setAsDateTime;
    property IBParam: TParam read fIBParam write fIBParam;
    property FDParam: TFDParam read fFDParam write fFDParam;
    function AsFirebirdDateTimeStr: string;
    function Feldname: string;
    procedure LoadFromStream(AStream: TStream; ABlobType: TFieldType; AIndex: Integer);
  end;

implementation

{ TDBFeld }

constructor TMultiQueryFeld.Create(AOwner: TComponent);
begin
  inherited;
  fFDParam := nil;
  fIBParam := nil;
  InitValue;
end;

destructor TMultiQueryFeld.Destroy;
begin

  inherited;
end;


procedure TMultiQueryFeld.InitValue;
begin
end;



function TMultiQueryFeld.Feldname: string;
begin
  Result := '';
  if fIBParam <> nil then
    Result := fIBParam.Name;
  if fFDParam <> nil then
  begin
    //fFDParam.Size := 4294967296;
    Result := fFDParam.Name;
  end;
end;



function TMultiQueryFeld.getAsBoolean: Boolean;
begin
  Result := false;
  if fIBParam <> nil then
    Result := fIBParam.AsBoolean;
  if fFDParam <> nil then
    Result := fFDParam.AsBoolean;
end;

function TMultiQueryFeld.getAsDateTime: TDateTime;
begin
  Result := 0;
  if fIBParam <> nil then
    Result := fIBParam.AsDateTime;
  if fFDParam <> nil then
    Result := fFDParam.AsDateTime;
end;

function TMultiQueryFeld.getAsFloat: Extended;
begin
  Result := 0;
  if fIBParam <> nil then
    Result := fIBParam.AsFloat;
  if fFDParam <> nil then
    Result := fFDParam.AsFloat;
end;

function TMultiQueryFeld.AsFirebirdDateTimeStr: string;
var
  Datum: TDateTime;
begin
  Datum := getAsDateTime;
  Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', Datum);
end;


function TMultiQueryFeld.getAsString: string;
begin
  Result := '';
  if fIBParam <> nil then
    Result := fIBParam.AsString;
  if fFDParam <> nil then
    Result := fFDParam.AsString;
end;

function TMultiQueryFeld.getInteger: Integer;
begin
  Result := 0;
  if fIBParam <> nil then
    Result := fIBParam.AsInteger;
  if fFDParam <> nil then
    Result := fFDParam.AsInteger;
end;


procedure TMultiQueryFeld.setAsBoolean(const Value: Boolean);
begin
  if fIBParam <> nil then
    fIBParam.AsBoolean := Value;
  if fFDParam <> nil then
    fFDParam.AsBoolean := Value;
end;

procedure TMultiQueryFeld.setAsDateTime(const Value: TDateTime);
begin
  if fIBParam <> nil then
    fIBParam.AsDateTime := Value;
  if fFDParam <> nil then
    fFDParam.AsDateTime := Value;
end;

procedure TMultiQueryFeld.setAsFloat(const Value: Extended);
begin
  if fIBParam <> nil then
    fIBParam.AsFloat := Value;
  if fFDParam <> nil then
    fFDParam.AsFloat := Value;
end;

procedure TMultiQueryFeld.setAsString(const Value: string);
begin
  if fIBParam <> nil then
    fIBParam.AsString := Value;
  if fFDParam <> nil then
    fFDParam.AsString := Value;
end;

procedure TMultiQueryFeld.setInteger(const Value: Integer);
begin
  if fIBParam <> nil then
    fIBParam.AsInteger := Value;
  if fFDParam <> nil then
    fFDParam.AsInteger := Value;
end;

procedure TMultiQueryFeld.LoadFromStream(AStream: TStream;
  ABlobType: TFieldType; AIndex: Integer);
begin
  if fFDParam <> nil then
    fFDParam.LoadFromStream(AStream, aBlobType, AIndex);
end;


end.
