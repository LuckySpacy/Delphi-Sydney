unit Servermodul.RezeptContainer;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSClientMetadata, Datasnap.DSHTTPServiceProxyDispatcher,
  Datasnap.DSProxyJavaAndroid, Datasnap.DSProxyJavaBlackBerry,
  Datasnap.DSProxyObjectiveCiOS, Datasnap.DSProxyCsharpSilverlight,
  Datasnap.DSProxyFreePascal_iOS,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth;

type
  TRezeptServerContainer = class(TDataModule)
    DSRezeptServer: TDSServer;
    DSRezeptServerClass: TDSServerClass;
    procedure DSRezeptServerClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private-Deklarationen }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

function DSServer: TDSServer;

implementation


{$R *.dfm}

uses
  Servermodul.RezeptMethods;

var
  FModule: TComponent;
  FDSServer: TDSServer;

function DSServer: TDSServer;
begin
  Result := FDSServer;
end;

constructor TRezeptServerContainer.Create(AOwner: TComponent);
begin
  inherited;
  FDSServer := DSRezeptServer;
end;

destructor TRezeptServerContainer.Destroy;
begin
  inherited;
  FDSServer := nil;
end;

procedure TRezeptServerContainer.DSRezeptServerClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := Servermodul.RezeptMethods.TRezeptServerMethods;
end;

initialization
  FModule := TRezeptServerContainer.Create(nil);
finalization
  FModule.Free;
end.

