//
// Erzeugt vom DataSnap-Proxy-Generator.
// 31.10.2021 13:56:28
//

unit ClientModul.Classes;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FAktieAllCommand: TDSRestCommand;
    FAktieAllCommand_Cache: TDSRestCommand;
    FAnsichtCommand: TDSRestCommand;
    FAnsichtCommand_Cache: TDSRestCommand;
    FGuVJahreCommand: TDSRestCommand;
    FGuVJahreCommand_Cache: TDSRestCommand;
    FDepotwerteCommand: TDSRestCommand;
    FDepotwerteCommand_Cache: TDSRestCommand;
    FKursCommand: TDSRestCommand;
    FKursCommand_Cache: TDSRestCommand;
    FTSIWochenCommand: TDSRestCommand;
    FTSIWochenCommand_Cache: TDSRestCommand;
    FBenutzerListCommand: TDSRestCommand;
    FBenutzerListCommand_Cache: TDSRestCommand;
    FDepotnameListCommand: TDSRestCommand;
    FDepotnameListCommand_Cache: TDSRestCommand;
    FAddDepotnameCommand: TDSRestCommand;
    FDeleteDepotnameCommand: TDSRestCommand;
    FChangeDepotnameCommand: TDSRestCommand;
    FAddAktieToDepotCommand: TDSRestCommand;
    FDeleteAktieFormDepotCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function AktieAll(const ARequestFilter: string = ''): TStream;
    function AktieAll_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
    function Ansicht(const ARequestFilter: string = ''): TStream;
    function Ansicht_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
    function GuVJahre(const ARequestFilter: string = ''): TStream;
    function GuVJahre_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
    function Depotwerte(const ARequestFilter: string = ''): TStream;
    function Depotwerte_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
    function Kurs(aAK_Id: Integer; const ARequestFilter: string = ''): TStream;
    function Kurs_Cache(aAK_Id: Integer; const ARequestFilter: string = ''): IDSRestCachedStream;
    function TSIWochen(aAk_ID: Integer; aWochen: Integer; const ARequestFilter: string = ''): TStream;
    function TSIWochen_Cache(aAk_ID: Integer; aWochen: Integer; const ARequestFilter: string = ''): IDSRestCachedStream;
    function BenutzerList(const ARequestFilter: string = ''): TStream;
    function BenutzerList_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
    function DepotnameList(const ARequestFilter: string = ''): TStream;
    function DepotnameList_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
    procedure AddDepotname(aBeId: Integer; aDepotname: string);
    procedure DeleteDepotname(aDpId: Integer);
    procedure ChangeDepotname(aDpId: Integer; aDepotname: string);
    procedure AddAktieToDepot(aDpId: Integer; aAkId: Integer);
    procedure DeleteAktieFormDepot(aDpId: Integer; aAkId: Integer);
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_AktieAll: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_AktieAll_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_Ansicht: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_Ansicht_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GuVJahre: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_GuVJahre_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_Depotwerte: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_Depotwerte_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_Kurs: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aAK_Id'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_Kurs_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aAK_Id'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_TSIWochen: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'aAk_ID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'aWochen'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_TSIWochen_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'aAk_ID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'aWochen'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_BenutzerList: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_BenutzerList_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_DepotnameList: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_DepotnameList_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_AddDepotname: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aBeId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'aDepotname'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_DeleteDepotname: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'aDpId'; Direction: 1; DBXType: 6; TypeName: 'Integer')
  );

  TServerMethods1_ChangeDepotname: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aDpId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'aDepotname'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_AddAktieToDepot: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aDpId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'aAkId'; Direction: 1; DBXType: 6; TypeName: 'Integer')
  );

  TServerMethods1_DeleteAktieFormDepot: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'aDpId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'aAkId'; Direction: 1; DBXType: 6; TypeName: 'Integer')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.AktieAll(const ARequestFilter: string): TStream;
