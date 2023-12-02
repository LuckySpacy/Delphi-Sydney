unit Servermodul.TSISnapServerMethods;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
 DB.AktieList, DB.Aktie, Rest.Aktie, Rest.AktieList, Datamodul.Database,
 View.Ansicht, View.AnsichtList, Rest.Ansicht, Rest.AnsichtList,
 DB.KursList, DB.Kurs, Rest.Kurs, Rest.KursList, DB.TSI, DB.TSIList,
 Rest.TSI, Rest.TSIList, fmx.Dialogs, View.GuvJahre, View.GuVJahreList,
 Rest.GuvJahre, Rest.GuvJahreList, DB.Benutzer, DB.BenutzerList, Rest.Benutzer, Rest.BenutzerList,
 DB.Depotname, DB.DepotnameList, Rest.Depotname, Rest.Depotnamelist, View.Depotwerte, View.DepotwerteList,
 Rest.DepotwerteList, DB.Depotwerte, DB.DepotwerteList;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function AktieAll: TStream;
    function Ansicht: TStream;
    function GuVJahre: TStream;
    function Depotwerte: TStream;
    function Kurs(aAK_Id: Integer): TStream;
    function TSIWochen(aAk_ID, aWochen: Integer): TStream;
    function BenutzerList: TStream;
    function DepotnameList: TStream;
    procedure AddDepotname(aBeId: Integer; aDepotname: string);
    procedure DeleteDepotname(aDpId: Integer);
    procedure ChangeDepotname(aDpId: Integer; aDepotname: string);
    procedure AddAktieToDepot(aDpId, aAkId: Integer);
    procedure DeleteAktieFormDepot(aDpId, aAkId: Integer);
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils;


function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;



function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;


function TServerMethods1.TSIWochen(aAk_ID, aWochen: Integer): TStream;
var
  stream: TMemoryStream;
  DBTSIList : TDBTSIList;
  RestTSIList: TRestTSIList;
begin
  Result := TMemorystream.Create;
  DBTSIList   := TDBTSIList.Create;
  RestTSIList := TRestTSIList.Create;
  try
    DBTSIList.Trans := dm.IBT_TSI;
    DBTSIList.ReadAllWochen(aAk_Id, aWochen);
    RestTSIList.CopyFromDBFeldList(DBTSIList);
    Stream := RestTSIList.getStream;
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(DBTSIList);
    FreeAndNil(RestTSIList);
  end;
end;


function TServerMethods1.AktieAll: TStream;
var
  stream: TMemoryStream;
  DBAktieList : TDBAktieList;
  RestAktieList: TRestAktieList;
begin
  Result := TMemorystream.Create;
  DBAktieList   := TDBAktieList.Create;
  RestAktieList := TRestAktieList.Create;
  try
    DBAktieList.Trans := dm.IBT_TSI;
    DBAktieList.ReadAll;
    RestAktieList.CopyFromDBFeldList(DBAktieList);
    Stream := RestAktieList.getStream;
    Stream.Position := 0;
    //Stream.SaveToFile('d:\temptsi\AktieAll.txt');
    //Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(DBAktieList);
    FreeAndNil(RestAktieList);
  end;
end;

function TServerMethods1.Ansicht: TStream;
var
  stream: TMemoryStream;
  ViewAnsichtList : TVWAnsichtList;
  RestAnsichtList: TRestAnsichtList;
 // List: TStringList;
begin
  //List := TStringList.Create;
  Result := TMemorystream.Create;
  ViewAnsichtList   := TVWAnsichtList.Create;
  RestAnsichtList := TRestAnsichtList.Create;
  try
    ViewAnsichtList.Trans := dm.IBT_TSI;
    ViewAnsichtList.ReadAll;
   // List.Add('ViewAnsichtList-Anzahl: ' + IntToStr(ViewAnsichtList.Count));
    RestAnsichtList.CopyFromDBFeldList(ViewAnsichtList, true);
    //List.Add('RestAnsichtList-Anzahl: ' + IntToStr(RestAnsichtList.Count));
    //List.SaveToFile('d:\temptsi\Protokoll.txt');
    Stream := RestAnsichtList.getStream;
    //Stream.Position := 0;
    //Stream.SaveToFile('d:\temptsi\Ansicht.txt');
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(ViewAnsichtList);
    FreeAndNil(RestAnsichtList);
    //FreeAndNil(List);
  end;
