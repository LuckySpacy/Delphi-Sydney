unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTPLb_Codec,
  uTPLb_BaseNonVisualComponent, uTPLb_CryptographicLibrary, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    CryptographicLibrary1: TCryptographicLibrary;
    Codec1: TCodec;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
var
  CipherText: string;
  Encoding: TEncoding;
  dec: string;
begin
  Codec1.Password := 'Hallo123';
  Codec1.EncryptString('Thomas', CipherText, Encoding.ANSI);
  Label1.Caption := string(CipherText);
  Codec1.DecryptString(dec, CipherText, Encoding.ANSI);
  Label2.Caption := string(dec);

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Verschluesselung: string;
  Encoding: TEncoding;
  Dec: string;
begin
  Verschluesselung := Label1.Caption;
  Codec1.DecryptString(dec, Verschluesselung, Encoding.ANSI);
  Label2.Caption := string(dec);
end;

end.