begin
  if FAktieAllCommand = nil then
  begin
    FAktieAllCommand := FConnection.CreateCommand;
    FAktieAllCommand.RequestType := 'GET';
    FAktieAllCommand.Text := 'TServerMethods1.AktieAll';
    FAktieAllCommand.Prepare(TServerMethods1_AktieAll);
  end;
  FAktieAllCommand.Execute(ARequestFilter);
  Result := FAktieAllCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.AktieAll_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FAktieAllCommand_Cache = nil then
  begin
    FAktieAllCommand_Cache := FConnection.CreateCommand;
    FAktieAllCommand_Cache.RequestType := 'GET';
    FAktieAllCommand_Cache.Text := 'TServerMethods1.AktieAll';
    FAktieAllCommand_Cache.Prepare(TServerMethods1_AktieAll_Cache);
  end;
  FAktieAllCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FAktieAllCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.Ansicht(const ARequestFilter: string): TStream;
begin
  if FAnsichtCommand = nil then
  begin
    FAnsichtCommand := FConnection.CreateCommand;
    FAnsichtCommand.RequestType := 'GET';
    FAnsichtCommand.Text := 'TServerMethods1.Ansicht';
    FAnsichtCommand.Prepare(TServerMethods1_Ansicht);
  end;
  FAnsichtCommand.Execute(ARequestFilter);
  Result := FAnsichtCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.Ansicht_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FAnsichtCommand_Cache = nil then
  begin
    FAnsichtCommand_Cache := FConnection.CreateCommand;
    FAnsichtCommand_Cache.RequestType := 'GET';
    FAnsichtCommand_Cache.Text := 'TServerMethods1.Ansicht';
    FAnsichtCommand_Cache.Prepare(TServerMethods1_Ansicht_Cache);
  end;
  FAnsichtCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FAnsichtCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.GuVJahre(const ARequestFilter: string): TStream;
begin
  if FGuVJahreCommand = nil then
  begin
    FGuVJahreCommand := FConnection.CreateCommand;
    FGuVJahreCommand.RequestType := 'GET';
    FGuVJahreCommand.Text := 'TServerMethods1.GuVJahre';
    FGuVJahreCommand.Prepare(TServerMethods1_GuVJahre);
  end;
  FGuVJahreCommand.Execute(ARequestFilter);
  Result := FGuVJahreCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.GuVJahre_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FGuVJahreCommand_Cache = nil then
  begin
    FGuVJahreCommand_Cache := FConnection.CreateCommand;
    FGuVJahreCommand_Cache.RequestType := 'GET';
    FGuVJahreCommand_Cache.Text := 'TServerMethods1.GuVJahre';
    FGuVJahreCommand_Cache.Prepare(TServerMethods1_GuVJahre_Cache);
  end;
  FGuVJahreCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FGuVJahreCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.Depotwerte(const ARequestFilter: string): TStream;
begin
  if FDepotwerteCommand = nil then
  begin
    FDepotwerteCommand := FConnection.CreateCommand;
    FDepotwerteCommand.RequestType := 'GET';
    FDepotwerteCommand.Text := 'TServerMethods1.Depotwerte';
    FDepotwerteCommand.Prepare(TServerMethods1_Depotwerte);
  end;
  FDepotwerteCommand.Execute(ARequestFilter);
  Result := FDepotwerteCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.Depotwerte_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FDepotwerteCommand_Cache = nil then
  begin
    FDepotwerteCommand_Cache := FConnection.CreateCommand;
    FDepotwerteCommand_Cache.RequestType := 'GET';
    FDepotwerteCommand_Cache.Text := 'TServerMethods1.Depotwerte';
    FDepotwerteCommand_Cache.Prepare(TServerMethods1_Depotwerte_Cache);
  end;
  FDepotwerteCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FDepotwerteCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.Kurs(aAK_Id: Integer; const ARequestFilter: string): TStream;
begin
  if FKursCommand = nil then
  begin
    FKursCommand := FConnection.CreateCommand;
    FKursCommand.RequestType := 'GET';
    FKursCommand.Text := 'TServerMethods1.Kurs';
    FKursCommand.Prepare(TServerMethods1_Kurs);
  end;
  FKursCommand.Parameters[0].Value.SetInt32(aAK_Id);
  FKursCommand.Execute(ARequestFilter);
  Result := FKursCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.Kurs_Cache(aAK_Id: Integer; const ARequestFilter: string): IDSRestCachedStream;
begin
  if FKursCommand_Cache = nil then
  begin
    FKursCommand_Cache := FConnection.CreateCommand;
    FKursCommand_Cache.RequestType := 'GET';
    FKursCommand_Cache.Text := 'TServerMethods1.Kurs';
    FKursCommand_Cache.Prepare(TServerMethods1_Kurs_Cache);
  end;
  FKursCommand_Cache.Parameters[0].Value.SetInt32(aAK_Id);
  FKursCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FKursCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethods1Client.TSIWochen(aAk_ID: Integer; aWochen: Integer; const ARequestFilter: string): TStream;