end;

function TServerMethods1.GuVJahre: TStream;
var
  stream: TMemoryStream;
  ViewGuVJahreList : TVWGuVJahreList;
  RestGuVJahreList: TRestGuVJahreList;
begin
  Result := TMemorystream.Create;
  ViewGuVJahreList   := TVWGuVJahreList.Create;
  RestGuVJahreList := TRestGuVJahreList.Create;
  try
    ViewGuVJahreList.Trans := dm.IBT_TSI;
    ViewGuVJahreList.ReadAll;
   // List.Add('ViewAnsichtList-Anzahl: ' + IntToStr(ViewAnsichtList.Count));
    RestGuVJahreList.CopyFromDBFeldList(ViewGuVJahreList, true);
    //List.Add('RestAnsichtList-Anzahl: ' + IntToStr(RestAnsichtList.Count));
    //List.SaveToFile('d:\temptsi\Protokoll.txt');
    Stream := RestGuVJahreList.getStream;
    //Stream.Position := 0;
    //Stream.SaveToFile('d:\temptsi\Ansicht.txt');
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(ViewGuVJahreList);
    FreeAndNil(RestGuVJahreList);
    //FreeAndNil(List);
  end;
end;


function TServerMethods1.Kurs(aAK_Id: Integer): TStream;
var
  stream: TMemoryStream;
  DBKursList : TDBKursList;
  RestKursList: TRestKursList;
  //Kurs: TRestKurs;
begin
  Result := TMemorystream.Create;
  DBKursList   := TDBKursList.Create;
  RestKursList := TRestKursList.Create;
  try
    DBKursList.Trans := dm.IBT_TSI;
    DBKursList.ReadAll(aAK_Id);
    RestKursList.CopyFromDBFeldList(DBKursList);
    Stream := RestKursList.getStream;
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(DBKursList);
    FreeAndNil(RestKursList);
  end;
end;


function TServerMethods1.BenutzerList: TStream;
var
  stream: TMemoryStream;
  DBBenutzerList : TDBBenutzerList;
  RestBenutzerList: TRestBenutzerList;
begin
  Result := TMemorystream.Create;
  DBBenutzerList   := TDBBenutzerList.Create;
  RestBenutzerList := TRestBenutzerList.Create;
  try
    DBBenutzerList.Trans := dm.IBT_TSI;
    DBBenutzerList.ReadAll;
    RestBenutzerList.CopyFromDBFeldList(DBBenutzerList);
    Stream := RestBenutzerList.getStream;
    Stream.Position := 0;
    //Stream.SaveToFile('d:\temptsi\AktieAll.txt');
    //Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(DBBenutzerList);
    FreeAndNil(RestBenutzerList);
  end;
end;




function TServerMethods1.DepotnameList: TStream;
var
  stream: TMemoryStream;
  DBDepotnameList : TDBDepotnameList;
  RestDepotnameList: TRestDepotnameList;
begin
  Result := TMemorystream.Create;
  DBDepotnameList   := TDBDepotnameList.Create;
  RestDepotnameList := TRestDepotnameList.Create;
  try
    DBDepotnameList.Trans := dm.IBT_TSI;
    DBDepotnameList.ReadAll;
    RestDepotnameList.CopyFromDBFeldList(DBDepotnameList);
    Stream := RestDepotnameList.getStream;
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(DBDepotnameList);
    FreeAndNil(RestDepotnameList);
  end;
end;


function TServerMethods1.Depotwerte: TStream;
var
  stream: TMemoryStream;
  ViewDepotwerteList : TVWDeportwerteList;
  RestDepotwerteList : TRestDepotwerteList;
