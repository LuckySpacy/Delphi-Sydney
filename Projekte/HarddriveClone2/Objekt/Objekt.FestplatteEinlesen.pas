unit Objekt.FestplatteEinlesen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Objekt.ProzessBasis, Thread.FestplatteEinlesen, Objekt.DateiList,
  Objekt.Datei, db.Datei, db.JobDatei, db.JobDateiList, Objekt.Dateisystem, db.DateiList,
  Objekt.IgnorePfadList;

type
  TFestplatteEinlesen = class(TProzessBasis)
  private
    fCancel: Boolean;
    fQuell: TDateiList;
    fZiel: TDateiList;
    fThreadFestplatteEinlesen: TThreadFestplatteEinlesen;
    fDBDatei: TDBDatei;
    fDBDateiList: TDBDateiList;
    fDBJobDatei: TDBJobDatei;
    fDBJobDateiList: TDBJobDateiList;
    fStartZeit: TDateTime;
    fDateiSystem: TDateiSystem;
    fJoId: Integer;
    fOnSyncZielPfadEnd: TNotifyEvent;
    fIgnorePfadList: TIgnorePfadList;
    fAktualDatenbank: Boolean;
    procedure DatenbankAktual(aDatei: TDatei; aProgress: Integer; var aCancel: Boolean);
    procedure DatenbankZielAktual(aDatei: TDatei; aProgress: Integer; var aCancel: Boolean);
    procedure DatenbankAktualStart(aCount: Integer);
    procedure InfoProzess(aProzessInfo: string; var aCancel: Boolean);
    procedure SyncZielPfadEnd(Sender: TObject);
    procedure VorgangAbbrechen(Sender: TObject);
    function IgnorePfad(aFullFilename: string): Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure setQuell(aQuell: TDateiList);
    procedure Read(aPfad: string; aJoId: Integer);
    property StartZeit: TDateTime read fStartZeit write fStartZeit;
    procedure SyncZiel(aJoId: Integer);
    property OnSyncZielPfadEnd: TNotifyEvent read fOnSyncZielPfadEnd write fOnSyncZielPfadEnd;
    property IgnorePfadList: TIgnorePfadList read fIgnorePfadList write fIgnorePfadList;
    property Cancel: Boolean read fCancel write fCancel;
  end;


implementation

{ TFestplatteEinlesen }

uses
  Objekt.HarddriveClone2, dm.Datenbank, fmx.Types;

constructor TFestplatteEinlesen.Create;
begin
  inherited;
  fIgnorePfadList := nil;
  fThreadFestplatteEinlesen := TThreadFestplatteEinlesen.Create;
  fThreadFestplatteEinlesen.OnReadEnd := Finished;
  fThreadFestplatteEinlesen.OnDatenbankAktualStart := DatenbankAktualStart;
  fThreadFestplatteEinlesen.OnDatenbankAktual      := DatenbankAktual;

  fDBDatei := TDBDatei.Create(nil);
  fDBDatei.Trans := dm_Datenbank.IBTrans_Write;

  fDBJobDatei := TDBJobDatei.Create(nil);
  fDBJobDatei.Trans := dm_Datenbank.IBTrans_Write;

  fDBJobDateiList := TDBJobDateiList.Create;
  fDBJobDateiList.Trans := dm_Datenbank.IBTrans_Write;
  fZiel := TDateiList.Create;

  fDateiSystem := TDateiSystem.Create;

  fDBDateiList := TDBDateiList.Create;
  fDBDateiList.Trans := dm_Datenbank.IBTrans_Read;


end;


destructor TFestplatteEinlesen.Destroy;
begin
  FreeAndNil(fThreadFestplatteEinlesen);
  FreeAndNil(fDBDatei);
  FreeAndNil(fDBJobDatei);
  FreeAndNil(fDBJobDateiList);
  FreeAndNil(fZiel);
  FreeAndNil(fDateiSystem);
  FreeAndNil(fDBDateiList);
  inherited;
