unit DB.CreateFDB;

interface

type
  TCreateFDB= class
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure ErzeugeDatenbank;

  end;

implementation

{ TCreateFDB }

uses
  dm.Datenbank, Objekt.HarddriveClone2;

constructor TCreateFDB.Create;
begin

end;

destructor TCreateFDB.Destroy;
begin

  inherited;
end;

procedure TCreateFDB.ErzeugeDatenbank;
begin
  dm_Datenbank.db.DatabaseName := HarddriveClone2.Ini.DBIni.Pfad +  HarddriveClone2.Ini.DBIni.Datenbankname;
  //dm_Datenbank.db.DatabaseName := 'd:\temp\HARDDRIVECLONE3.FDB';
  dm_Datenbank.db.Params.Add('user_name=SYSDBA');
  dm_Datenbank.db.Params.Add('password=masterkey');
  dm_Datenbank.db.Params.Add('PAGE_SIZE=8192');
  dm_Datenbank.db.CreateDatabase;
  dm_Datenbank.Connect;

end;

end.
