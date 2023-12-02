//
// Erzeugt vom DataSnap-Proxy-Generator.
// 24.04.2021 16:15:21
//

unit ClientModul.Classes;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TRezeptServerMethodsClient = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FRezeptAllCommand: TDSRestCommand;
    FRezeptAllCommand_Cache: TDSRestCommand;
    FRezeptCommand: TDSRestCommand;
    FRezeptCommand_Cache: TDSRestCommand;
    FZutatenListennameCommand: TDSRestCommand;
    FZutatenListennameCommand_Cache: TDSRestCommand;
    FZutatenListCommand: TDSRestCommand;
    FZutatenListCommand_Cache: TDSRestCommand;
    FSaveRezeptCommand: TDSRestCommand;
    FSaveRezeptPlainNotizCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function RezeptAll(const ARequestFilter: string = ''): TStream;
    function RezeptAll_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
    function Rezept(aRzId: Integer; const ARequestFilter: string = ''): TStream;
    function Rezept_Cache(aRzId: Integer; const ARequestFilter: string = ''): IDSRestCachedStream;
    function ZutatenListenname(aRzId: Integer; const ARequestFilter: string = ''): TStream;
    function ZutatenListenname_Cache(aRzId: Integer; const ARequestFilter: string = ''): IDSRestCachedStream;
    function ZutatenList(aRzId: Integer; aZlId: Integer; const ARequestFilter: string = ''): TStream;
    function ZutatenList_Cache(aRzId: Integer; aZlId: Integer; const ARequestFilter: string = ''): IDSRestCachedStream;
    procedure SaveRezept(aRestRezept: TStream);
    procedure SaveRezeptPlainNotiz(aRestRezept: TStream);
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

  TRezeptServerMethods_RezeptAll: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TRezeptServerMethods_RezeptAll_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TRezeptServerMethods_Rezept: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aRzId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TRezeptServerMethods_Rezept_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aRzId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TRezeptServerMethods_ZutatenListenname: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aRzId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TRezeptServerMethods_ZutatenListenname_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aRzId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TRezeptServerMethods_ZutatenList: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'aRzId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'aZlId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TRezeptServerMethods_ZutatenList_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'aRzId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'aZlId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TRezeptServerMethods_SaveRezept: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'aRestRezept'; Direction: 1; DBXType: 33; TypeName: 'TStream')
  );

  TRezeptServerMethods_SaveRezeptPlainNotiz: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'aRestRezept'; Direction: 1; DBXType: 33; TypeName: 'TStream')
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

function TRezeptServerMethodsClient.RezeptAll(const ARequestFilter: string): TStream;
begin
  if FRezeptAllCommand = nil then
  begin
    FRezeptAllCommand := FConnection.CreateCommand;
    FRezeptAllCommand.RequestType := 'GET';
    FRezeptAllCommand.Text := 'TRezeptServerMethods.RezeptAll';
    FRezeptAllCommand.Prepare(TRezeptServerMethods_RezeptAll);
  end;
  FRezeptAllCommand.Execute(ARequestFilter);
  Result := FRezeptAllCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TRezeptServerMethodsClient.RezeptAll_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FRezeptAllCommand_Cache = nil then
  begin
    FRezeptAllCommand_Cache := FConnection.CreateCommand;
    FRezeptAllCommand_Cache.RequestType := 'GET';
    FRezeptAllCommand_Cache.Text := 'TRezeptServerMethods.RezeptAll';
    FRezeptAllCommand_Cache.Prepare(TRezeptServerMethods_RezeptAll_Cache);
  end;
  FRezeptAllCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FRezeptAllCommand_Cache.Parameters[0].Value.GetString);
end;

function TRezeptServerMethodsClient.Rezept(aRzId: Integer; const ARequestFilter: string): TStream;
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
  Result := FRezeptCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TRezeptServerMethodsClient.Rezept_Cache(aRzId: Integer; const ARequestFilter: string): IDSRestCachedStream;
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
  Result := TDSRestCachedStream.Create(FRezeptCommand_Cache.Parameters[1].Value.GetString);
end;

function TRezeptServerMethodsClient.ZutatenListenname(aRzId: Integer; const ARequestFilter: string): TStream;
begin
  if FZutatenListennameCommand = nil then
  begin
    FZutatenListennameCommand := FConnection.CreateCommand;
    FZutatenListennameCommand.RequestType := 'GET';
    FZutatenListennameCommand.Text := 'TRezeptServerMethods.ZutatenListenname';
    FZutatenListennameCommand.Prepare(TRezeptServerMethods_ZutatenListenname);
  end;
  FZutatenListennameCommand.Parameters[0].Value.SetInt32(aRzId);
  FZutatenListennameCommand.Execute(ARequestFilter);
  Result := FZutatenListennameCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TRezeptServerMethodsClient.ZutatenListenname_Cache(aRzId: Integer; const ARequestFilter: string): IDSRestCachedStream;
