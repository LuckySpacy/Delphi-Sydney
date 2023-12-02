unit Form.TSIDepot;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, dm.Style,
  Rest.BenutzerList, Rest.Benutzer, ClientModule.Module, ClientModul.Classes,
  Rest.DepotnameList, Rest.Depotwerte, Rest.DepotwerteList, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, Rest.AnsichtList, Rest.Ansicht,
  Objekt.GridAktieList, Objekt.GridAktie, FMX.Edit, FMX.Objects;


type
  RCol = Record
    const WKN: Integer = 0;
    const Aktie: Integer = 1;
    const Depot: Integer = 2;
    const count: Integer = 3;
  End;

type
  TShowDepotnameEvent=procedure(aBeId, aDbId: Integer; aDepotname: string) of object;
  Tfrm_TSIDepot = class(TForm)
    rec_Background: TRectangle;
    lay_Grid: TLayout;
    grd: TStringGrid;
    Col_WKN: TStringColumn;
    Col_Aktie: TStringColumn;
    Col_Depot: TCheckColumn;
    Lay_Depot: TLayout;
    lbl_Depot: TLabel;
    cbx_Depot: TComboBox;
    lay_DepotButtons: TLayout;
    btn_ChangeDepot: TSpeedButton;
    btn_DepotAdd: TSpeedButton;
    btn_DepotDel: TSpeedButton;
    lay_Benutzer: TLayout;
    lbl_Benutzer: TLabel;
    cbx_Benutzer: TComboBox;
    lay_Aktie: TLayout;
    edt_Aktie: TEdit;
    lbl_Aktie: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbx_DepotChange(Sender: TObject);
    procedure edt_AktieKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btn_DepotAddClick(Sender: TObject);
    procedure btn_ChangeDepotClick(Sender: TObject);
    procedure btn_DepotDelClick(Sender: TObject);
  private
    fOnShowDepotname: TShowDepotnameEvent;
    fOnRefreshDepotnameList: TNotifyEvent;
    fRestDepotnameList: TRestDepotnameList;
    fDepotwerteList: TRestDepotwerteList;
    fRestAnsichtList: TRestAnsichtList;
    fGridAktieList: TGridAktieList;
    fDpId: Integer;
    fCol: RCol;
    procedure AktualGridAktieList(aAktie: string);
    procedure AktualGrid;
    procedure AktualDepotnameCombobox(aDPId: Integer);
    procedure LadeDepotwerteList;
  public
    procedure setBenutzerliste(aBenutzerliste: TRestBenutzerList);
    procedure setDepotnameliste(aDepotnameliste: TRestDepotnameList);
    procedure setAnsichtList(aAnsichtList: TRestAnsichtList);
    property OnShowDepotname: TShowDepotnameEvent read fOnShowDepotname write fOnShowDepotname;
    property OnRefreshDepotnameList: TNotifyEvent read fOnRefreshDepotnameList write fOnRefreshDepotnameList;
  end;

var
  frm_TSIDepot: Tfrm_TSIDepot;

implementation

{$R *.fmx}

procedure Tfrm_TSIDepot.FormCreate(Sender: TObject);
begin
  fDepotwerteList := TRestDepotwerteList.Create;
  fGridAktieList  := TGridAktieList.Create;
  fDpId := 0;
end;

procedure Tfrm_TSIDepot.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDepotwerteList);
  FreeAndNil(fGridAktieList);
end;



//***************************************************************************
// Übergabe
//***************************************************************************
procedure Tfrm_TSIDepot.setAnsichtList(aAnsichtList: TRestAnsichtList);
begin
  fRestAnsichtList := aAnsichtList;
  fRestAnsichtList.StringSort('AK_AKTIE', true);
  AktualGridAktieList('');
end;

procedure Tfrm_TSIDepot.setBenutzerliste(aBenutzerliste: TRestBenutzerList);
var
  i1: Integer;
begin
  cbx_Benutzer.Clear;
  for i1 := 0 to aBenutzerliste.Count -1 do
  begin
    cbx_Benutzer.Items.AddObject(aBenutzerliste.Item[i1].FieldByName('be_Vorname').AsString + ' ' +
      aBenutzerliste.Item[i1].FieldByName('be_Nachname').AsString, TObject(aBenutzerliste.Item[i1].FieldByName('id').AsInteger));
  end;
  if cbx_Benutzer.Count > 0 then
    cbx_Benutzer.ItemIndex := 0;
end;

procedure Tfrm_TSIDepot.setDepotnameliste(aDepotnameliste: TRestDepotnameList);
begin
  fRestDepotnameList := aDepotnameliste;
  AktualDepotnameCombobox(0);
end;


//***************************************************************************
// Proceduren
//***************************************************************************

procedure Tfrm_TSIDepot.AktualGridAktieList(aAktie: string);
var
  i1: Integer;
  GridAktie: TGridAktie;
  Gefunden: Boolean;
  DpId: Integer;
  s: string;