begin
  if FTSIWochenCommand = nil then
  begin
    FTSIWochenCommand := FConnection.CreateCommand;
    FTSIWochenCommand.RequestType := 'GET';
    FTSIWochenCommand.Text := 'TServerMethods1.TSIWochen';
    FTSIWochenCommand.Prepare(TServerMethods1_TSIWochen);
  end;
  FTSIWochenCommand.Parameters[0].Value.SetInt32(aAk_ID);
  FTSIWochenCommand.Parameters[1].Value.SetInt32(aWochen);
  FTSIWochenCommand.Execute(ARequestFilter);
  Result := FTSIWochenCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.TSIWochen_Cache(aAk_ID: Integer; aWochen: Integer; const ARequestFilter: string): IDSRestCachedStream;
begin
  if FTSIWochenCommand_Cache = nil then
  begin
    FTSIWochenCommand_Cache := FConnection.CreateCommand;
    FTSIWochenCommand_Cache.RequestType := 'GET';
    FTSIWochenCommand_Cache.Text := 'TServerMethods1.TSIWochen';
    FTSIWochenCommand_Cache.Prepare(TServerMethods1_TSIWochen_Cache);
  end;
  FTSIWochenCommand_Cache.Parameters[0].Value.SetInt32(aAk_ID);
  FTSIWochenCommand_Cache.Parameters[1].Value.SetInt32(aWochen);
  FTSIWochenCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FTSIWochenCommand_Cache.Parameters[2].Value.GetString);
end;

function TServerMethods1Client.BenutzerList(const ARequestFilter: string): TStream;
begin
  if FBenutzerListCommand = nil then
  begin
    FBenutzerListCommand := FConnection.CreateCommand;
    FBenutzerListCommand.RequestType := 'GET';
    FBenutzerListCommand.Text := 'TServerMethods1.BenutzerList';
    FBenutzerListCommand.Prepare(TServerMethods1_BenutzerList);
  end;
  FBenutzerListCommand.Execute(ARequestFilter);
  Result := FBenutzerListCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.BenutzerList_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FBenutzerListCommand_Cache = nil then
  begin
    FBenutzerListCommand_Cache := FConnection.CreateCommand;
    FBenutzerListCommand_Cache.RequestType := 'GET';
    FBenutzerListCommand_Cache.Text := 'TServerMethods1.BenutzerList';
    FBenutzerListCommand_Cache.Prepare(TServerMethods1_BenutzerList_Cache);
  end;
  FBenutzerListCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FBenutzerListCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.DepotnameList(const ARequestFilter: string): TStream;
begin
  if FDepotnameListCommand = nil then
  begin
    FDepotnameListCommand := FConnection.CreateCommand;
    FDepotnameListCommand.RequestType := 'GET';
    FDepotnameListCommand.Text := 'TServerMethods1.DepotnameList';
    FDepotnameListCommand.Prepare(TServerMethods1_DepotnameList);
  end;
  FDepotnameListCommand.Execute(ARequestFilter);
  Result := FDepotnameListCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.DepotnameList_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FDepotnameListCommand_Cache = nil then
  begin
    FDepotnameListCommand_Cache := FConnection.CreateCommand;
    FDepotnameListCommand_Cache.RequestType := 'GET';
    FDepotnameListCommand_Cache.Text := 'TServerMethods1.DepotnameList';
    FDepotnameListCommand_Cache.Prepare(TServerMethods1_DepotnameList_Cache);
  end;
  FDepotnameListCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FDepotnameListCommand_Cache.Parameters[0].Value.GetString);
end;

procedure TServerMethods1Client.AddDepotname(aBeId: Integer; aDepotname: string);
begin
  if FAddDepotnameCommand = nil then
  begin
    FAddDepotnameCommand := FConnection.CreateCommand;
    FAddDepotnameCommand.RequestType := 'GET';
    FAddDepotnameCommand.Text := 'TServerMethods1.AddDepotname';
    FAddDepotnameCommand.Prepare(TServerMethods1_AddDepotname);
  end;
  FAddDepotnameCommand.Parameters[0].Value.SetInt32(aBeId);
  FAddDepotnameCommand.Parameters[1].Value.SetWideString(aDepotname);
  FAddDepotnameCommand.Execute;