begin
  if FZutatenListennameCommand_Cache = nil then
  begin
    FZutatenListennameCommand_Cache := FConnection.CreateCommand;
    FZutatenListennameCommand_Cache.RequestType := 'GET';
    FZutatenListennameCommand_Cache.Text := 'TRezeptServerMethods.ZutatenListenname';
    FZutatenListennameCommand_Cache.Prepare(TRezeptServerMethods_ZutatenListenname_Cache);
  end;
  FZutatenListennameCommand_Cache.Parameters[0].Value.SetInt32(aRzId);
  FZutatenListennameCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FZutatenListennameCommand_Cache.Parameters[1].Value.GetString);
end;

function TRezeptServerMethodsClient.ZutatenList(aRzId: Integer; aZlId: Integer; const ARequestFilter: string): TStream;
begin
  if FZutatenListCommand = nil then
  begin
    FZutatenListCommand := FConnection.CreateCommand;
    FZutatenListCommand.RequestType := 'GET';
    FZutatenListCommand.Text := 'TRezeptServerMethods.ZutatenList';
    FZutatenListCommand.Prepare(TRezeptServerMethods_ZutatenList);
  end;
  FZutatenListCommand.Parameters[0].Value.SetInt32(aRzId);
  FZutatenListCommand.Parameters[1].Value.SetInt32(aZlId);
  FZutatenListCommand.Execute(ARequestFilter);
  Result := FZutatenListCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TRezeptServerMethodsClient.ZutatenList_Cache(aRzId: Integer; aZlId: Integer; const ARequestFilter: string): IDSRestCachedStream;
begin
  if FZutatenListCommand_Cache = nil then
  begin
    FZutatenListCommand_Cache := FConnection.CreateCommand;
    FZutatenListCommand_Cache.RequestType := 'GET';
    FZutatenListCommand_Cache.Text := 'TRezeptServerMethods.ZutatenList';
    FZutatenListCommand_Cache.Prepare(TRezeptServerMethods_ZutatenList_Cache);
  end;
  FZutatenListCommand_Cache.Parameters[0].Value.SetInt32(aRzId);
  FZutatenListCommand_Cache.Parameters[1].Value.SetInt32(aZlId);
  FZutatenListCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FZutatenListCommand_Cache.Parameters[2].Value.GetString);
end;

procedure TRezeptServerMethodsClient.SaveRezept(aRestRezept: TStream);
begin
  if FSaveRezeptCommand = nil then
  begin
    FSaveRezeptCommand := FConnection.CreateCommand;
    FSaveRezeptCommand.RequestType := 'POST';
    FSaveRezeptCommand.Text := 'TRezeptServerMethods."SaveRezept"';
    FSaveRezeptCommand.Prepare(TRezeptServerMethods_SaveRezept);
  end;
  FSaveRezeptCommand.Parameters[0].Value.SetStream(aRestRezept, FInstanceOwner);
  FSaveRezeptCommand.Execute;
end;

procedure TRezeptServerMethodsClient.SaveRezeptPlainNotiz(aRestRezept: TStream);
begin
  if FSaveRezeptPlainNotizCommand = nil then
  begin
    FSaveRezeptPlainNotizCommand := FConnection.CreateCommand;
    FSaveRezeptPlainNotizCommand.RequestType := 'POST';
    FSaveRezeptPlainNotizCommand.Text := 'TRezeptServerMethods."SaveRezeptPlainNotiz"';
    FSaveRezeptPlainNotizCommand.Prepare(TRezeptServerMethods_SaveRezeptPlainNotiz);
  end;
  FSaveRezeptPlainNotizCommand.Parameters[0].Value.SetStream(aRestRezept, FInstanceOwner);
  FSaveRezeptPlainNotizCommand.Execute;
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
  FRezeptAllCommand.DisposeOf;
  FRezeptAllCommand_Cache.DisposeOf;
  FRezeptCommand.DisposeOf;
  FRezeptCommand_Cache.DisposeOf;
  FZutatenListennameCommand.DisposeOf;
  FZutatenListennameCommand_Cache.DisposeOf;
  FZutatenListCommand.DisposeOf;
  FZutatenListCommand_Cache.DisposeOf;
  FSaveRezeptCommand.DisposeOf;
  FSaveRezeptPlainNotizCommand.DisposeOf;
  inherited;
end;

end.
