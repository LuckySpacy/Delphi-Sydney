unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Sum(const A, B: Double): Double;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.Sum(const A, B: Double): Double;
begin
  Result := A + B;
end;

end.

