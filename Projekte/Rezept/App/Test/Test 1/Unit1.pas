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
  ClientClassesUnit1, ClientModuleUnit1, Rest.Rezept;

procedure TForm1.Button1Click(Sender: TObject);
var
  Temp: TRezeptServerMethodsClient;
  Rezept: TRestRezept;
begin
  Temp := TRezeptServerMethodsClient.Create(ClientModule1.DSRESTConnection1);
try
  Caption := Temp.ReverseString('Hallo');
  //Rezept := TRestRezept.Create;
  Rezept := Temp.Rezept(2);
  Caption := Rezept.Rezeptname;
finally
 // FreeAndNil(Rezept);
  Temp.Free;
end;
end;

end.
