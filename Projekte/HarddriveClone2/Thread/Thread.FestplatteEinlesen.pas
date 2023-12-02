unit Thread.FestplatteEinlesen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Objekt.DateiList, Objekt.Dateisystem, Objekt.Datei, Objekt.IgnorePfadList;

type
  TInfoEvent = procedure(aCaption, aProzessInfo: string) of object;
  TDatenbankAktualEvent = procedure(aDatei: TDatei; aProgress: Integer; var aCancel: Boolean) of object;
  TDatenbankAktualStartEvent = procedure(aCount: Integer) of object;
  TInfoProzessEvent = procedure(aProzessInfo: string; var aCancel: Boolean) of object;
  TThreadFestplatteEinlesen = class
  private
    fOnReadEnd: TNotifyEvent;
    fDateisystem: TDateisystem;
    fLabelFilename: TLabel;
    fOnDatenbankAktual: TDatenbankAktualEvent;
    fOnDatenbankAktualStart: TDatenbankAktualStartEvent;
    fInfoProzess: TInfoProzessEvent;
    fIgnorePfadList: TIgnorePfadList;
    fCancel: Boolean;
    fOnCancel: TNotifyEvent;
    procedure ReadEnd(Sender: TObject);
    procedure CheckCancel(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Read(aDateiList:TDateiList; aPath: string);
    procedure ReadFile(aFilename: string; var aCancel: Boolean);
    property OnReadEnd: TNotifyEvent read fOnReadEnd write fOnReadEnd;
    property OnDatenbankAktual: TDatenbankAktualEvent read fOnDatenbankAktual write fOnDatenbankAktual;
    property OnDatenbankAktualStart: TDatenbankAktualStartEvent read fOnDatenbankAktualStart write fOnDatenbankAktualStart;
    property LabelFilename: TLabel read fLabelFilename write fLabelFilename;
    property OnInfoProzess: TInfoProzessEvent read fInfoProzess write fInfoProzess;
    property IgnorePfadList: TIgnorePfadList read fIgnorePfadList write fIgnorePfadList;
    procedure ReadPath(aPath: string; var aCanRead: Boolean);
    property Cancel: Boolean read fCancel write fCancel;
    property OnCancel: TNotifyEvent read fOnCancel write fOnCancel;
  end;

implementation

{ TThreadFestplatteEinlese }


constructor TThreadFestplatteEinlesen.Create;
begin
  fDateisystem := TDateisystem.Create;
  fDateisystem.OnReadFile := ReadFile;
  fDateisystem.OnCancel := CheckCancel;
  fIgnorePfadList := nil;
  fCancel := false;
end;

destructor TThreadFestplatteEinlesen.Destroy;
begin
  FreeAndNil(fDateisystem);
  inherited;
end;


procedure TThreadFestplatteEinlesen.Read(aDateiList:TDateiList; aPath: string);
var
  t: TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  var
    i1: Integer;
  begin
    fDateisystem.Cancel := fCancel;
    fDateisystem.OnReadFile := ReadFile;

    if fIgnorePfadList <> nil then
      fDateisystem.OnReadPath := ReadPath
    else
      fDateisystem.OnReadPath := nil;

    fDateisystem.ReadFiles(aPath, aDateiList);

    if fCancel then
    begin
      i1 := 99;
      exit;
    end;

    if Assigned(fOnDatenbankAktualStart) then
      fOnDatenbankAktualStart(aDateiList.Count);

    for i1 := 0 to aDateiList.Count -1 do
    begin
      if Assigned(fOnDatenbankAktual) then
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          fOnDatenbankAktual(aDateiList.Item[i1], i1+1, fCancel);
          if fCancel then
            exit;
        end);
      end;
    end;
  end
  );
  t.OnTerminate := ReadEnd;
  t.Start;

end;

procedure TThreadFestplatteEinlesen.ReadEnd(Sender: TObject);
begin
  if fCancel then
  begin
    if Assigned(fOnCancel) then
    begin
      fOnCancel(Self);
      exit;
    end;
  end;
  if Assigned(fOnReadEnd) then
    fOnReadEnd(Self);
end;

procedure TThreadFestplatteEinlesen.ReadFile(aFilename: string; var aCancel: Boolean);
begin
  aCancel := fCancel;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  var
    IsCancel: Boolean;
  begin
    if Assigned(fInfoProzess) then
      fInfoProzess(aFilename, IsCancel);
    fCancel := IsCancel;
  end);
end;

procedure TThreadFestplatteEinlesen.ReadPath(aPath: string;
  var aCanRead: Boolean);
var
  i1: Integer;
  s: string;
  Path: string;
begin
  aCanRead := true;
  if fIgnorePfadList = nil then
    exit;
  Path := IncludeTrailingPathDelimiter(LowerCase(aPath));
  for i1 := 0 to fIgnorePfadList.Count -1 do
  begin
    s := '\'+ LowerCase(fIgnorePfadList.Item[i1].Pfad) + '\';
    if Pos(s, Path) > 0 then
    begin
      aCanRead := false;
      exit;
    end;
  end;
end;

procedure TThreadFestplatteEinlesen.CheckCancel(Sender: TObject);
begin
  //fDateisystem.Cancel := fCancel;
end;



end.
