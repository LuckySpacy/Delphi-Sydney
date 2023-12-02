unit Objekt.HarddriveCloneFormIni;

interface

uses
  SysUtils, Types, Registry, Variants, Windows, Classes, Objekt.Ini;

type
  THarddriveCloneFormIni = class
  private
    fIni: TIni;
    fFullFileName: string;
    fSection: string;
    fFormHeight: Integer;
    fFormWidth: Integer;
    function getFormHeight: Integer;
    function getFormWidth: Integer;
    procedure setFormHeight(const Value: Integer);
    procedure setFormWidth(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    property FullFileName: string read fFullFileName write fFullFileName;
    property FormHeight: Integer read getFormHeight write setFormHeight;
    property FormWidth: Integer read getFormWidth write setFormWidth;
  end;


implementation

{ THarddriveCloneFormIni }

constructor THarddriveCloneFormIni.Create;
begin
  fFullFileName := '';
  fSection := 'FormEinstellung';
  fIni := TIni.Create;
end;

destructor THarddriveCloneFormIni.Destroy;
begin
  FreeAndNil(fIni);
  inherited;
end;


function THarddriveCloneFormIni.getFormHeight: Integer;
begin
  Result := fIni.ReadInt(fFullFileName, fSection, 'FormHeight', 460);
end;

function THarddriveCloneFormIni.getFormWidth: Integer;
begin
  Result := fIni.ReadInt(fFullFileName, fSection, 'FormWidth', 650);
end;

procedure THarddriveCloneFormIni.setFormHeight(const Value: Integer);
begin
  fIni.WriteIni(fFullFileName, fSection, 'FormHeight', IntToStr(Value));
end;

procedure THarddriveCloneFormIni.setFormWidth(const Value: Integer);
begin
  fIni.WriteIni(fFullFileName, fSection, 'FormWidth', IntToStr(Value));
end;

end.
