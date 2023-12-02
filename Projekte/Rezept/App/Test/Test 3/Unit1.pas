unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  ClientClassesUnit1, ClientModuleUnit1;

procedure TForm1.Button1Click(Sender: TObject);
var
  Temp: TRezeptServerMethodsClient;
  s: TStream;
  list: TStringList;
begin
  list := TStringList.Create;
  Temp := TRezeptServerMethodsClient.Create(ClientModule1.DSRESTConnection1);
  try
    Caption := Temp.ReverseString('Hallo');
    s := Temp.TestStream;
    s.Position := 0;
    List.LoadFromStream(s);
    caption := List.Text;
  finally
    Temp.Free;
    FreeAndNil(list);
  end;
end;

end.
