unit Objekt.Protokoll;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs;

type
  TProtokoll = class
  private
    fFullFilename: string;
    fmyFile: TextFile;
  public
    constructor Create;
    destructor Destroy; override;
    property FullFilename: string read fFullFilename write fFullFilename;
    procedure write(aValue: string);
    procedure Open;
    procedure Close;
  end;

implementation

{ TProtokoll }

uses
  Objekt.HarddriveClone;


constructor TProtokoll.Create;
begin
  fFullFilename := '';
end;

destructor TProtokoll.Destroy;
begin
  inherited;
end;

procedure TProtokoll.Open;
begin
  AssignFile(fmyFile, fFullFilename);
  if FileExists(fFullFilename) then
    append(fmyFile)
  else
    Rewrite(fmyFile);
end;

procedure TProtokoll.Close;
begin
  closeFile(fmyFile);
end;


procedure TProtokoll.write(aValue: string);
var
  s: string;
begin
  s := FormatDateTime('dd.mm.yyyy hh:nn:ss:zzz', now) + ' - ' + aValue;
  writeln(fmyFile, s);
  HarddriveClone.Log.Info(s);
end;

end.
