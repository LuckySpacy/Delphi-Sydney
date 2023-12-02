unit Form.TSIAnsicht;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, Form.TSI, Rest.Ansicht, Rest.AnsichtList,
  Form.TSI2, Form.Charts, Rest.Kurs, Rest.KursList, FMX.Layouts, FMX.ListBox,
  Rest.TSI, Rest.TSIList, Form.GuVJahre, Rest.GuVJahre, Rest.GuVJahreList, Objekt.InvestList,
  Objekt.Invest, Rest.DepotnameList, Rest.DepotwerteList;

type
  Tfrm_TSIAnsicht = class(TForm)
    TabControl1: TTabControl;
    tbs_TSI: TTabItem;
    tbs_TSI2: TTabItem;
    tbs_Chart: TTabItem;
    tbs_GuVJahre: TTabItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fFormTSI: Tfrm_TSI;
    fFormTSI2: Tfrm_TSI2;
    fFormGuVJahre: Tfrm_GuVJahre;
    fFormCharts: Tfrm_Charts;
    fRestAnsichtList: TRestAnsichtList;
    fRestGuVJahreList: TRestGuVJahreList;
    fRestKursList: TRestKursList;
    fRestDaxKursList: TRestKursList;
    fRestTSIList: TRestTSIList;
    fInvestList: TInvestList;
    fRestDepotnameList: TRestDepotnameList;
    fRestDepotwerteList: TRestDepotwerteList;
    function getRestAnsicht(aWKN: String): TRestAnsicht;
    procedure LadeDepotwerteList;
    procedure LadeDepotnameliste(Sender: TObject);
    procedure LadeAnsichtList;
    procedure LadeKursList(aAkId: Integer);
    procedure LadeTSIKursList(aAkId: Integer);
    procedure TSIGridDblClick(AkId: Integer);
    procedure LadeGuVJahreList;
    procedure LadeInvestList;
  public
  end;

var
  frm_TSIAnsicht: Tfrm_TSIAnsicht;

implementation

{$R *.fmx}

uses
  ClientModul.Classes, ClientModul.Module;

procedure Tfrm_TSIAnsicht.FormCreate(Sender: TObject);
begin//
  fFormTSI := Tfrm_TSI.Create(Self);
  fFormTSI.OnGridDblClick := TSIGridDblClick;
  while fFormTSI.ChildrenCount>0 do
    fFormTSI.Children[0].Parent := tbs_TSI;

  fFormTSI2 := Tfrm_TSI2.Create(Self);
  fFormTSI2.OnGridDblClick := TSIGridDblClick;
  while fFormTSI2.ChildrenCount>0 do
    fFormTSI2.Children[0].Parent := tbs_TSI2;


  fFormCharts := Tfrm_Charts.Create(Self);
  while fFormCharts.ChildrenCount>0 do
    fFormCharts.Children[0].Parent := tbs_Chart;

  fFormGuVJahre := Tfrm_GuVJahre.Create(Self);
  while fFormGuVJahre.ChildrenCount>0 do
    fFormGuVJahre.Children[0].Parent := tbs_GuVJahre;
  fFormGuVJahre.OnGridDblClick := TSIGridDblClick;


  fRestAnsichtList := TRestAnsichtList.Create;
  fRestKursList    := TRestKursList.Create;
  fRestTSIList     := TRestTSIList.Create;
  fRestDaxKursList := TRestKursList.Create;
  fRestGuVJahreList:= TRestGuVJahreList.Create;
  fInvestList      := TInvestList.Create;
  fRestDepotnameList  := TRestDepotnameList.Create;
  fRestDepotwerteList := TRestDepotwerteList.Create;



  Width := 1075;

end;

procedure Tfrm_TSIAnsicht.FormDestroy(Sender: TObject);
begin//
  FreeAndNil(fRestAnsichtList);
  FreeAndNil(fRestKursList);
  FreeAndNil(fRestTSIList);
  FreeAndNil(fRestDaxKursList);
  FreeAndNil(fRestGuVJahreList);
  FreeAndNil(fInvestList);
  FreeAndNil(fRestDepotnameList);
  FreeAndNil(fRestDepotwerteList);
