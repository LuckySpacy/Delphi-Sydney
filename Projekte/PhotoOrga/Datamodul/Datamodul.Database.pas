unit Datamodul.Database;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, Vcl.Dialogs, System.UITypes,
  DB.TBTransaction;

type
  Tdm = class(TDataModule)
    IB_PhotoOrga: TIBDatabase;
    IBT_Standard: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    fPasswort: string;
    fPort: Integer;
    fDatenbankpfad: string;
    fDatenbankname: string;
    fHost: string;
    fUsername: string;
    fTrans_Standard : TTBTransaction;
  public
    property Host: string read fHost write fHost;
    property Port: Integer read fPort write fPort;
    property Datenbankname: string read fDatenbankname write fDatenbankname;
    property Datenbankpfad: string read fDatenbankpfad write fDatenbankpfad;
    property Username: string read fUsername write fUsername;
    property Passwort: string read fPasswort write fPasswort;
    function ConnectFirebirdDB: Boolean;
    function CheckFirebird: Boolean;
    function Trans_Standard : TTBTransaction;
    procedure DatenbankLeeren;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  fmx.Types, DB.TBQuery;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  IB_PhotoOrga.Params.Add('default character set UTF8');

  fPasswort      := '';
  fPort          := 0;
  fDatenbankpfad := '';
  fDatenbankname := '';
  fHost          := '';
  fUsername      := '';

  fTrans_Standard := TTBTransaction.Create(Self);
  fTrans_Standard.DefaultDatabase := IB_PhotoOrga;


end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  Log.d('Tdm.DataModuleDestroy -> Start');
  FreeAndNil(fTrans_Standard);
  Log.d('Tdm.DataModuleDestroy -> Ende');
end;


function Tdm.Trans_Standard: TTBTransaction;
begin
  Result := fTrans_Standard;
end;

function Tdm.CheckFirebird: Boolean;
begin
  Result := true;
  try
    if not IB_PhotoOrga.Connected then
      IB_PhotoOrga.Open;
  except
    on E: Exception do
    begin
      Result := false;
      MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

function Tdm.ConnectFirebirdDB: Boolean;
begin
  Result := true;
  dm.IB_PhotoOrga.Databasename := Trim(fHost) +':' +
                               Trim(IncludeTrailingPathDelimiter(fDatenbankpfad)) +
                               Trim(fDatenbankname);
  dm.IB_PhotoOrga.Params.Clear;
  dm.IB_PhotoOrga.Params.Add('user_name=' + fUsername);
  dm.IB_PhotoOrga.Params.Add('password=' + fPasswort);
  dm.IB_PhotoOrga.Params.Add('lc_ctype=UTF8');

  dm.IB_PhotoOrga.LoginPrompt := false;
  try
    dm.CheckFirebird;
  except
    on E: Exception do
    begin
      Result := false;
      MessageDlg(E.Message, mtError, [mbOk], 0);
      MessageDlg('Verbindung zur Datenbank fehlgeschlagen', mtError, [mbOk], 0);
      exit;
    end;
  end;
end;

procedure Tdm.DatenbankLeeren;
var
  Qry: TTBQuery;
begin
  qry.Trans := fTrans_Standard;
  qry.OpenTrans;
  try
  finally
    qry.CommitTrans;
    FreeAndNil(qry);
  end;
end;


end.
