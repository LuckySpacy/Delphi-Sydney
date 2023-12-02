unit Objekt.IniAllgemein;

interface

uses
  IniFiles, SysUtils, Types, Variants, Classes, Objekt.Ini, Objekt.IniBase;

type
  TIniAllgemein = class(TIniBase)
  private
    function getSchnittstelle: string;
    procedure setSchnittstelle(const Value: string);
    function getUhrzeit: string;
    procedure setUhrzeit(const Value: string);
    function getDownloadPfad: string;
    procedure setDownloadPfad(const Value: string);
    function getZielPfad: string;
    procedure setZielPfad(const Value: string);
    function getDatenbankserver: string;
    procedure setDatenbankserver(const Value: string);
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Schnittstelle: string read getSchnittstelle write setSchnittstelle;
    property Uhrzeit: string read getUhrzeit write setUhrzeit;
    property DownloadPfad: string read getDownloadPfad write setDownloadPfad;
    property ZielPfad: string read getZielPfad write setZielPfad;
    property Datenbankserver: string read getDatenbankserver write setDatenbankserver;
  end;

implementation

{ TIniAllgemein }

constructor TIniAllgemein.Create;
begin
  inherited;
  fSection := 'Allgemein';
end;

destructor TIniAllgemein.Destroy;
begin

  inherited;
end;

function TIniAllgemein.getDatenbankserver: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'Datenbankserver', ''));
end;

function TIniAllgemein.getDownloadPfad: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'DownloadPfad', ''));
end;

function TIniAllgemein.getSchnittstelle: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'Schnittstelle', ''));
end;

function TIniAllgemein.getUhrzeit: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'Uhrzeit', ''));
end;

function TIniAllgemein.getZielPfad: string;
begin
  Result := Entschluesseln(ReadIni(fIniFullName, fSection, 'Zielpfad', ''));
end;

procedure TIniAllgemein.setDatenbankserver(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'Datenbankserver', Verschluesseln(Value));
end;

procedure TIniAllgemein.setDownloadPfad(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'DownloadPfad', Verschluesseln(Value));
end;

procedure TIniAllgemein.setSchnittstelle(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'Schnittstelle', Verschluesseln(Value));
end;

procedure TIniAllgemein.setUhrzeit(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'Uhrzeit', Verschluesseln(Value));
end;

procedure TIniAllgemein.setZielPfad(const Value: string);
begin
  WriteIni(fIniFullname, fSection, 'Zielpfad', Verschluesseln(Value));
end;

end.
