unit VW.JobDateiList;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, Objekt.BasisList, DB.BasisList,
  VW.JobDatei, System.Contnrs;


type
  TVWJobDateiList = class(TDBBasisList)
  private
    function getItem(Index: Integer): TVWJobDatei;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TVWJobDatei read getItem;
    function Add: TVWJobDatei;
    procedure ReadNewFiles(aJoId: Integer);
    procedure ReadChangedFiles(JoId: Integer);
    procedure ReadDeletedFiles(JoId: Integer; aChangeDatum: TDateTime);
    function AnzahlDeletedFiles(JoId: Integer; aChangeDatum: TDateTime): Integer;
  end;

implementation

{ TVWJobDateiList }


constructor TVWJobDateiList.Create;
begin
  inherited;

end;

destructor TVWJobDateiList.Destroy;
begin

  inherited;
end;

function TVWJobDateiList.getItem(Index: Integer): TVWJobDatei;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TVWJobDatei(fList.Items[Index]);
end;

function TVWJobDateiList.Add: TVWJobDatei;
begin
  Result := TVWJobDatei.Create(nil);
  Result.Trans := Trans;
  fList.Add(Result);
end;


procedure TVWJobDateiList.ReadNewFiles(aJoId: Integer);
var
  x: TVWJobDatei;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' select * ' +
                       ' from jobdatei' +
                       ' join datei on jobdatei.JD_DA_ID = datei.DA_ID and datei.da_delete != ' + QuotedStr('T') +
                       ' where jd_DELETE != ' + QuotedStr('T') +
                       ' and jd_dateidatum <= :dateidatum' +
                       ' and jd_jo_id = ' + IntToStr(aJoId);
    fQuery.ParamByName('dateidatum').AsDateTime := StrToDate('01.01.1900');
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TVWJobDatei.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;


procedure TVWJobDateiList.ReadChangedFiles(JoId: Integer);
var
  x: TVWJobDatei;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' select * ' +
                       ' from datei' +
                       ' inner join jobdatei on jd_da_id = da_id and jd_jo_id = ' + IntToStr(JoId) +
                       ' where da_delete != ' + QuotedStr('T') +
                       ' and da_dateidatum > jd_changedatum';
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TVWJobDatei.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;

procedure TVWJobDateiList.ReadDeletedFiles(JoId: Integer; aChangeDatum: TDateTime);
var
  x: TVWJobDatei;
begin
  fList.Clear;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' select * ' +
                       ' from datei' +
                       ' inner join jobdatei on jd_da_id = da_id and jd_jo_id = ' + IntToStr(JoId) +
                       ' where da_delete != ' + QuotedStr('T') +
                       ' and da_changedatum < :changedatum' +
                       ' and da_changedatum > :neudatum';
    fQuery.ParamByName('changedatum').AsDateTime := trunc(aChangeDatum);
    fQuery.ParamByName('neudatum').AsDateTime := StrToDate('01.02.1900');
    fQuery.Open;
    while not fQuery.Eof do
    begin
      x := TVWJobDatei.Create(nil);
      x.Trans := fTrans;
      x.LoadByQuery(fQuery);
      fList.Add(x);
      fQuery.Next;
    end;
  finally
    RollbackTrans;
  end;
end;

function TVWJobDateiList.AnzahlDeletedFiles(JoId: Integer; aChangeDatum: TDateTime): Integer;
begin
  Result := 0;
  if fTrans = nil then
    exit;
  fQuery.Transaction := fTrans;
  fQuery.Close;
  OpenTrans;
  try
    fQuery.SQL.Text := ' select count(*) ' +
                       ' from datei' +
                       ' inner join jobdatei on jd_da_id = da_id and jd_jo_id = ' + IntToStr(JoId) +
                       ' where da_delete != ' + QuotedStr('T') +
                       ' and da_changedatum < :changedatum' +
                       ' and da_changedatum > :neudatum';
    fQuery.ParamByName('changedatum').AsDateTime := Trunc(aChangeDatum);
    fQuery.ParamByName('neudatum').AsDateTime := StrToDate('01.02.1900');
    fQuery.Open;
    Result := fQuery.Fields[0].AsInteger;
    fQuery.Close;
  finally
    RollbackTrans;
  end;
end;


end.
