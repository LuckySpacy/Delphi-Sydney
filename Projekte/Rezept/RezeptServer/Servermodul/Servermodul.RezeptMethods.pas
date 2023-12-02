unit Servermodul.RezeptMethods;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  DB.Rezept, Datamodul.Database, Rest.Rezept, Rest.RezeptList, DB.RezeptList,
  Contnrs, DB.RzZtList, DB.RzZt, Rest.ZutatenlistennameList, Rest.Zutatenlistenname,
  DB.RezeptZutatenList, DB.RezeptZutaten, Rest.Rezeptzutaten, Rest.RezeptzutatenList;

type
{$METHODINFO ON}
  TRezeptServerMethods = class(TComponent)
  private
  public
    { Public-Deklarationen }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function RezeptAll: TStream;
    function Rezept(aRzId: Integer): TStream;
    function ZutatenListenname(aRzId: Integer): TStream;
    function ZutatenList(aRzId, aZlId: Integer): TStream;
    procedure SaveRezept(aRestRezept: TStream);
    procedure SaveRezeptPlainNotiz(aRestRezept: TStream);
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils;

constructor TRezeptServerMethods.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TRezeptServerMethods.Destroy;
begin
  inherited;
end;

function TRezeptServerMethods.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TRezeptServerMethods.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TRezeptServerMethods.Rezept(aRzId: Integer): TStream;
var
  stream: TMemoryStream;
  DBRezept : TDBRezept;
  RestRezept: TRestRezept;
begin
  Result := TMemorystream.Create;
  DBRezept   := TDBRezept.Create(self);
  RestRezept := TRestRezept.Create;
  try
    DBRezept.Trans := dm.getTrans;
    DBRezept.Read(aRzId);
    RestRezept.CopyFromDBFeldList(DBRezept);
    Stream := RestRezept.getStream;
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(DBRezept);
    FreeAndNil(RestRezept);
  end;
end;

function TRezeptServerMethods.RezeptAll: TStream;
var
  stream: TMemoryStream;
  DBRezeptList : TDBRezeptList;
  RestRezeptList: TRestRezeptList;
begin
  Result := TMemorystream.Create;
  DBRezeptList   := TDBRezeptList.Create;
  RestRezeptList := TRestRezeptList.Create;
  try
    DBRezeptList.Trans := dm.getTrans;
    DBRezeptList.ReadAll;
    RestRezeptList.CopyFromDBFeldList(DBRezeptList);
    Stream := RestRezeptList.getStream;
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(DBRezeptList);
    FreeAndNil(RestRezeptList);
  end;
end;


procedure TRezeptServerMethods.SaveRezept(aRestRezept: TStream);
var
  DBRezept : TDBRezept;
  RestRezept: TRestRezept;
begin
  DBRezept   := TDBRezept.Create(self);
  RestRezept := TRestRezept.Create;
  try
    DBRezept.Trans := dm.getTrans;
    aRestRezept.Position := 0;
    RestRezept.LoadFromStream(TMemoryStream(aRestRezept));
    DBRezept.Read(RestRezept.FieldByName('id').AsInteger);
    if not DBRezept.Gefunden then
      exit;
    DBRezept.Notiz := RestRezept.FieldByName('Notiz').AsString;
    DBRezept.SaveToDB;
  finally
    FreeAndNil(DBRezept);
    FreeAndNil(RestRezept);
  end;
end;

procedure TRezeptServerMethods.SaveRezeptPlainNotiz(aRestRezept: TStream);
var
  DBRezept : TDBRezept;
  RestRezept: TRestRezept;
begin
  DBRezept   := TDBRezept.Create(self);
  RestRezept := TRestRezept.Create;
  try
    DBRezept.Trans := dm.getTrans;
    aRestRezept.Position := 0;
    RestRezept.LoadFromStream(TMemoryStream(aRestRezept));
    DBRezept.Read(RestRezept.FieldByName('id').AsInteger);
    if not DBRezept.Gefunden then
      exit;
    DBRezept.Notiz := RestRezept.FieldByName('PLAINNOTIZ').AsString;
    //DBRezept.PlainNotiz := RestRezept.FieldByName('PLAINNOTIZ').AsString;
    DBRezept.SaveToDB;
  finally
    FreeAndNil(DBRezept);
    FreeAndNil(RestRezept);
  end;
end;

function TRezeptServerMethods.ZutatenList(aRzId, aZlId: Integer): TStream;
var
  stream: TMemoryStream;
  DBRezeptZutatenList : TDBRezeptZutatenList;
  RestRezeptZutatenList: TRestRezeptZutatenList;
begin
  Result := TMemorystream.Create;
  DBRezeptZutatenList   := TDBRezeptZutatenList.Create;
  RestRezeptZutatenList := TRestRezeptZutatenList.Create;
  try
    DBRezeptZutatenList.Trans := dm.getTrans;
    DBRezeptZutatenList.ReadAll(aRzId, aZlId);
    RestRezeptZutatenList.CopyFromDBFeldList(DBRezeptZutatenList);
    Stream := RestRezeptZutatenList.getStream;
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(DBRezeptZutatenList);
    FreeAndNil(RestRezeptZutatenList);
  end;
end;

function TRezeptServerMethods.ZutatenListenname(aRzId: Integer): TStream;
var
  stream: TMemoryStream;
  DBRzZtList: TDBRzZtList;
  RestZutatenListennameList: TRestZutatenListennameList;
  RestZutatenListenname: TRestZutatenlistenname;
  i1: Integer;
begin
  Result := TMemorystream.Create;
  RestZutatenListennameList := TRestZutatenListennameList.Create;
  DBRzZtList := TDBRzZtList.Create;
  try
    DBRzZtList.Trans := dm.getTrans;
    DBRzZtList.ReadAll(aRzId);
    for i1 := 0 to DBRzZtList.Count -1 do
    begin
      RestZutatenListenname := RestZutatenListennameList.Add;
      RestZutatenListenname.FieldByName('RZ_ID').AsInteger := DBRzZtList.Item[i1].RZ_ID;
      RestZutatenListenname.FieldByName('ZL_ID').AsInteger := DBRzZtList.Item[i1].ZL_ID;
      RestZutatenListenname.FieldByName('Listenname').AsString  := DBRzZtList.Item[i1].Zutatenlistenname;
    end;
    Stream := RestZutatenListennameList.getStream;
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(DBRzZtList);
    FreeAndNil(RestZutatenListennameList);
  end;

end;

end.

