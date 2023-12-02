unit Form.BildOri;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, VW.PhotoUndBaum, vcl.Imaging.jpeg;

type
  Tfrm_BildOri = class(TForm)
    img: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fPhotoUndBaum: TVWPhotoUndBaum;
    fjpg: TJpegImage;
  public
    property PhotoUndBaum: TVWPhotoUndBaum read fPhotoUndBaum write fPhotoUndBaum;
    procedure LadeBild(aFullFilename: string);
  end;

var
  frm_BildOri: Tfrm_BildOri;

implementation

{$R *.dfm}

procedure Tfrm_BildOri.FormCreate(Sender: TObject);
begin
  fPhotoUndBaum := nil;
  fjpg := TJpegImage.Create;
end;

procedure Tfrm_BildOri.FormDestroy(Sender: TObject);
begin //
  FreeAndNil(fjpg);
end;

procedure Tfrm_BildOri.LadeBild(aFullFilename: string);
begin
  fjpg.LoadFromFile(aFullFilename);
  img.Picture.Bitmap.Assign(fjpg);
end;

end.
