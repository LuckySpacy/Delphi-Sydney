unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uTPLb_Codec,
  uTPLb_BaseNonVisualComponent, uTPLb_CryptographicLibrary, FMX.StdCtrls,
  FMX.Controls.Presentation, Objekt.Verschluesseln;

type
  TForm1 = class(TForm)
    CryptographicLibrary1: TCryptographicLibrary;
    Codec1: TCodec;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    fVerschluesseln: TVerschluesseln;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  fVerschluesseln := TVerschluesseln.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fVerschluesseln);
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  plain, Verschluesselt : string;
  Encoding : TEncoding;
begin
  Plain := 'Thomas';
  Codec1.Password := 'jsdjfhewugb62547jdh!!Xkdsjfi4$32';
  Codec1.EncryptString(plain, Verschluesselt, Encoding.ANSI);
  Label1.Text := Verschluesselt;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Entschluesselt, Verschluesselt : string;
  Encoding : TEncoding;
begin
  Verschluesselt := Label1.Text;
  Codec1.DecryptString(Entschluesselt, Verschluesselt, Encoding.ANSI);
  Label2.Text := Entschluesselt;
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
  Label1.Text := fVerschluesseln.Verschluesseln('Thomas Bachmann');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Label2.Text := fVerschluesseln.Entschluesseln(Label1.Text);
end;

end.