end;





procedure TFestplatteEinlesen.Read(aPfad: string; aJoId: Integer);
begin
  fThreadFestplatteEinlesen.OnReadEnd := Finished;
  fThreadFestplatteEinlesen.OnDatenbankAktualStart := DatenbankAktualStart;
  fThreadFestplatteEinlesen.OnDatenbankAktual      := DatenbankAktual;
  fThreadFestplatteEinlesen.OnInfoProzess          := InfoProzess;
  fThreadFestplatteEinlesen.IgnorePfadList         := fIgnorePfadList;
  fThreadFestplatteEinlesen.Cancel := false;
  if Assigned(fOnInfo) then
    fOnInfo('Festplatte einlesen: ', '', fCancel);
  if dm_Datenbank.IBTrans_Write.InTransaction then
    HarddriveClone2.Log.Info('Festplatte einlesen: InTransaction');

  fAktualDatenbank := fDBDateiList.CountChangedDatumNotToday(aJoId) > 0;
  if (not fAktualDatenbank) and (fDBDateiList.CountFiles(aJoId) = 0) then
    fAktualDatenbank := true; // Wenn noch nie Daten eingelesen wurden, dann Daten auf jeden Fall in die DB eintragen

  fQuell.Clear;
  fThreadFestplatteEinlesen.Read(fQuell, aPfad);
end;


procedure TFestplatteEinlesen.setQuell(aQuell: TDateiList);
begin
  fQuell := aQuell;
  fQuell.Clear;
end;


procedure TFestplatteEinlesen.SyncZiel(aJoId: Integer);
var
  i1: Integer;
  Pfad: string;
begin
  fJoId := aJoId;
  fZiel.Clear;
  Pfad := '';
  for i1 := 0 to HarddriveClone2.DBJobList.Count -1 do
  begin
    if HarddriveClone2.DBJobList.Item[i1].Id = aJoId then
    begin
      HarddriveClone2.JobIndex := i1;
      Pfad := HarddriveClone2.DBJobList.Item[i1].Zielpfad;
      break;
    end;
  end;
  if Pfad = '' then
    exit;
  fStartZeit := now;
  HarddriveClone2.Log.Info('');
  HarddriveClone2.Log.Info('---------------------------------------------------------------------------------------------');
  HarddriveClone2.Log.Info('Sync Zielverzeichnis: ' + IntToStr(HarddriveClone2.DBJobList.Item[i1].Id));
  HarddriveClone2.Log.Info('Quelle: ' + HarddriveClone2.DBJobList.Item[i1].Quellpfad);
  HarddriveClone2.Log.Info('Ziel: ' + HarddriveClone2.DBJobList.Item[i1].Zielpfad);

  fThreadFestplatteEinlesen.OnReadEnd := SyncZielPfadEnd;
  fThreadFestplatteEinlesen.OnDatenbankAktual := DatenbankZielAktual;
  fThreadFestplatteEinlesen.OnInfoProzess     := InfoProzess;
  fThreadFestplatteEinlesen.OnCancel          := VorgangAbbrechen;

  if Assigned(fOnInfo) then
    fOnInfo('Sync Zielverzeichnis: ' + HarddriveClone2.DBJobList.Item[i1].Zielpfad, '', fCancel);

  fThreadFestplatteEinlesen.Cancel := false;
  fThreadFestplatteEinlesen.Read(fZiel, Pfad);
end;

procedure TFestplatteEinlesen.SyncZielPfadEnd(Sender: TObject);
var
  i1: Integer;
