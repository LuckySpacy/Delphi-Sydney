// 
// Erzeugt vom DataSnap-Proxy-Generator.
// 18.04.2021 17:00:19
// 

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Rest.Rezept, Data.DBXJSONReflect;

type

  IDSRestCachedTRestRezept = interface;

  TRezeptServerMethodsClient = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FRezeptCommand: TDSRestCommand;
    FRezeptCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function Rezept(aRzId: Integer; const ARequestFilter: string = ''): TRestRezept;
    function Rezept_Cache(aRzId: Integer; const ARequestFilter: string = ''): IDSRestCachedTRestRezept;
  end;

  IDSRestCachedTRestRezept = interface(IDSRestCachedObject<TRestRezept>)
  end;

  TDSRestCachedTRestRezept = class(TDSRestCachedObject<TRestRezept>, IDSRestCachedTRestRezept, IDSRestCachedCommand)
  end;

const
  TRezeptServerMethods_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TRezeptServerMethods_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TRezeptServerMethods_Rezept: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aRzId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRestRezept')
  );

  TRezeptServerMethods_Rezept_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aRzId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

function TRezeptServerMethodsClient.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TRezeptServerMethods.EchoString';
    FEchoStringCommand.Prepare(TRezeptServerMethods_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TRezeptServerMethodsClient.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TRezeptServerMethods.ReverseString';
    FReverseStringCommand.Prepare(TRezeptServerMethods_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TRezeptServerMethodsClient.Rezept(aRzId: Integer; const ARequestFilter: string): TRestRezept;
begin
  if FRezeptCommand = nil then
  begin
    FRezeptCommand := FConnection.CreateCommand;
    FRezeptCommand.RequestType := 'GET';
    FRezeptCommand.Text := 'TRezeptServerMethods.Rezept';
    FRezeptCommand.Prepare(TRezeptServerMethods_Rezept);
  end;
  FRezeptCommand.Parameters[0].Value.SetInt32(aRzId);
  FRezeptCommand.Execute(ARequestFilter);
  if not FRezeptCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FRezeptCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRestRezept(FUnMarshal.UnMarshal(FRezeptCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FRezeptCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TRezeptServerMethodsClient.Rezept_Cache(aRzId: Integer; const ARequestFilter: string): IDSRestCachedTRestRezept;
begin
  if FRezeptCommand_Cache = nil then
  begin
    FRezeptCommand_Cache := FConnection.CreateCommand;
    FRezeptCommand_Cache.RequestType := 'GET';
    FRezeptCommand_Cache.Text := 'TRezeptServerMethods.Rezept';
    FRezeptCommand_Cache.Prepare(TRezeptServerMethods_Rezept_Cache);
  end;
  FRezeptCommand_Cache.Parameters[0].Value.SetInt32(aRzId);
  FRezeptCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRestRezept.Create(FRezeptCommand_Cache.Parameters[1].Value.GetString);
end;

constructor TRezeptServerMethodsClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TRezeptServerMethodsClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TRezeptServerMethodsClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FRezeptCommand.DisposeOf;
  FRezeptCommand_Cache.DisposeOf;
  inherited;
end;

end.
