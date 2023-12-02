unit Objekt.FileSaver;

interface

uses
  SysUtils, Classes, Objekt.OptionList, Objekt.Option, Objekt.Dateisystem,
  Objekt.DateiList, Vcl.ExtCtrls, Objekt.Allgemein, Objekt.Zip, Objekt.Datei;

type
  TFileSaver = class
  private
    fOptionList: TOptionList;
    fDateiSystem: TDateisystem;
    fDateiList: TDateiList;
    fDatei: TDatei;
    fAllgemein: TAllgemeinObj;
    fZip: TZip;
    procedure DeleteFileEvent(aDeleteFile: string);
  protected
  public
    constructor Create(aAllgemein: TAllgemeinObj);
    destructor Destroy; override;
    procedure Init;
    function Pfad: string;
    function DataFilename: string;
    procedure CopyStart;
  end;


implementation

{ TFileSaver }

uses
  DateUtils, Winapi.Windows;

constructor TFileSaver.Create(aAllgemein: TAllgemeinObj);
begin
  fZip := TZip.Create;
  fDatei := TDatei.Create;
  fAllgemein := aAllgemein;
  fAllgemein.Pfad := Pfad;
  //AllgemeinObj.Pfad := Pfad;
  fOptionList := TOptionList.Create;
  fDateiSystem := TDateisystem.Create;
  fDateiSystem.OnDeleteFile := DeleteFileEvent;
  fDateiList := TDateiList.Create;
  fOptionList.LoadFromFile(DataFilename);
end;


destructor TFileSaver.Destroy;
begin
  FreeAndNil(fOptionList);
  FreeAndNil(fDateiSystem);
  FreeAndNil(fDateiList);
  FreeAndNil(fDatei);
  FreeAndNil(fZip);
  inherited;
end;

procedure TFileSaver.Init;
begin

end;



procedure TFileSaver.CopyStart;
var
  i1, i2: Integer;
  sPfad: string;
  Datei: string;
  ZielDatei: string;
  ZielPfad: string;
  Anzahl: Integer;
begin
  if fAllgemein.Ini.Dienst.DebugInfo = '1' then
    fAllgemein.Log.DebugInfo('DataFilename= ' + DataFilename);
  //fOptionList.LoadFromFile(DataFilename);
  if fAllgemein.Ini.Dienst.DebugInfo = '1' then
    fAllgemein.Log.DebugInfo('OptionList.Count= ' + IntToStr(fOptionList.Count));
  for i1 := 0 to fOptionList.Count -1 do
  begin
    sPfad  := ExtractFilePath(fOptionList.Item[i1].Von);
    Datei := ExtractFileName(fOptionList.Item[i1].Von);
    if fAllgemein.Ini.Dienst.DebugInfo = '1' then
    begin
      fAllgemein.Log.DebugInfo('Pfad  = ' + sPfad);
      fAllgemein.Log.DebugInfo('Datei = ' + Datei);
    end;
    fDateiSystem.ReadFiles(sPfad, fDateiList, false, Datei);
    if fAllgemein.Ini.Dienst.DebugInfo = '1' then
      fAllgemein.Log.DebugInfo('fDateiList.Count= ' + IntToStr(fDateiList.Count));
    for i2 := 0 to fDateiList.Count -1 do
    begin
      ZielDatei := ExtractFileName(fDateiList.Item[i2].FullDateiname);
      ZielPfad := IncludeTrailingPathDelimiter(fOptionList.Item[i1].Nach);
      ZielDatei := ZielPfad + ZielDatei;
      if fOptionList.Item[i1].Zippen = '1' then
      begin
        fDatei.FullDateiname := ZielDatei;
        fDatei.ChangeExt('zip');
        ZielDatei := fDatei.FullDateiname;
      end;
      if fAllgemein.Ini.Dienst.DebugInfo = '1' then
        fAllgemein.Log.DebugInfo('Von: "' + fDateiList.Item[i2].FullDateiname + ' / Nach:' + Zieldatei);
      if fOptionList.Item[i1].Zippen = '1' then
      begin
        if fAllgemein.Ini.Dienst.DebugInfo = '1' then
          fAllgemein.Log.DebugInfo('Zippen');
        fZip.DoZipFile(Zieldatei, fDateiList.Item[i2].FullDateiname);
      end
      else
      begin
        fAllgemein.Log.DebugInfo('Start --> copyfile');
        copyfile(PWideChar(fDateiList.Item[i2].FullDateiname), PWideChar(Zieldatei), false);
        fAllgemein.Log.DebugInfo('Ende --> copyfile');
      end;
      if fOptionList.Item[i1].Verschieben = '1' then
      begin
        DeleteFile(PWideChar(fDateiList.Item[i2].FullDateiname));
        if fAllgemein.Ini.Dienst.DebugInfo = '1' then
          fAllgemein.Log.DebugInfo('DeleteFile = ' + fDateiList.Item[i2].FullDateiname);
      end;
    end;
    if not TryStrToInt(fOptionList.Item[i1].Anzahl_Quell, Anzahl) then
      Anzahl := 0;
    if Anzahl > 0 then
    begin
      if fAllgemein.Ini.Dienst.DebugInfo = '1' then
        fAllgemein.Log.DebugInfo('Die ersten ' + IntToStr(Anzahl) + ' Quelldatensätze werden gelöscht');
      fDateiList.NachLastWriteTimeSortieren(false);
      fDateiSystem.DeleteFilesAusserDieErstenAnzahl(fDateiList, Anzahl);
    end;

    if not TryStrToInt(fOptionList.Item[i1].Anzahl_Ziel, Anzahl) then
      Anzahl := 0;

    if Anzahl > 0 then
    begin
      if fOptionList.Item[i1].Zippen = '1' then
      begin
        fDatei.FullDateiname := Datei;
        fDatei.ChangeExt('zip');
        Datei := fDatei.Dateiname;
      end;

      fDateiSystem.ReadFiles(ExtractFilePath(Zieldatei), fDateiList, false, Datei);
      fDateiList.NachLastWriteTimeSortieren(false);
      if fAllgemein.Ini.Dienst.DebugInfo = '1' then
        fAllgemein.Log.DebugInfo('Die ersten ' + IntToStr(Anzahl) + ' Zieldatensätze werden gelöscht');
      fDateiSystem.DeleteFilesAusserDieErstenAnzahl(fDateiList, Anzahl);
    end;
  end;
end;



function TFileSaver.DataFilename: string;
begin
  Result := Pfad + 'DataFile.dat';
end;

procedure TFileSaver.DeleteFileEvent(aDeleteFile: string);
begin

end;


function TFileSaver.Pfad: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

end.
