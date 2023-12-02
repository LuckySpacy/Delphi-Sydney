unit Objekt.BugreportMail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Objekt.Ini;


type
  TBugreportMail = class
  private
    fPfad: string;
    fIni: TIni;
    function getPfad: string;
  public
    property Pfad: string read getPfad;
    constructor Create;
    destructor Destroy; override;
    function Ini: TIni;
  end;

var
  BugreportMail: TBugreportMail;

implementation

{ TBugreportMail }

constructor TBugreportMail.Create;
begin
  fPfad := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  fIni  := TIni.Create;
  fIni.Pfad := fPfad;
end;

destructor TBugreportMail.Destroy;
begin
  FreeAndNil(fIni);
  inherited;
end;

function TBugreportMail.getPfad: string;
begin
  Result := fPfad;
end;

function TBugreportMail.Ini: TIni;
begin
  Result := fIni;
end;

end.