begin
  fDBJobDateiList.ReadJobAndChangedDatum(fJoId, fStartZeit);
  if fDBJobDateiList.Count > 0 then
  begin
    if Assigned(fOnInfo) then
      fOnInfo('Lösche aus Datenbank', '', fCancel);
    if fCancel then
    begin
      if Assigned(fOnSyncZielPfadEnd) then
        fOnSyncZielPfadEnd(Self);
      exit;
    end;
    if Assigned(fOnProgressStart) then
      fOnProgressStart(fDBJobDateiList.Count, fCancel);
    for i1 := 0 to fDBJobDateiList.Count -1 do
    begin
      if Assigned(fOnProgressInfo) then
        fOnInfoProzess(fDBJobDateiList.Item[i1].Datei, fCancel);
      if Assigned(fOnProgressInfo) then
        fOnProgressInfo(i1+1, fCancel);
      if fCancel then
      begin
        if Assigned(fOnSyncZielPfadEnd) then
          fOnSyncZielPfadEnd(Self);
        exit;
      end;

      HarddriveClone2.Log.Info('Lösche aus DB: ' + fDBJobDateiList.Item[i1].Datei);
      fDBJobDateiList.Item[i1].DBDelete.Trans := dm_Datenbank.IBTrans_Write;
      fDBJobDateiList.Item[i1].DBDelete.Execute(fDBJobDateiList.Item[i1].Id);
    end;
  end;
  if Assigned(fOnSyncZielPfadEnd) then
    fOnSyncZielPfadEnd(Self);
end;

procedure TFestplatteEinlesen.VorgangAbbrechen(Sender: TObject);
begin
  if Assigned(fOnSyncZielPfadEnd) then
    fOnSyncZielPfadEnd(Self);
end;

procedure TFestplatteEinlesen.DatenbankZielAktual(aDatei: TDatei;
  aProgress: Integer; var aCancel: Boolean);
var
  s: string;
  ZielBaseDir: string;
  Quelldatei: string;
begin
  if Assigned(fOnInfoProzess) then
    fOnInfoProzess(aDatei.FullDateiname, fCancel);
  if Assigned(fOnProgressInfo) then
    fOnProgressInfo(aProgress, fCancel);

  aCancel := fCancel;
  if aCancel then
    exit;

  if dm_Datenbank.IBTrans_Write.InTransaction then
    HarddriveClone2.Log.Info('DatenbankZielAktual: InTransaction');


  fDBJobDatei.ReadJobDateiname(fJoId, aDatei.FullDateiname);
  if fDBJobDatei.Id = 0 then
  begin
    ZielBaseDir := IncludeTrailingPathDelimiter(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Zielpfad);
    s := ExtractFilePath(aDatei.FullDateiname);
    s := copy(s, Length(ZielBaseDir), Length(s));
    if s[1] = '\' then
      s := copy(s, 2, Length(s));
    s := IncludeTrailingPathDelimiter(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Quellpfad) + s;
    Quelldatei := s + ExtractFileName(aDatei.FullDateiname);
    fDBDatei.ReadDateiname(Quelldatei);
    if (fDBDatei.Id = 0) and (not FileExists(Quelldatei)) then
    begin
      DeleteFile(aDatei.FullDateiname);
      fDateiSystem.RemoveAllEmptyDir(aDatei.FullDateiname, HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Zielpfad);
      HarddriveClone2.Log.Info('Quelldatei aus Zieldatei nicht gefunden "' + aDatei.FullDateiname + '"');
      exit;
    end;
    if fDBDatei.Id = 0 then
    begin
      fDBDatei.Datei := Quelldatei;
      fDBDatei.SaveToDB;
    end;
    fDBJobDatei.DaId  := fDBDatei.Id;
    fDBJobDatei.JoId  := fJoId;
    fDBJobDatei.Datei := aDatei.FullDateiname;
  end;
  fDBJobDatei.ChangeDatum := fStartZeit;
  fDBJobDatei.Dateidatum  := aDatei.Datum.LastWriteTime;
  fDBJobDatei.SaveToDB;

  if dm_Datenbank.IBTrans_Write.InTransaction then
    HarddriveClone2.Log.Info(aDatei.FullDateiname + ': InTransaction');

