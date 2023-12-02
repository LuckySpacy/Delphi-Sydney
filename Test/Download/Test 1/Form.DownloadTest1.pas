unit Form.DownloadTest1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TForm3 = class(TForm)
    IdHTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    procedure Download;
  public
    { Public-Deklarationen }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  Download;
end;

procedure TForm3.Download;
var
  Url: string;
  ms: TMemoryStream;
begin
  IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Method := sslvTLSv1_2;
  Url := 'https://www.onvista.de/onvista/boxes/historicalquote/export.csv?notationId=159134&dateStart=01.01.2017&interval=Y5';
  ms := TMemoryStream.Create;
  try
    try
      IdHTTP.Get(Url, ms);
     // IdHTTP.Post(Url, ms);
    except
      on E: Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
    ms.Position := 0;
    Memo1.Lines.LoadFromStream(ms);
  finally
    FreeAndNil(ms);
  end;
end;

end.
