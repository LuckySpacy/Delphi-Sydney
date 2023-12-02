unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, ClientClassesUnit2, ClientModuleUnit2;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edt_A: TEdit;
    edt_B: TEdit;
    lbl_Ergebnis: TLabel;
    edt_Ergebnis: TEdit;
    btn_Rechnen: TButton;
    procedure btn_RechnenClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.btn_RechnenClick(Sender: TObject);
var
  Temp: TServerMethods1Client;
  A, B: Double;
begin
  Temp := TServerMethods1Client.Create(ClientModule2.DSRESTConnection1);
try
  A := StrToFloat(edt_A.Text);
  B := StrToFloat(edt_B.Text);
  edt_Ergebnis.Text := FloatToStr(Temp.Sum(A, B));
finally
  Temp.Free;
end;
end;

end.
