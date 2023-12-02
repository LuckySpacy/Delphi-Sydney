// 
// Erzeugt vom DataSnap-Proxy-Generator.
// 19.04.2021 13:42:19
// 

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Rest.Rezept, Rest.RezeptList, System.Contnrs, Data.DBXJSONReflect;

type

  IDSRestCachedTRestRezept = interface;
  IDSRestCachedTRestRezeptList = interface;
  IDSRestCachedTObjectList = interface;

  TRezeptServerMethodsClient = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FRezeptCommand: TDSRestCommand;
    FRezeptCommand_Cache: TDSRestCommand;
    FRezeptAllCommand: TDSRestCommand;
    FRezeptAllCommand_Cache: TDSRestCommand;
    FRezeptAll2Command: TDSRestCommand;
    FRezeptAll2Command_Cache: TDSRestCommand;
    FTestStreamCommand: TDSRestCommand;
    FTestStreamCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function Rezept(aRzId: Integer; const ARequestFilter: string = ''): TRestRezept;
    function Rezept_Cache(aRzId: Integer; const ARequestFilter: string = ''): IDSRestCachedTRestRezept;
    function RezeptAll(const ARequestFilter: string = ''): TRestRezeptList;
    function RezeptAll_Cache(const ARequestFilter: string = ''): IDSRestCachedTRestRezeptList;
    function RezeptAll2(const ARequestFilter: string = ''): TObjectList;
    function RezeptAll2_Cache(const ARequestFilter: string = ''): IDSRestCachedTObjectList;
    function TestStream(const ARequestFilter: string = ''): TStream;
    function TestStream_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
  end;

  IDSRestCachedTRestRezept = interface(IDSRestCachedObject<TRestRezept>)
  end;

  TDSRestCachedTRestRezept = class(TDSRestCachedObject<TRestRezept>, IDSRestCachedTRestRezept, IDSRestCachedCommand)
  end;
  IDSRestCachedTRestRezeptList = interface(IDSRestCachedObject<TRestRezeptList>)
  end;

  TDSRestCachedTRestRezeptList = class(TDSRestCachedObject<TRestRezeptList>, IDSRestCachedTRestRezeptList, IDSRestCachedCommand)
  end;
  IDSRestCachedTObjectList = interface(IDSRestCachedObject<TObjectList>)
  end;

  TDSRestCachedTObjectList = class(TDSRestCachedObject<TObjectList>, IDSRestCachedTObjectList, IDSRestCachedCommand)
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

  TRezeptServerMethods_RezeptAll: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRestRezeptList')
  );

  TRezeptServerMethods_RezeptAll_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TRezeptServerMethods_RezeptAll2: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TObjectList')
  );

  TRezeptServerMethods_RezeptAll2_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TRezeptServerMethods_TestStream: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TRezeptServerMethods_TestStream_Cache: array [0..0] of TDSRestParameterMetaData =
  (
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

function TRezeptServerMethodsClient.RezeptAll(const ARequestFilter: string): TRestRezeptList;
begin
  if FRezeptAllCommand = nil then
  begin
    FRezeptAllCommand := FConnection.CreateCommand;
    FRezeptAllCommand.RequestType := 'GET';
    FRezeptAllCommand.Text := 'TRezeptServerMethods.RezeptAll';
    FRezeptAllCommand.Prepare(TRezeptServerMethods_RezeptAll);
  end;
  FRezeptAllCommand.Execute(ARequestFilter);
  if not FRezeptAllCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FRezeptAllCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRestRezeptList(FUnMarshal.UnMarshal(FRezeptAllCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FRezeptAllCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TRezeptServerMethodsClient.RezeptAll_Cache(const ARequestFilter: string): IDSRestCachedTRestRezeptList;
begin
  if FRezeptAllCommand_Cache = nil then
  begin
    FRezeptAllCommand_Cache := FConnection.CreateCommand;
    FRezeptAllCommand_Cache.RequestType := 'GET';
    FRezeptAllCommand_Cache.Text := 'TRezeptServerMethods.RezeptAll';
    FRezeptAllCommand_Cache.Prepare(TRezeptServerMethods_RezeptAll_Cache);
  end;
  FRezeptAllCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRestRezeptList.Create(FRezeptAllCommand_Cache.Parameters[0].Value.GetString);
end;

function TRezeptServerMethodsClient.RezeptAll2(const ARequestFilter: string): TObjectList;
begin
  if FRezeptAll2Command = nil then
  begin
    FRezeptAll2Command := FConnection.CreateCommand;
    FRezeptAll2Command.RequestType := 'GET';
    FRezeptAll2Command.Text := 'TRezeptServerMethods.RezeptAll2';
    FRezeptAll2Command.Prepare(TRezeptServerMethods_RezeptAll2);
  end;
  FRezeptAll2Command.Execute(ARequestFilter);
  if not FRezeptAll2Command.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FRezeptAll2Command.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TObjectList(FUnMarshal.UnMarshal(FRezeptAll2Command.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FRezeptAll2Command.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TRezeptServerMethodsClient.RezeptAll2_Cache(const ARequestFilter: string): IDSRestCachedTObjectList;
begin
  if FRezeptAll2Command_Cache = nil then
  begin
    FRezeptAll2Command_Cache := FConnection.CreateCommand;
    FRezeptAll2Command_Cache.RequestType := 'GET';
    FRezeptAll2Command_Cache.Text := 'TRezeptServerMethods.RezeptAll2';
    FRezeptAll2Command_Cache.Prepare(TRezeptServerMethods_RezeptAll2_Cache);
  end;
  FRezeptAll2Command_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTObjectList.Create(FRezeptAll2Command_Cache.Parameters[0].Value.GetString);
end;

function TRezeptServerMethodsClient.TestStream(const ARequestFilter: string): TStream;
begin
  if FTestStreamCommand = nil then
  begin
    FTestStreamCommand := FConnection.CreateCommand;
    FTestStreamCommand.RequestType := 'GET';
    FTestStreamCommand.Text := 'TRezeptServerMethods.TestStream';
    FTestStreamCommand.Prepare(TRezeptServerMethods_TestStream);
  end;
  FTestStreamCommand.Execute(ARequestFilter);
  Result := FTestStreamCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TRezeptServerMethodsClient.TestStream_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FTestStreamCommand_Cache = nil then
  begin
    FTestStreamCommand_Cache := FConnection.CreateCommand;
    FTestStreamCommand_Cache.RequestType := 'GET';
    FTestStreamCommand_Cache.Text := 'TRezeptServerMethods.TestStream';
    FTestStreamCommand_Cache.Prepare(TRezeptServerMethods_TestStream_Cache);
  end;
  FTestStreamCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FTestStreamCommand_Cache.Parameters[0].Value.GetString);
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
  FRezeptAllCommand.DisposeOf;
  FRezeptAllCommand_Cache.DisposeOf;
  FRezeptAll2Command.DisposeOf;
  FRezeptAll2Command_Cache.DisposeOf;
  FTestStreamCommand.DisposeOf;
  FTestStreamCommand_Cache.DisposeOf;
  inherited;
end;

end.