end;


procedure Tfrm_TSIAnsicht.FormResize(Sender: TObject);
begin
  //caption := IntToStr(Self.Width);
end;

procedure Tfrm_TSIAnsicht.FormShow(Sender: TObject);
begin
  LadeAnsichtList;
  LadeKursList(142);
  LadeGuVJahreList;
  LadeDepotnameliste(nil);
  LadeDepotwerteList;
  fRestDaxKursList.LoadFromStream(fRestKursList.getStream);
  fFormTSI.setAnsichtList(fRestAnsichtList);
  fFormTSI2.setAnsichtList(fRestAnsichtList);
  fFormTSI2.setDepotnameList(fRestDepotnameList);
  fFormTSI2.setDepotwerteList(fRestDepotwerteList);
  fFormCharts.setAnsichtList(fRestAnsichtList);
  fFormCharts.setDaxKursList(fRestDaxKursList);
  fFormGuvJahre.setAnsichtList(fRestAnsichtList);
  fFormGuvJahre.setGuVJahreList(fRestGuVJahreList);
  fFormGuvJahre.setDepotnameList(fRestDepotnameList);
  fFormGuvJahre.setDepotwerteList(fRestDepotwerteList);
  LadeInvestList;
end;

procedure Tfrm_TSIAnsicht.TSIGridDblClick(AkId: Integer);
begin
  //ShowMessage(IntToStr(AkId));
  LadeKursList(AkId);
  LadeTSIKursList(AKId);
  fFormCharts.setKursList(fRestKursList);
  fFormCharts.setTSIKursList(fRestTSIList);
  fFormCharts.ShowChart(AkId);
  TabControl1.ActiveTab := tbs_Chart;
end;

procedure Tfrm_TSIAnsicht.LadeAnsichtList;
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
  RestAnsicht: TRestAnsicht;
  i1: Integer;
  List: TStringList;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule2.DSRestConnection1);
  Stream := Temp.Ansicht;
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestAnsichtList.LoadFromStream(MemStream);
  RestAnsicht := fRestAnsichtList.Item[0];
  List := TStringList.Create;
  for i1 := 0 to RestAnsicht.FeldList.Count -1 do
  begin
    List.Add(RestAnsicht.FeldList.Feld[i1].Feldname);
  end;
  List.SaveToFile('c:\temp\feldlist.txt');
  FreeAndNil(List);
  //Button1.Text := fRezeptList.Item[0].FieldByName('Rezeptname').AsString;
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;

procedure Tfrm_TSIAnsicht.LadeKursList(aAkId: Integer);
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
  List: TStringList;
  Kurs: TRestKurs;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule2.DSRestConnection1);
  Stream := Temp.Kurs(aAkId);
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestKursList.LoadFromStream(MemStream);
  Kurs := fRestKursList.Item[fRestKursList.Count-1];
  List := TStringList.Create;
  List.Add('KU_ID: ' + Kurs.FieldByName('ID').AsString);
  List.Add('KU_AK_ID: ' + Kurs.FieldByName('KU_AK_ID').AsString);
  List.Add('KU_DATUM: ' + Kurs.FieldByName('KU_DATUM').AsString);
  List.Add('KU_KURS: ' + Kurs.FieldByName('KU_KURS').AsString);
  FreeAndNil(List);
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;



procedure Tfrm_TSIAnsicht.LadeTSIKursList(aAkId: Integer);
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule2.DSRestConnection1);
  Stream := Temp.TSIWochen(aAkId, 27);
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestTSIList.LoadFromStream(MemStream);
  //Kurs := fRestTSIList.Item[fRestTSIList.Count-1];
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;


