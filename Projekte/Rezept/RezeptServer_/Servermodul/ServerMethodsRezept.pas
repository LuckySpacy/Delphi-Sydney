unit ServerMethodsRezept;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
{$METHODINFO ON}
  TServerMethodsRezept = class(TComponent)
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

function TServerMethodsRezept.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethodsRezept.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethodsRezept.Sum(const A, B: Double): Double;
begin
  Result := A + B;
end;

end.

