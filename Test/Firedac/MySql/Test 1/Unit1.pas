unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Grids,
  Vcl.DBGrids;

type
  TForm1 = class(TForm)
    db: TFDConnection;
    FDTransaction1: TFDTransaction;
    Button1: TButton;
    qry: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if db.Connected then
  begin
    qry.SQL.Text := 'select * from aktie';
    qry.Open;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  db.Params.Clear;
  {
  db.Params.Add('DriverID=MySQL');
  db.Params.Add('Server=bachmannserver.de');
  //db.Params.Add('Server=127.0.0.1');
  db.Params.Add('Port=3306');
  db.Params.Add('Database=tsi');
  db.Params.Add('User_Name=' + 'root');
  db.Params.Add('Password=' + '');
  db.Params.Add('CharacterSet=UTF8');
  }
  db.Params.Add('DriverID=MySQL');
  db.Params.Add('Server=bachmannserver.de');
  db.Params.Add('Port=3306');
  db.Params.Add('Database=tsi');
  db.Params.Add('User_Name=' + 'thomas');
  db.Params.Add('Password=' + 'c2r4^hM5');
  db.Params.Add('CharacterSet=UTF8');
  db.Open;
end;

end.
