unit Datenmodul.Database;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.MySQLDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Phys.MySQL, Data.DB, IBX.IBDatabase, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Comp.Client;

type
  Tdm = class(TDataModule)
    IB_MusikOrga: TIBDatabase;
    IBT_Standard: TIBTransaction;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
