unit Objekt.DownloadKurse;

interface

uses
  SysUtils, Classes, View.AktieList, View.Aktie,
  IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent, IdComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;
type
  TStartProgressEvent=procedure(aAnzahl: Integer) of object;
  TProgressEvent=procedure(aProgress: Integer; aCaption: string) of object;
  TDownloadKurse = class
  private
    fAktieList: TVWAktieList;
    fOnStartProgress: TStartProgressEvent;
    fOnProgress: TProgressEvent;
    fHttp: TIdHTTP;
    fIOHandler: TIdSSLIOHandlerSocketOpenSSL;
    fTooManyRequest: Boolean;
    procedure DownloadFile(aUrl, aFilename: string);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start(aDownloadPfad, aSchnittstellenLink: string; aSSId: Integer);
    property OnStartProgress: TStartProgressEvent read fOnStartProgress write fOnStartProgress;
    property OnProgress: TProgressEvent read fOnProgress write fOnProgress;

  end;


implementation

{ TDownloadKurse }


uses
  Objekt.TSIServer2;

constructor TDownloadKurse.Create;
begin
  fAktieList := TVWAktieList.Create;
  fHttp := TIdHTTP.Create;
  fIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  fIOHandler.SSLOptions.Method := sslvTLSv1_2;
  fHttp.IOHandler := fIOHandler;
end;

destructor TDownloadKurse.Destroy;
begin
  FreeAndNil(fAktieList);
  FreeAndNil(fHttp);
  FreeAndNil(fIOHandler);
  inherited;
end;

procedure TDownloadKurse.Start(aDownloadPfad, aSchnittstellenLink: string; aSSId: Integer);
var
  i1: Integer;
  s: string;
  Aktie: TVWAktie;
  Filename: string;
  Url: string;
begin
  fAktieList.Trans := TSIServer2.IBT_TSI;
  fAktieList.ReadAll(aSSId);
  if Assigned(fOnStartProgress) then
    fOnStartProgress(fAktieList.count);
  for i1 := 0 to fAktieList.Count -1 do
  begin
    Aktie := fAktieList.Item[i1];
    s := 'Download: [' + Aktie.FeldList.FieldByName('AK_WKN').AsString + '] ' + Aktie.FeldList.FieldByName('AK_AKTIE').AsString;
    Filename := IncludeTrailingPathDelimiter(aDownloadPfad) + Aktie.FeldList.FieldByName('AK_WKN').AsString + '_' + Aktie.FeldList.FieldByName('AK_AKTIE').AsString + '.csv';

    Url := aSchnittstellenLink;
    Url := StringReplace(Url, '~Param1~', Aktie.FeldList.FieldByName('AS_PARAM1').AsString, [rfReplaceAll]);

    DownloadFile(Url, Filename);
    if fTooManyRequest then
    begin
      sleep(1000);
      DownloadFile(Url, Filename);
    end;

    if Assigned(fOnProgress) then
      fOnProgress(i1+1, s);

    //break;
    //Sleep(100);

  end;
end;

procedure TDownloadKurse.DownloadFile(aUrl, aFilename: string);
var
  ms: TMemoryStream;
  List: TStringList;
  s: string;
begin
  fTooManyRequest := false;
  List := TStringList.Create;
  ms := TMemoryStream.Create;
  try
    ms.Position := 0;
    try
      fhttp.Get(aUrl, ms);
      //List.Text := fhttp.Post(aurl, ms);
    except
      on E: Exception do
      begin
        TSIServer2.Protokoll.write('DownloadFile', aUrl);
        TSIServer2.Protokoll.write('DownloadFile', aFilename);
        TSIServer2.Protokoll.write('DownloadFile', E.Message);
        TSIServer2.Protokoll.write('DownloadFile', '-------------------------------------------------------------------');
        s := lowercase(E.Message);
        if (Pos('too many requests', s) > 0)
        or (Pos('429', s) > 0) then
          fTooManyRequest := true;
        exit;
      end;
    end;
    ms.Position := 0;
    try
      List.LoadFromStream(ms);
      List.SaveToFile(aFilename);
    except
      on E: Exception do
      begin
        TSIServer2.Protokoll.write('DownloadFile', 'Fehler beim Speichern - ' + E.Message + ' - ' + aFilename);
      end;
    end;
    if List.Count < 10 then
    begin
      TSIServer2.Protokoll.write('DownloadFile', 'Datei ist zu klein - ' + aUrl + ' - ' + aFilename);
    end;

  finally
    FreeAndNil(ms);
    FreeAndNil(List);
  end;
end;


end.
