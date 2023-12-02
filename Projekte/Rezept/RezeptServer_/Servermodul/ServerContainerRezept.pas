unit ServerContainerRezept;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSClientMetadata, Datasnap.DSHTTPServiceProxyDispatcher,
  Datasnap.DSProxyJavaAndroid, Datasnap.DSProxyJavaBlackBerry,
  Datasnap.DSProxyObjectiveCiOS, Datasnap.DSProxyCsharpSilverlight,
  Datasnap.DSProxyFreePascal_iOS,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth, Datasnap.DSMetadata,
  Datasnap.DSServerMetadata, Datasnap.DSHTTP;

type
  TContainerRezept = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPServiceProxyDispatcher1: TDSHTTPServiceProxyDispatcher;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    function getPort: Integer;
    procedure setPort(const Value: Integer);
  public
    property Port: Integer read getPort write setPort;
  end;

var
  ContainerRezept: TContainerRezept;

implementation


{$R *.dfm}

uses
  ServerMethodsRezept;

procedure TContainerRezept.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsRezept.TServerMethodsRezept;
end;

function TContainerRezept.getPort: Integer;
begin
  Result := DSTCPServerTransport1.Port;
end;

procedure TContainerRezept.setPort(const Value: Integer);
begin
  DSTCPServerTransport1.Port := Value;
end;

end.

