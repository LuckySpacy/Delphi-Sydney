unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, Rest.Rezept, Rest.RezeptList;

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
  Rezept: TRestRezept;
  RezeptList: TRestRezeptList;
  i1: Integer;
begin
  Temp := TRezeptServerMethodsClient.Create(ClientModule1.DSRESTConnection1);
try
  Caption := Temp.ReverseString('Hallo');
  //Rezept := TRestRezept.Create;
  //Rezept := Temp.Rezept(2);
  //Caption := Rezept.Rezeptname;
  RezeptList := Temp.RezeptAll;
  for i1 := 0 to RezeptList.Count -1 do
  begin
    caption := RezeptList.Item[i1].Rezeptname;
  end;
finally
 // FreeAndNil(Rezept);
  Temp.Free;
end;
end;

end.
