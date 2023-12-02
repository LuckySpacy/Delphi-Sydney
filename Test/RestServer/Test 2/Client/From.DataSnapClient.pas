unit From.DataSnapClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditA: TEdit;
    EditB: TEdit;
    Button1: TButton;
    Label3: TLabel;
    EditResult: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
   ClientClassesUnit1, ClientModuleUnit1;

procedure TForm2.Button1Click(Sender: TObject);
var
  Temp: TServerMethods1Client;
  A, B: Double;
begin
  Temp := TServerMethods1Client.Create(ClientModule1.DSRESTConnection1);
try
  A := StrToFloat(EditA.Text);
  B := StrToFloat(EditB.Text);
  EditResult.Text := FloatToStr(Temp.Sum(A, B));
finally
  Temp.Free;
end;end;

end.
