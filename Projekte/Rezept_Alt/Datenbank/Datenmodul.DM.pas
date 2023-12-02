unit Datenmodul.DM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.Comp.UI,
  FireDAC.Comp.Client, Data.DB, Vcl.ImgList, Vcl.Controls, Objekt.Rezept,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  Tdm = class(TDataModule)
    db: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    Img_32x32: TImageList;
    Img_Small: TImageList;
    FDQuery1: TFDQuery;
  private
    fLastError: string;
  public
    function Connect: Boolean;
    property LastError: string read fLastError;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdm }

function Tdm.Connect: Boolean;
begin
  Result := true;
  fLastError := '';
  db.Params.Clear;
  db.Params.Add('DriverID=MySQL');
  db.Params.Add('Server=' + Rezept.IniEinstellung.Host);
  db.Params.Add('Port=3306');
  db.Params.Add('Database=rezept');
  db.Params.Add('User_Name=' + Rezept.IniEinstellung.Username);
  db.Params.Add('Password=' + Rezept.IniEinstellung.Passwort);
  db.Params.Add('CharacterSet=UTF8');
  try
    db.open;
  except
    on E: Exception do
    begin
      fLastError := e.Message;
      Result := false;
    end;
  end;
end;

end.
