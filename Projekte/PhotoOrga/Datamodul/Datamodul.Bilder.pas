unit Datamodul.Bilder;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  Tdm_Bilder = class(TDataModule)
    img: TImageList;
    Img_Dis: TImageList;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  dm_Bilder: Tdm_Bilder;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  fmx.Types;

procedure Tdm_Bilder.DataModuleDestroy(Sender: TObject);
begin
  log.d('Tdm_Bilder.DataModuleDestroy');
end;

end.
