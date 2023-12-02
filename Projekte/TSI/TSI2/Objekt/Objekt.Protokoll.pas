unit Objekt.Protokoll;

interface

uses
  SysUtils, Classes;


type
  TAfterWriteEvent=procedure(aValue: string) of Object;
  TProtokoll = class
  private
    fList: TStringList;
    fProtokollPfad: String;
    fFilename: string;
    fOnAfterWrite: TAfterWriteEvent;
    procedure setProtokollpfad(const Value: string);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Protokollpfad: string read fProtokollpfad write setProtokollpfad;
    property Filename: string read fFilename write fFilename;
    procedure write(aFunction, aValue: string);
    procedure Clear;
    function List: TStringList;
    procedure Load;
    property OnAfterWrite: TAfterWriteEvent read fOnAfterWrite write fOnAfterWrite;
  end;

implementation

{ TProtokoll }


constructor TProtokoll.Create;
begin
  fList := TStringList.Create;
  fProtokollPfad := '';
  fFilename := '';
end;

destructor TProtokoll.Destroy;
begin
  FreeAndNil(fList);
  inherited;
end;

procedure TProtokoll.Clear;
begin
  if FileExists(fProtokollPfad + fFilename) then
    DeleteFile(fProtokollPfad + fFilename);
end;


function TProtokoll.List: TStringList;
begin
  Result := fList;
end;

procedure TProtokoll.Load;
begin
  if (FileExists(fProtokollPfad + fFilename)) then
    fList.LoadFromFile(fProtokollPfad + fFilename);
end;

procedure TProtokoll.setProtokollpfad(const Value: string);
begin
  fProtokollpfad := IncludeTrailingPathDelimiter(Value);
end;

procedure TProtokoll.write(aFunction, aValue: string);
var
  s: string;
begin
  if (fList.Text = '') and (FileExists(fProtokollPfad + fFilename)) then
    fList.LoadFromFile(fProtokollPfad + fFilename);
  s := FormatDateTime('dd.mm.yyyy hh:nn:ss', now) + ' - ' + aFunction + ' - ' +aValue;
  fList.Add(s);
  fList.SaveToFile(fProtokollPfad + fFilename);
  if Assigned(fOnAfterWrite) then
    fOnAfterWrite(s);
end;

end.