begin
  Result := TMemorystream.Create;
  ViewDepotwerteList   := TVWDeportwerteList.Create;
  RestDepotwerteList   := TRestDepotwerteList.Create;
  try
    ViewDepotwerteList.Trans := dm.IBT_TSI;
    ViewDepotwerteList.ReadAll;
   // List.Add('ViewAnsichtList-Anzahl: ' + IntToStr(ViewAnsichtList.Count));
    RestDepotwerteList.CopyFromDBFeldList(ViewDepotwerteList, true);
    //List.Add('RestAnsichtList-Anzahl: ' + IntToStr(RestAnsichtList.Count));
    //List.SaveToFile('d:\temptsi\Protokoll.txt');
    Stream := RestDepotwerteList.getStream;
    //Stream.Position := 0;
    //Stream.SaveToFile('d:\temptsi\Ansicht.txt');
    Stream.Position := 0;
    Result.CopyFrom(Stream, Stream.Size);
  finally
    FreeAndNil(ViewDepotwerteList);
    FreeAndNil(RestDepotwerteList);
    //FreeAndNil(List);
  end;
end;


procedure TServerMethods1.AddAktieToDepot(aDpId, aAkId: Integer);
var
  DBDepotwerte: TDBDepotwerte;
begin
  DBDepotwerte := TDBDepotwerte.Create(nil);
  try
    DBDepotwerte.Trans := dm.IBT_TSI;
    DBDepotwerte.ReadAktie(aDpId, aAkId);
    if not DBDepotwerte.Gefunden then
    begin
      DBDepotwerte.Init;
      DBDepotwerte.DpId := aDpId;
      DBDepotwerte.AkId := aAkId;
      DBDepotwerte.SaveToDB;
    end;
  finally
    FreeAndNil(DBDepotwerte);
  end;
end;

procedure TServerMethods1.AddDepotname(aBeId: Integer; aDepotname: string);
var
  DBDepotname: TDBDepotname;
begin
  DBDepotname := TDBDepotname.Create(nil);
  try
    DBDepotname.Trans := dm.IBT_TSI;
    DBDepotname.Depotname := aDepotname;
    DBDepotname.BeId      := aBeId;
    DBDepotname.SaveToDB;
  finally
    FreeAndNil(DBDepotname);
  end;

end;

procedure TServerMethods1.DeleteAktieFormDepot(aDpId, aAkId: Integer);
var
  DBDepotwerte: TDBDepotwerte;
begin
  DBDepotwerte := TDBDepotwerte.Create(nil);
  try
    DBDepotwerte.Trans := dm.IBT_TSI;
    DBDepotwerte.ReadAktie(aDpId, aAkId);
    if DBDepotwerte.Gefunden then
      DBDepotwerte.Delete;
  finally
    FreeAndNil(DBDepotwerte);
  end;
end;

procedure TServerMethods1.DeleteDepotname(aDpId: Integer);
var
  DBDepotname: TDBDepotname;
  DBDepotwerteList: TDBDepotwerteList;
begin
  DBDepotwerteList := TDBDepotwerteList.Create;
  DBDepotname := TDBDepotname.Create(nil);
  try
    DBDepotwerteList.Trans := dm.IBT_TSI;
    DBDepotname.Trans := dm.IBT_TSI;
    DBDepotname.Read(aDPId);
    if DBDepotname.Gefunden then
    begin
      if DBDepotname.Delete then
      begin
        DBDepotwerteList.DeleteAll(aDpId);
      end;
    end;
  finally
    FreeAndNil(DBDepotname);
    FreeAndNil(DBDepotwerteList);
  end;

end;


procedure TServerMethods1.ChangeDepotname(aDpId: Integer; aDepotname: string);
var
  DBDepotname: TDBDepotname;
begin
  DBDepotname := TDBDepotname.Create(nil);
  try
    DBDepotname.Trans := dm.IBT_TSI;
    DBDepotname.Read(aDPId);
    if DBDepotname.Gefunden then
    begin
      DBDepotname.Depotname := aDepotname;
      DBDepotname.SaveToDB;
    end;
  finally
    FreeAndNil(DBDepotname);
  end;
end;




end.

