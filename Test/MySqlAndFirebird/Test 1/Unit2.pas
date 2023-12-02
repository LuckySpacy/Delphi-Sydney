unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  IBX.IBDatabase, Data.DB, Vcl.StdCtrls, DB.Rezept, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  DB.RezeptList;

type
  TForm2 = class(TForm)
    IB_Rezept: TIBDatabase;
    IBT_Standard: TIBTransaction;
    DB_MySql: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    btn_Firebird: TButton;
    btn_MySql: TButton;
    Button1: TButton;
    qry: TFDQuery;
    Button2: TButton;
    procedure btn_FirebirdClick(Sender: TObject);
    procedure btn_MySqlClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    fUseFireBird: Boolean;
    fUseMySql: Boolean;
    fDBRezept: TDBRezept;
    fDBRezeptList: TDBRezeptList;
    procedure ConnectFirebirdDB;
    procedure ConnectMySql;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
  System.UITypes;


procedure TForm2.FormCreate(Sender: TObject);
begin
  fDBRezept := TDBRezept.Create(nil);
  fDBRezeptList := TDBRezeptList.Create;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDBRezept);
  FreeAndNil(fDBRezeptList);
end;



procedure TForm2.btn_FirebirdClick(Sender: TObject);
begin
  ConnectFirebirdDB;
end;



procedure TForm2.btn_MySqlClick(Sender: TObject);
begin
  ConnectMySql;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  fDBRezept.UseMySql := fUseMySql;
  fDBRezept.UseFirebird := fUseFireBird;

  fDBRezeptList.UseMySql := fUseMySql;
  fDBRezeptList.UseFirebird := fUseFireBird;


  if fUseMySql then
  begin
    fDBRezept.Trans := FDTransaction1;
    fDBRezeptList.Trans := FDTransaction1;
  end;

  if fUseFireBird then
  begin
    fDBRezept.Trans := IBT_Standard;
    fDBRezeptList.Trans := IBT_Standard;
  end;

  fDBRezept.Read(1);
  caption := fDBRezept.Rezeptname;

  fDBRezeptList.ReadAll;




end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ConnectMySql;
  qry.SQL.Text := 'select * from rezept';
  qry.Open;
end;

procedure TForm2.ConnectFirebirdDB;
begin
  fUseFireBird := true;
  fUseMySql := false;
  IB_Rezept.Databasename := 'localhost:D:\MeineProgramme\VServerStrato\Datenbank\Rezept.fdb';
  IB_Rezept.Params.Clear;
  IB_Rezept.Params.Add('user_name=sysdba');
  IB_Rezept.Params.Add('password=masterkey');
  IB_Rezept.Params.Add('lc_ctype=UTF8');

  IB_Rezept.LoginPrompt := false;
  try
    IB_Rezept.Open;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      MessageDlg('Verbindung zur Datenbank fehlgeschlagen', mtError, [mbOk], 0);
      exit;
    end;
  end;
end;


procedure TForm2.ConnectMySql;
begin
  fUseFireBird := false;
  fUseMySql := true;
  DB_MySql.Params.Clear;
  DB_MySql.Params.Add('DriverID=MySQL');
  DB_MySql.Params.Add('Server=localhost');
  DB_MySql.Params.Add('Port=3306');
  DB_MySql.Params.Add('Database=rezept');
  DB_MySql.Params.Add('User_Name=root');
  DB_MySql.Params.Add('Password=');
  DB_MySql.Params.Add('CharacterSet=UTF8');
  DB_MySql.Open;
end;


end.