begin
  if fRestAnsichtList = nil then
    exit;
  DpId := 0;
  if cbx_Depot.Count > 0 then
    DpId := Integer(cbx_Depot.Items.Objects[cbx_Depot.ItemIndex]);
  fGridAktieList.clear;
  for i1 := 0 to fRestAnsichtList.Count -1 do
  begin
    Gefunden := Trim(aAktie) = '';
    if Trim(aAktie) > '' then
    begin
      s := copy(fRestAnsichtList.Item[i1].FieldByName('AK_AKTIE').AsString, 1, Length(aAktie));
      Gefunden := SameText(s, aAktie);
    end;
    if Gefunden then
    begin
      GridAktie := fGridAktieList.Add;
      GridAktie.WKN   := fRestAnsichtList.Item[i1].FieldByName('AK_WKN').AsString;
      GridAktie.Aktie := fRestAnsichtList.Item[i1].FieldByName('AK_AKTIE').AsString;
      GridAktie.AkId  := fRestAnsichtList.Item[i1].FieldByName('AK_ID').AsInteger;
      GridAktie.Depot := fDepotwerteList.AktieInDepot(GridAktie.AkId, DpId);
    end;
  end;
  AktualGrid;
end;







procedure Tfrm_TSIDepot.AktualGrid;
var
  i1 : Integer;
begin

  grd.BeginUpdate;
  grd.Columns[fCol.WKN].Header := 'WKN';
  grd.Columns[fCol.Aktie].Header := 'Aktie';
  grd.Columns[fCol.Depot].Header := 'Depot';
  grd.RowCount := fGridAktieList.Count + 1;
  for i1 := 0 to fGridAktieList.Count -1 do
  begin
    grd.Cells[fCol.WKN, i1]   := fGridAktieList.Item[i1].WKN;
    grd.Cells[fCol.Aktie, i1]  := fGridAktieList.Item[i1].Aktie;
    grd.Cells[fCol.Depot , i1] := BoolToStr(fGridAktieList.Item[i1].Depot, true);
  end;

  grd.EndUpdate;
end;

procedure Tfrm_TSIDepot.AktualDepotnameCombobox(aDPId: Integer);
var
  i1: Integer;
  ItemIndex: Integer;
  BeId: Integer;
begin
  ItemIndex := -1;
  cbx_Depot.Clear;
  if cbx_Benutzer.ItemIndex < 0 then
    exit;
  BeId := Integer(cbx_Benutzer.Items.Objects[cbx_Benutzer.ItemIndex]);
  for i1 := 0 to fRestDepotnameList.Count -1 do
  begin
    if fRestDepotnameList.Item[i1].FieldByName('dp_be_id').AsInteger <> BeId then
      continue;
    if aDPId = fRestDepotnameList.Item[i1].FieldByName('id').AsInteger then
      ItemIndex := i1;
    cbx_Depot.Items.AddObject(fRestDepotnameList.Item[i1].FieldByName('dp_name').AsString, TObject(fRestDepotnameList.Item[i1].FieldByName('id').AsInteger));
  end;
  if cbx_Depot.Count > 0 then
    cbx_Depot.ItemIndex := 0;
  if ItemIndex > -1 then
    cbx_Depot.ItemIndex := ItemIndex;
end;


procedure Tfrm_TSIDepot.LadeDepotwerteList;
var
  Temp: TServerMethods1Client;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TServerMethods1Client.Create(ClientModule1.DSRestConnection1);
  Stream := Temp.Depotwerte;
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fDepotwerteList.LoadFromStream(MemStream);
  //Kurs := fRestTSIList.Item[fRestTSIList.Count-1];
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;




//***************************************************************************
// Combobox Events
//***************************************************************************

procedure Tfrm_TSIDepot.cbx_DepotChange(Sender: TObject);
begin
  LadeDepotwerteList;
  AktualGridAktieList(edt_Aktie.Text);
end;



//***************************************************************************
// Edit Events
//***************************************************************************

procedure Tfrm_TSIDepot.edt_AktieKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  AktualGridAktieList(edt_Aktie.Text);
end;



//***************************************************************************
// Button Events
//***************************************************************************

procedure Tfrm_TSIDepot.btn_ChangeDepotClick(Sender: TObject);
var
  BeId: Integer;
begin
  if cbx_Depot.Count = 0 then
    exit;
  if cbx_Benutzer.ItemIndex < 0 then
    exit;
  BeId := Integer(cbx_Benutzer.Items.Objects[cbx_Benutzer.ItemIndex]);
  if Assigned(fOnShowDepotname) then
  begin
    fOnShowDepotname(BeId, Integer(cbx_Depot.Items.Objects[cbx_Depot.ItemIndex]), cbx_Depot.Selected.Text);
  end;
end;


procedure Tfrm_TSIDepot.btn_DepotAddClick(Sender: TObject);
var
  BeId: Integer;
begin
  if cbx_Benutzer.ItemIndex < 0 then
    exit;
  BeId := Integer(cbx_Benutzer.Items.Objects[cbx_Benutzer.ItemIndex]);
  if Assigned(fOnShowDepotname) then
  begin
    fOnShowDepotname(BeId, 0, '');
  end;
end;

procedure Tfrm_TSIDepot.btn_DepotDelClick(Sender: TObject);
var
  Temp: TServerMethods1Client;
begin
  if cbx_Depot.Count = 0 then
    exit;
  Temp := TServerMethods1Client.Create(ClientModule1.DSRestConnection1);
  try
    Temp.DeleteDepotname(Integer(cbx_Depot.Items.Objects[cbx_Depot.ItemIndex]));
    if Assigned(fOnRefreshDepotnameList) then
    begin
      fOnRefreshDepotnameList(nil);
      AktualDepotnameCombobox(0);
    end;
  finally
    FreeAndNil(Temp);
  end;
end;

end.
