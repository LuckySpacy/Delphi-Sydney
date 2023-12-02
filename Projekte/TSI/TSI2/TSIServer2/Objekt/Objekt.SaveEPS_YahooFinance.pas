unit Objekt.SaveEPS_YahooFinance;

interface

uses
  SysUtils, Classes, System.IOUtils, System.Types, System.UITypes,
  DB.Aktie, DB.AktieList, IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent, IdComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, JSon.YahooFinance.QuotedSummery,
  View.Aktie, View.AktieList;

type
  TStartProgressEvent=procedure(aAnzahl: Integer) of object;
  TProgressEvent=procedure(aProgress: Integer; aCaption: string) of object;
  TProgressRefreshLabelEvent=procedure(aCaption: string) of object;
  TSaveEPS = class
  private
    fOnStartProgress: TStartProgressEvent;
    fOnProgress: TProgressEvent;
    fDBAktie: TDBAktie;
    fDBAktieList: TDBAktieList;
    fOnProgressRefreshLabel: TProgressRefreshLabelEvent;
    fProgressLabel: string;
    fHttp: TIdHTTP;
    fIOHandler: TIdSSLIOHandlerSocketOpenSSL;
    fAktieList: TVWAktieList;
    function getEPS(aTickersymbol: string; var aError: string): Extended;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start(aSSId: Integer);
    property OnStartProgress: TStartProgressEvent read fOnStartProgress write fOnStartProgress;
    property OnProgress: TProgressEvent read fOnProgress write fOnProgress;
    property OnProgressRefreshLabel: TProgressRefreshLabelEvent read fOnProgressRefreshLabel write fOnProgressRefreshLabel;
  end;

implementation

{ TSaveEPS }

uses
  DateUtils, Objekt.TSIServer2;

constructor TSaveEPS.Create;
begin
  fDBAktie     := TDBAktie.Create(nil);
  fDBAktieList := TDBAktieList.Create;
  fAktieList := TVWAktieList.Create;
  fHttp := TIdHTTP.Create;
  fIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  fIOHandler.SSLOptions.Method := sslvTLSv1_2;
  fHttp.IOHandler := fIOHandler;
end;

destructor TSaveEPS.Destroy;
begin
  FreeAndNil(fDBAktie);
  FreeAndNil(fDBAktieList);
  FreeAndNil(fHttp);
  FreeAndNil(fIOHandler);
  FreeAndNil(fAktieList);
  inherited;
end;


procedure TSaveEPS.Start(aSSId: Integer);
var
  i1: Integer;
  s: string;
  AkId: Integer;
  Error: string;
begin
  fAktieList.Trans := TSIServer2.IBT_TSI;
  fAktieList.ReadAll(aSSId);
  fDBAktie.Trans := TSIServer2.IBT_TSI;
  {
  fDBAktie.Trans := TSIServer2.IBT_TSI;
  fDBAktieList.Trans := TSIServer2.IBT_TSI;


  fDBAktieList.ReadAll;
  }

  if Assigned(fOnStartProgress) then
    fOnStartProgress(fAktieList.Count);


  if TSIServer2.IBT_TSI.InTransaction then
    TSIServer2.IBT_TSI.Rollback;
  try
    for i1 := 0 to fAktieList.Count -1 do
    begin
      AkId := fAktieList.Item[i1].FeldList.FieldByName('AK_ID').AsInteger;
      fDBAktie.Read(AkId);
      if not fDBAktie.Gefunden then
        continue;
      s := 'EPS: [' + fDBAktie.WKN + '] ' + fDBAktie.Aktie;

      if Assigned(fOnProgress) then
        fOnProgress(i1+1, s);


      if Trim(fAktieList.Item[i1].FeldList.FieldByName('AS_PARAM1').AsString) = '' then
        continue;

      if not fDBAktie.Aktiv then
        continue;


      TSIServer2.IBT_TSI.StartTransaction;
      fDBAktie.EPS :=  getEPS(fAktieList.Item[i1].FeldList.FieldByName('AS_PARAM1').AsString, Error);
      if Error > '' then
      begin
        s := s + ' konnte nicht ermittelt werden. Param:' + fAktieList.Item[i1].FeldList.FieldByName('AS_PARAM1').AsString + ' - ' + Error;
        TSIServer2.Protokoll.write(s, '');
      end;
      fDBAktie.SaveToDB;
      TSIServer2.IBT_TSI.Commit;
    end;
  finally
    if TSIServer2.IBT_TSI.InTransaction then
      TSIServer2.IBT_TSI.Rollback;
  end;

end;


function TSaveEPS.getEPS(aTickersymbol: string; var aError: string): Extended;
var
  ms: TMemoryStream;
  List: TStringList;
  s: string;
  Url: string;
  JQuotedSummery: TJYahooFinanceQuotedSummery;
begin
  Result := 0;
  aError := '';
  Url := 'https://query1.finance.yahoo.com/v10/finance/quoteSummary/~Param~?modules=defaultKeyStatistics';
  Url := StringReplace(Url, '~Param~', aTickersymbol, [rfReplaceAll]);
  List := TStringList.Create;
  ms := TMemoryStream.Create;
  try
    try
      fhttp.Get(Url, ms);
    except
      on E:Exception do
      begin
        aError := E.Message;
        Result := 0;
        exit;
      end;
    end;
    ms.Position := 0;
    List.LoadFromStream(ms);
    s := Trim(List.Text);
    JQuotedSummery := TJYahooFinanceQuotedSummery.FromJsonString(s);
    if JQuotedSummery = nil then
      exit;
    if Length(JQuotedSummery.quoteSummary.result) = 0 then
      exit;
    s := JQuotedSummery.quoteSummary.result[0].defaultKeyStatistics.trailingEps.fmt;
    s := StringReplace(s, '.', ',', [rfReplaceAll]);
     if not TryStrToFloat(s, Result) then
      Result := 0;
  finally
    FreeAndNil(List);
    FreeAndNil(ms);
  end;
end;


end.
