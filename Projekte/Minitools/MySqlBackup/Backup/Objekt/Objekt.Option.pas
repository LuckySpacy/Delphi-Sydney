unit Objekt.Option;

interface

uses
  SysUtils, Classes;


type
  TOption = class
  private
    fPasswort: string;
    fStartZeit: TDateTime;
    fDatenbankname: string;
    fUsername: string;
    fMySqlDumpDir: string;
    fBackupname: string;
    fPort: string;
    fBackupverzeichnis: string;
    fAnzahl: string;
    fId: Integer;
    fLastBackup: TDateTime;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    property MySqlDumpDir: string read fMySqlDumpDir write fMySqlDumpDir;
    property Datenbankname: string read fDatenbankname write fDatenbankname;
    property Username: string read fUsername write fUsername;
    property StartZeit: TDateTime read fStartZeit write fStartZeit;
    property Passwort: string read fPasswort write fPasswort;
    property Port: string read fPort write fPort;
    property Backupverzeichnis: string read fBackupverzeichnis write fBackupverzeichnis;
    property Backupname: string read fBackupname write fBackupname;
    property Anzahl: string read fAnzahl write fAnzahl;
    property Id: Integer read fId write fId;
    property LastBackup: TDateTime read fLastBackup write fLastBackup;
    function getCSVLine: string;
    procedure setCSVLine(aValue: string);
  end;

implementation

{ TOption }

constructor TOption.Create;
begin
  Init;
end;


destructor TOption.Destroy;
begin

  inherited;
end;

procedure TOption.Init;
begin
  fPasswort     := '';;
  fStartZeit    := now;
  fDatenbankname:= '';
  fUsername     := '';
  fMySqlDumpDir := '';
  fBackupname   := '';
  fBackupverzeichnis := '';
  fLastBackup := now;
  fPort := '3306';
  fAnzahl := '1';
  fId := 0;
end;



procedure TOption.setCSVLine(aValue: string);
var
  List: TStringList;
begin
  List := TStringList.Create;
  try
    List.StrictDelimiter := true;
    List.Delimiter := ';';
    List.DelimitedText := aValue;
    fId := StrToInt(List.Strings[0]);
    fMySqlDumpDir := List.Strings[1];
    fDatenbankname := List.Strings[2];
    fUsername := List.Strings[3];
    fStartZeit := StrToTime(List.Strings[4]);
    fPasswort  := List.Strings[5];
    fPort  := List.Strings[6];
    fBackupverzeichnis  := List.Strings[7];
    fBackupname  := List.Strings[8];
    fAnzahl  := List.Strings[9];
  finally
    FreeAndNil(List);
  end;
end;

function TOption.getCSVLine: string;
begin
  Result := IntToStr(fId) + ';' +
            fMySqlDumpDir + ';' +
            fDatenbankname + ';' +
            fUsername + ';' +
            TimeToStr(fStartZeit) + ';' +
            fPasswort + ';' +
            fPort + ';' +
            fBackupverzeichnis + ';' +
            fBackupname + ';' +
            fAnzahl;
end;




end.