end;


function TFestplatteEinlesen.IgnorePfad(aFullFilename: string): Boolean;
var
  i1: Integer;
  IgnorePfad: string;
  VglPfad: string;
  InPfad: string;
begin
  Result := true;
  InPfad := IncludeTrailingPathDelimiter(ExtractFilePath(aFullFilename));
  for i1 := 0 to fIgnorePfadList.Count -1 do
  begin
    if not fIgnorePfadList.Item[i1].Exact then
      continue;
    IgnorePfad := IncludeTrailingPathDelimiter(fIgnorePfadList.Item[i1].Pfad);
    VglPfad := copy(InPfad, 1, Length(IgnorePfad));
    if SameText(VglPfad, IgnorePfad) then
      exit;
  end;
  Result := false;
end;

procedure TFestplatteEinlesen.DatenbankAktual(aDatei: TDatei;
  aProgress: Integer; var aCancel: Boolean);
var
  Dateiname: string;
  ZielBaseDir: string;
  QuellBaseDir: string;
  s: string;
  FullFilename: string;
begin  // Hier prüfen
   if IgnorePfad(aDatei.FullDateiname) then
     exit;
  if Assigned(fOnInfoProzess) then
    fOnInfoProzess(aDatei.FullDateiname, fCancel);
  if Assigned(fOnProgressInfo) then
    fOnProgressInfo(aProgress, fCancel);


  if dm_Datenbank.IBTrans_Write.InTransaction then
    HarddriveClone2.Log.Info('DatenbankAktual: InTransaction');

  aCancel := fCancel;
  if aCancel then
    exit;

  if not fAktualDatenbank then
    exit;


  fDBDatei.ReadDateiname(aDatei.FullDateiname);
  fDBDatei.Datei := aDatei.FullDateiname;
  fDBDatei.Dateidatum := aDatei.Datum.LastWriteTime;
  fDBDatei.ChangeDatum := fStartZeit;
  //if aProgress = 415 then
  //  fDBDatei.SaveToDB;
  fDBDatei.SaveToDB;
  fDBJobDatei.ReadJobDatei(HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].id, fDBDatei.id);
  if fDBJobDatei.Id = 0 then
  begin
    Dateiname := ExtractFileName(fDBDatei.Datei);
    ZielBaseDir  := HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Zielpfad;
    QuellBaseDir := HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].Quellpfad;
    s := ExtractFilePath(fDBDatei.Datei);
    s := copy(s, Length(QuellBaseDir), Length(s));
    if s[1] = '\' then
      s := copy(s, 2, Length(s));
    FullFilename := IncludeTrailingPathDelimiter(ZielbaseDir + s) + Dateiname;
    fDBJobDatei.JoId := HarddriveClone2.DBJobList.Item[HarddriveClone2.JobIndex].id;
    fDBJobDatei.DaId := fDBDatei.id;
    fDBJobDatei.Datei := FullFilename;
    fDBJobDatei.Dateidatum := 0;
    fDBJobDatei.ChangeDatum := 0;
    fDBJobDatei.SaveToDB;
  end;

  if dm_Datenbank.IBTrans_Write.InTransaction then
    HarddriveClone2.Log.Info(aDatei.FullDateiname + ': InTransaction ' + IntToStr(aProgress));

  log.d(IntToStr(aProgress));
end;

procedure TFestplatteEinlesen.DatenbankAktualStart(aCount: Integer);
begin
  fCancel := false;
  if Assigned(fOnInfo) then
    fOnInfo('Dateien in Datenbank einlesen', '', fCancel);

  if Assigned(fOnProgressStart) then
    fOnProgressStart(aCount, fCancel);
end;


procedure TFestplatteEinlesen.InfoProzess(aProzessInfo: string;
  var aCancel: Boolean);
begin
  if Assigned(fOnInfoProzess) then
    fOnInfoProzess(aProzessInfo, aCancel);
end;


end.
