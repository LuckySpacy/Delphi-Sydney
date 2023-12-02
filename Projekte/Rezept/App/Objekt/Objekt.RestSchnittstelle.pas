unit Objekt.RestSchnittstelle;

interface

uses
  sysUtils, Classes, Rest.ZutatenlistennameList, Rest.RezeptZutatenList;

type
  TRestSchnittstelle = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure HoleZutatenlistenname(aZutatenlistennameList: TRestZutatenlistennameList; aRzId: Integer);
    procedure HoleZutatenlist(aZutatenlist: TRestRezeptZutatenList; aRzId, aZlId: Integer);
    procedure SaveRezept(aRezeptStream: TMemoryStream);
    procedure SaveRezeptPlainNotiz(aRezeptStream: TMemoryStream);
  end;

var
  RestSchnittstelle: TRestSchnittstelle;

implementation

{ TRestSchnittstelle }

uses
  ClientModul.Classes, ClientModul.Module;

constructor TRestSchnittstelle.Create;
begin

end;

destructor TRestSchnittstelle.Destroy;
begin

  inherited;
end;




procedure TRestSchnittstelle.HoleZutatenlist(
  aZutatenlist: TRestRezeptZutatenList; aRzId, aZlId: Integer);
var
  Temp: TRezeptServerMethodsClient;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TRezeptServerMethodsClient.Create(ClientModule1.DSRestConnection1);
  Stream := Temp.ZutatenList(aRzId, aZlId);
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  aZutatenlist.LoadFromStream(MemStream);
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;


procedure TRestSchnittstelle.HoleZutatenlistenname(
  aZutatenlistennameList: TRestZutatenlistennameList; aRzId: Integer);
var
  Temp: TRezeptServerMethodsClient;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TRezeptServerMethodsClient.Create(ClientModule1.DSRestConnection1);
  Stream := Temp.ZutatenListenname(aRzId);
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  aZutatenlistennameList.LoadFromStream(MemStream);
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;




procedure TRestSchnittstelle.SaveRezept(aRezeptStream: TMemoryStream);
var
  Temp: TRezeptServerMethodsClient;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  Temp := TRezeptServerMethodsClient.Create(ClientModule1.DSRestConnection1);
  aRezeptStream.Position := 0;
  Temp.SaveRezept(aRezeptStream);
  FreeAndNil(Temp);
end;

procedure TRestSchnittstelle.SaveRezeptPlainNotiz(aRezeptStream: TMemoryStream);
var
  Temp: TRezeptServerMethodsClient;
begin
  Temp := TRezeptServerMethodsClient.Create(ClientModule1.DSRestConnection1);
  aRezeptStream.Position := 0;
  Temp.SaveRezeptPlainNotiz(aRezeptStream);
  FreeAndNil(Temp);
end;


initialization
  RestSchnittstelle := TRestSchnittstelle.Create;

finalization
 if RestSchnittstelle <> nil then
   FreeAndNil(RestSchnittstelle);


end.
