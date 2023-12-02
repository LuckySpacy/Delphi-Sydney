unit Objekt.Datei;

interface

uses
  SysUtils, Classes;


type
  TDatei = class
  private
    fDatei: string;
    fBetreff: string;
    fId: Integer;
    fEMail: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property Id: Integer read fId write fId;
    property Datei: string read fDatei write fDatei;
    property Betreff: string read fBetreff write fBetreff;
    property EMail: string read fEMail write fEMail;
    function getCSVLine: string;
    procedure setCSVLine(aValue: string);
  end;

implementation

{ TDatei }

constructor TDatei.Create;
begin
  Init;
end;

destructor TDatei.Destroy;
begin

  inherited;
end;


procedure TDatei.Init;
begin
  fId      := 0;
  fDatei   := '';
  fBetreff := '';
  fEMail := '';
end;

procedure TDatei.setCSVLine(aValue: string);
var
  Liste: TStringList;
begin
  Liste := TStringList.Create;
  try
    Init;
    Liste.Delimiter := '~';
    Liste.StrictDelimiter := true;
    Liste.DelimitedText := aValue;
    if Liste.Count >= 1 then
      fBetreff := Liste.Strings[0];
    if Liste.Count >= 2 then
      fDatei   := Liste.Strings[1];
    if Liste.Count >= 3 then
      fEMail   := Liste.Strings[2];
  finally
    FreeAndNil(Liste);
  end;
end;

function TDatei.getCSVLine: string;
begin
  Result := fBetreff + '~' + fDatei + '~' + fEMail;
end;


end.
