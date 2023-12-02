unit ClientModul.Module;

interface

uses
  System.SysUtils, System.Classes, ClientModul.Classes, Datasnap.DSClientRest;

type
  TClientModule1 = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FRezeptServerMethodsClient: TRezeptServerMethodsClient;
    function GetRezeptServerMethodsClient: TRezeptServerMethodsClient;
    { Private-Deklarationen }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property RezeptServerMethodsClient: TRezeptServerMethodsClient read GetRezeptServerMethodsClient write FRezeptServerMethodsClient;

end;

var
  ClientModule1: TClientModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TClientModule1.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule1.Destroy;
begin
  FRezeptServerMethodsClient.Free;
  inherited;
end;

function TClientModule1.GetRezeptServerMethodsClient: TRezeptServerMethodsClient;
begin
  if FRezeptServerMethodsClient = nil then
    FRezeptServerMethodsClient:= TRezeptServerMethodsClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FRezeptServerMethodsClient;
end;

end.