procedure Tfrm_TSIAnsicht.LadeGuVJahreList;
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule2.DSRestConnection1);
  Stream := Temp.GuVJahre;
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestGuVJahreList.LoadFromStream(MemStream);
  //Button1.Text := fRezeptList.Item[0].FieldByName('Rezeptname').AsString;
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;

procedure Tfrm_TSIAnsicht.LadeInvestList;
var
  i1: Integer;
  Invest: TInvest;
  RestAnsicht: TRestAnsicht;
  Proz: real;
  Diff: real;
begin
  fInvestList.Clear;
  for i1 := 0 to fRestGuVJahreList.Count -1 do
  begin
    Invest := fInvestList.Add;
    Invest.WKN          := fRestGuVJahreList.Item[i1].FieldByName('AK_WKN').AsString;
    Invest.Aktie        := fRestGuVJahreList.Item[i1].FieldByName('AK_AKTIE').AsString;
    Invest.Durchschnitt := fRestGuVJahreList.Item[i1].FieldByName('GJ_DURCHSCHNITT').AsFloat;
    Invest.ProzLaufendesJahr := fRestGuVJahreList.Item[i1].FieldByName('GJ_PROZENT6').AsFloat;
    RestAnsicht := getRestAnsicht(fRestGuVJahreList.Item[i1].FieldByName('AK_WKN').AsString);
    if RestAnsicht <> nil then
    begin
      Invest.Proz365Tage := RestAnsicht.Runden(RestAnsicht.FieldByName('AP_WERT365').AsFloat, 2);
      Invest.TSI27       := RestAnsicht.Runden(RestAnsicht.FieldByName('TL_WERT27').AsFloat, 2);
    end;
    Invest.ProzDurchschnitt := RestAnsicht.Runden((Invest.ProzLaufendesJahr + Invest.Proz365Tage) / 2, 2);

    if Invest.Durchschnitt = Invest.ProzDurchschnitt then
      Invest.ProzDiff := 0;

    if Invest.Durchschnitt > Invest.ProzDurchschnitt then
    begin
      Proz := Invest.Durchschnitt * 100 / Invest.ProzDurchschnitt;
      Invest.ProzDiff := RestAnsicht.Runden(Proz, 2) - 100;
    end;

    if Invest.Durchschnitt < Invest.ProzDurchschnitt then
    begin
      Diff := Invest.ProzDurchschnitt -  Invest.Durchschnitt;
      Proz := Diff * 100 / Invest.ProzDurchschnitt;
      Invest.ProzDiff := RestAnsicht.Runden(Proz, 2) * -1;
      //Proz := Invest.ProzDurchschnitt * 100 / Invest.Durchschnitt;
      //Invest.ProzDiff := 100 - RestAnsicht.Runden(Proz, 2);
      //Invest.ProzDiff := Invest.ProzDiff *-1;
    end;

  end;


  for i1 := fInvestList.Count -1 downto 0 do
  begin
    if fInvestList.Item[i1].TSI27 < 1 then
      fInvestList.Delete(i1);
  end;

  fInvestList.SortProzDiff;

end;

function Tfrm_TSIAnsicht.getRestAnsicht(aWKN: String): TRestAnsicht;
var
  i1: Integer;
begin
  Result := nil;
  for i1 := 0 to fRestAnsichtList.Count -1 do
  begin
    if SameText(fRestAnsichtList.Item[i1].FieldByName('AK_WKN').AsString, aWKN) then
    begin
      Result := TRestAnsicht(fRestAnsichtList.Item[i1]);
      exit;
    end;
  end;
end;


procedure Tfrm_TSIAnsicht.LadeDepotnameliste(Sender: TObject);
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule2.DSRestConnection1);
  Stream := Temp.DepotnameList;
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestDepotnameList.LoadFromStream(MemStream);
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;

procedure Tfrm_TSIAnsicht.LadeDepotwerteList;
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule2.DSRestConnection1);
  Stream := Temp.Depotwerte;
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRestDepotwerteList.LoadFromStream(MemStream);
  //Kurs := fRestTSIList.Item[fRestTSIList.Count-1];
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;

end.
