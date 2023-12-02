unit dm.Datenbank;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet,
  IBX.IBQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, MemDS, DBAccess, Uni, DB.UpgradeList,
  db.Upgrade;

type
  Tdm_Datenbank = class(TDataModule)
    db: TIBDatabase;
    IBqry_Read: TIBQuery;
    IBTrans_Read: TIBTransaction;
    IBTrans_Write: TIBTransaction;
    IBqry_Write: TIBQuery;
    FDConnection1: TFDConnection;
    dbx: TUniConnection;
    Trans_Read: TUniTransaction;
    qry_Read: TUniQuery;
    Trans_Write: TUniTransaction;
    qry_Write: TUniQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    fDBUpradeList: TDBUpgradeList;
    fDBUprade: TDBUpgrade;
  public
    function Connect: Boolean;
    procedure CreateDatabase;
  end;

var
  dm_Datenbank: Tdm_Datenbank;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdm_Datenbank }

uses
  Objekt.HarddriveClone2;

function Tdm_Datenbank.Connect: Boolean;
begin
  Result := true;
  if db.Connected then
    exit;
  db.DatabaseName := HarddriveClone2.Ini.DBIni.Host + ':' + HarddriveClone2.Ini.DBIni.Pfad +  HarddriveClone2.Ini.DBIni.Datenbankname;
  db.Params.Clear;
  db.Params.Add('user_name=' + HarddriveClone2.Ini.DBIni.Username);
  db.Params.Add('password=' + HarddriveClone2.Ini.DBIni.Passwort);
  //db.Params.Add('CharacterSet=utf8');
  db.LoginPrompt := false;
  try
    db.Connected := true;
  except
    on E: Exception do
    begin
      Result := false;
      HarddriveClone2.Log.Info('Fehler beim Datenbank verbinden: ' + E.Message);
    end;
  end;
  fDBUpradeList.Trans := IBTrans_Write;
  if fDBUpradeList.DoUpgrade then
  begin
    fDBUprade.Trans := IBTrans_Write;
    fDBUprade.Init;
    fDBUprade.Datum := '20220626 15:00';
    fDBUprade.SaveToDB;
  end;
end;

procedure Tdm_Datenbank.CreateDatabase;
begin
  db.DatabaseName := 'd:\temp\HARDDRIVECLONE3.FDB';
  db.Params.Add('user_name=SYSDBA');
  db.Params.Add('password=masterkey');
  db.Params.Add('PAGE_SIZE=8192');
//  db.Params.Add('DEFAULT CHARACTER SET UTF8');
  db.CreateDatabase;
end;

procedure Tdm_Datenbank.DataModuleCreate(Sender: TObject);
begin
  fDBUpradeList := TDBUpgradeList.Create;
  fDBUprade := TDBUpgrade.Create(nil);
end;

procedure Tdm_Datenbank.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(fDBUpradeList);
  FreeAndNil(fDBUprade);
end;

end.
