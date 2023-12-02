unit dm.Style;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  Tdm_Style = class(TDataModule)
    StyleBook: TStyleBook;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  dm_Style: Tdm_Style;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
