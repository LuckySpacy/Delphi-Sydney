unit Form.MainTSIDepot;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  Form.TSIDepot, ClientModule.Module, ClientModule.Classes, Rest.BenutzerList,
  dm.Style, Form.TSIDepotname, Rest.DepotnameList, Rest.Depotname, FMX.Objects,
  Rest.AnsichtList;

type
  Tfrm_MainTSIDepot = class(TForm)
    tbc: TTabControl;
    tab_Depot: TTabItem;
    tab_Depotname: TTabItem;
    rec_Background: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fFormDepot: Tfrm_TSIDepot;
    fFormDepotname: Tfrm_TSIDepotName;
    fRestBenutzerList: TRestBenutzerlist;
    fRestDepotnameList: TRestDepotnameList;
    fRestAnsichtList: TRestAnsichtList;

    procedure LadeBenutzerliste;
    procedure LadeDepotnameliste(Sender: TObject);
    procedure ShowTSIDepotname(aBeId, aDbId: Integer; aDepotname: string);
    procedure TSIDepotnameClosedForm(aDepotname: string; aDone: Boolean);
    procedure LadeAnsichtList;
  public
  end;

var
  frm_MainTSIDepot: Tfrm_MainTSIDepot;

implementation

{$R *.fmx}

procedure Tfrm_MainTSIDepot.FormCreate(Sender: TObject);
begin //
  fFormDepot := Tfrm_TSIDepot.Create(Self);
  while fFormDepot.ChildrenCount>0 do
    fFormDepot.Children[0].Parent := tab_Depot;
  fFormDepot.OnShowDepotname := ShowTSIDepotname;
  fFormDepot.OnRefreshDepotnameList := LadeDepotnameliste;

  fFormDepotname := Tfrm_TSIDepotname.Create(Self);
  while fFormDepotname.ChildrenCount>0 do
    fFormDepotname.Children[0].Parent := tab_Depotname;
 fFormDepotname.OnCloseForm := TSIDepotnameClosedForm;

  fRestBenutzerList  := TRestBenutzerlist.Create;
  fRestDepotnameList := TRestDepotnameList.Create;
  fRestAnsichtList   := TRestAnsichtList.Create;
  fRestDepotnameList := TRestDepotnameList.Create;


  tbc.ActiveTab := tab_Depot;
  tbc.TabPosition := TTabPosition.None;

  {$IFDEF WIN32}
  stylebook := nil;
  {$ENDIF WIN32}

end;

procedure Tfrm_MainTSIDepot.FormDestroy(Sender: TObject);
begin  //
  FreeAndNil(fRestDepotnameList);
  FreeAndNil(fRestBenutzerList);
  FreeAndNil(fRestAnsichtList);
  FreeAndNil(fRestDepotnameList);
end;

procedure Tfrm_MainTSIDepot.FormShow(Sender: TObject);
begin
  LadeBenutzerliste;
  LadeDepotnameliste(nil);
  LadeAnsichtList;
  fFormDepot.setBenutzerliste(fRestBenutzerList);
  fFormDepot.setDepotnameliste(fRestDepotnameList);
  fFormDepot.setAnsichtList(fRestAnsichtList);
end;

procedure Tfrm_MainTSIDepot.LadeBenutzerliste;
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule1.DSRestConnection1);
  ClientModule1.DSRestConnection1.Host := '127.0.0.1';
  Stream := Temp.BenutzerList;
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestBenutzerList.LoadFromStream(MemStream);
  //Kurs := fRestTSIList.Item[fRestTSIList.Count-1];
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;



procedure Tfrm_MainTSIDepot.LadeAnsichtList;
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule1.DSRestConnection1);
  Stream := Temp.Ansicht;
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestAnsichtList.LoadFromStream(MemStream);
  //Button1.Text := fRezeptList.Item[0].FieldByName('Rezeptname').AsString;
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;


procedure Tfrm_MainTSIDepot.ShowTSIDepotname(aBeId, aDbId: Integer; aDepotname: string);
begin
  tbc.ActiveTab := tab_Depotname;
  fFormDepotname.edt_Depotname.Text := aDepotname;
  fFormDepotname.DpId := aDbId;
  fFormDepotname.BeId := aBeId;
  fFormDepotname.edt_Depotname.setFocus;
end;

procedure Tfrm_MainTSIDepot.TSIDepotnameClosedForm(aDepotname: string;
  aDone: Boolean);
begin
  tbc.ActiveTab := tab_Depot;
  if aDone then
  begin
    fFormDepot.ChangeDepotname(fFormDepotname.DpId , aDepotname);
  end;
end;






procedure Tfrm_MainTSIDepot.LadeDepotnameliste(Sender: TObject);
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule1.DSRestConnection1);
  Stream := Temp.DepotnameList;
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestDepotnameList.LoadFromStream(MemStream);
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;

end.
