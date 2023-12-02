unit Form.TSIServer2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Controls.Presentation, FMX.StdCtrls,
  System.IOUtils, Form.Einstellung, Form.Protokoll, IdBaseComponent,
  IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL;

type
  Tfrm_TSIServer2 = class(TForm)
    TabControl1: TTabControl;
    tbs_Einstellung: TTabItem;
    tbs_Protokoll: TTabItem;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    fFormEinstellung: Tfrm_Einstellung;
    fFormProtokoll: Tfrm_Protokoll;
    fNextAktual: TDateTime;
    function setTimeToDateTime(aDateTime, aTime: TDateTime): TDateTime;
   // fList: TSTringList;
  public
  end;

var
  frm_TSIServer2: Tfrm_TSIServer2;

implementation

{$R *.fmx}

uses
  Datamodul.Database, Objekt.TSIServer2, DateUtils;

procedure Tfrm_TSIServer2.FormCreate(Sender: TObject);
begin
  fFormEinstellung := nil;
  Log.d('Das ist ein Test');
  //Label1.Text := GetHomePath;

  fFormEinstellung := Tfrm_Einstellung.Create(Self);
  while fFormEinstellung.ChildrenCount>0 do
    fFormEinstellung.Children[0].Parent := tbs_Einstellung;



  fFormProtokoll := Tfrm_Protokoll.Create(Self);
  while fFormProtokoll.ChildrenCount>0 do
    fFormProtokoll.Children[0].Parent := tbs_Protokoll;


  fNextAktual := IncDay(trunc(now));
  //fNextAktual := IncHour(fNextAktual, 2);

  if fFormEinstellung <> nil then
  begin
    fNextAktual := setTimeToDateTime(fNextAktual, fFormEinstellung.edt_Uhrzeit.DateTime);
    fFormEinstellung.lbl_NaechsterStart.Text := 'Nächster automatischer Lauf um ' + FormatDateTime('dd.mm.yyyy hh:nn', fNextAktual);
  end;
//  fNestAktual := inc

    //fList := TSTringList.Create;

end;

procedure Tfrm_TSIServer2.FormDestroy(Sender: TObject);
begin //

end;

procedure Tfrm_TSIServer2.FormShow(Sender: TObject);
begin
//  dm.Datenbankname := TS
  dm.TSIConnectData.Host := TSIServer2.Ini.TSI.Host;
  dm.TSIConnectData.Datenbankname := TSIServer2.Ini.TSI.Datenbankname;
  dm.TSIConnectData.Datenbankpfad := TSIServer2.Ini.TSI.Datenbankpfad;

  dm.KurseConnectData.Host := TSIServer2.Ini.Kurse.Host;
  dm.KurseConnectData.Datenbankname := TSIServer2.Ini.Kurse.Datenbankname;
  dm.KurseConnectData.Datenbankpfad := TSIServer2.Ini.Kurse.Datenbankpfad;

  if dm.ConnectTSI then
  begin
    TSIServer2.IBT_TSI := dm.IBT_TSI;
    if fFormEinstellung <> nil then
    begin
      fFormEinstellung.LadeSchnittstellen;
      fFormEinstellung.setEditToOnExit;
    end;
  end;
  if dm.ConnectKurse then
    TSIServer2.IBT_Kurse := dm.IBT_Kurse;
  Timer.Enabled := true;
end;

procedure Tfrm_TSIServer2.TimerTimer(Sender: TObject);
begin
  if now > fNextAktual then
  begin
    Timer.Enabled := false;
    fNextAktual := IncDay(trunc(now));
    if fFormEinstellung <> nil then
    begin
      fNextAktual := setTimeToDateTime(fNextAktual, fFormEinstellung.edt_Uhrzeit.DateTime);
      fFormEinstellung.lbl_NaechsterStart.Text := 'Nächster automatischer Lauf um ' + FormatDateTime('dd.mm.yyyy hh:nn', fNextAktual);
    end;
    //fNextAktual := IncHour(fNextAktual, 2);
    fFormEinstellung.Start;
    Timer.Enabled := true;
  end;
end;

function Tfrm_TSIServer2.setTimeToDateTime(aDateTime, aTime: TDateTime): TDateTime;
var
  Jahr1: Word;
  Monat1: Word;
  Tag1: Word;
  Stunde1: Word;
  Minute1: Word;
  Sekunde1: Word;
  Milli1: Word;
  Jahr2: Word;
  Monat2: Word;
  Tag2: Word;
  Stunde2: Word;
  Minute2: Word;
  Sekunde2: Word;
  Milli2: Word;
begin
  DecodeDateTime(aDateTime, Jahr1, Monat1, Tag1, Stunde1, Minute1, Sekunde1, Milli1);
  DecodeDateTime(aTime, Jahr2, Monat2, Tag2, Stunde2, Minute2, Sekunde2, Milli2);
  Result := EncodeDateTime(Jahr1, Monat1, Tag1, Stunde2, Minute2, Sekunde2, Milli2);
end;

end.