end;

procedure TServerMethods1Client.DeleteDepotname(aDpId: Integer);
begin
  if FDeleteDepotnameCommand = nil then
  begin
    FDeleteDepotnameCommand := FConnection.CreateCommand;
    FDeleteDepotnameCommand.RequestType := 'GET';
    FDeleteDepotnameCommand.Text := 'TServerMethods1.DeleteDepotname';
    FDeleteDepotnameCommand.Prepare(TServerMethods1_DeleteDepotname);
  end;
  FDeleteDepotnameCommand.Parameters[0].Value.SetInt32(aDpId);
  FDeleteDepotnameCommand.Execute;
end;

procedure TServerMethods1Client.ChangeDepotname(aDpId: Integer; aDepotname: string);
begin
  if FChangeDepotnameCommand = nil then
  begin
    FChangeDepotnameCommand := FConnection.CreateCommand;
    FChangeDepotnameCommand.RequestType := 'GET';
    FChangeDepotnameCommand.Text := 'TServerMethods1.ChangeDepotname';
    FChangeDepotnameCommand.Prepare(TServerMethods1_ChangeDepotname);
  end;
  FChangeDepotnameCommand.Parameters[0].Value.SetInt32(aDpId);
  FChangeDepotnameCommand.Parameters[1].Value.SetWideString(aDepotname);
  FChangeDepotnameCommand.Execute;
end;

procedure TServerMethods1Client.AddAktieToDepot(aDpId: Integer; aAkId: Integer);
begin
  if FAddAktieToDepotCommand = nil then
  begin
    FAddAktieToDepotCommand := FConnection.CreateCommand;
    FAddAktieToDepotCommand.RequestType := 'GET';
    FAddAktieToDepotCommand.Text := 'TServerMethods1.AddAktieToDepot';
    FAddAktieToDepotCommand.Prepare(TServerMethods1_AddAktieToDepot);
  end;
  FAddAktieToDepotCommand.Parameters[0].Value.SetInt32(aDpId);
  FAddAktieToDepotCommand.Parameters[1].Value.SetInt32(aAkId);
  FAddAktieToDepotCommand.Execute;
end;

procedure TServerMethods1Client.DeleteAktieFormDepot(aDpId: Integer; aAkId: Integer);
begin
  if FDeleteAktieFormDepotCommand = nil then
  begin
    FDeleteAktieFormDepotCommand := FConnection.CreateCommand;
    FDeleteAktieFormDepotCommand.RequestType := 'GET';
    FDeleteAktieFormDepotCommand.Text := 'TServerMethods1.DeleteAktieFormDepot';
    FDeleteAktieFormDepotCommand.Prepare(TServerMethods1_DeleteAktieFormDepot);
  end;
  FDeleteAktieFormDepotCommand.Parameters[0].Value.SetInt32(aDpId);
  FDeleteAktieFormDepotCommand.Parameters[1].Value.SetInt32(aAkId);
  FDeleteAktieFormDepotCommand.Execute;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FAktieAllCommand.DisposeOf;
  FAktieAllCommand_Cache.DisposeOf;
  FAnsichtCommand.DisposeOf;
  FAnsichtCommand_Cache.DisposeOf;
  FGuVJahreCommand.DisposeOf;
  FGuVJahreCommand_Cache.DisposeOf;
  FDepotwerteCommand.DisposeOf;
  FDepotwerteCommand_Cache.DisposeOf;
  FKursCommand.DisposeOf;
  FKursCommand_Cache.DisposeOf;
  FTSIWochenCommand.DisposeOf;
  FTSIWochenCommand_Cache.DisposeOf;
  FBenutzerListCommand.DisposeOf;
  FBenutzerListCommand_Cache.DisposeOf;
  FDepotnameListCommand.DisposeOf;
  FDepotnameListCommand_Cache.DisposeOf;
  FAddDepotnameCommand.DisposeOf;
  FDeleteDepotnameCommand.DisposeOf;
  FChangeDepotnameCommand.DisposeOf;
  FAddAktieToDepotCommand.DisposeOf;
  FDeleteAktieFormDepotCommand.DisposeOf;
  inherited;
end;

end.
