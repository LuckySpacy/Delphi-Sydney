unit Form.TSI2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.StdCtrls,
  FMX.Controls.Presentation,  Rest.Ansicht, Rest.AnsichtList, FMX.Edit,
  FMX.ListBox, Rest.DepotnameList, Rest.DepotwerteList;

type
  TGridDblClickEvent = procedure(AkId: Integer) of object;
  RSortDirection = Record
    Aktie: Boolean;
    Tage_365: Boolean;
  end;

type
  RCol = Record
    const WKN: Integer = 0;
    const Aktie: Integer = 1;
    const LetzterKurs: Integer = 2;
    const TSI27: Integer = 3;
    const TSI12: Integer = 4;
    const Tage7: Integer = 5;
    const Tage14: Integer = 6;
    const Tage30: Integer = 7;
    const Tage90: Integer = 8;
    const Tage180: Integer = 9;
    const Tage365: Integer = 10;
    const Tag1: Integer = 11;
    const KGV: Integer = 12;
    const count: Integer = 13;
  End;

type
  Tfrm_TSI2 = class(TForm)
    Panel1: TPanel;
    cbx_DebotwerteFirst: TCheckBox;
    cbx_HochKursNachOben: TCheckBox;
    grd: TGrid;
    Col_WKN: TColumn;
    Col_Aktie: TColumn;
    Col_LetzterKurs: TColumn;
    Col_TSI27: TColumn;
    Col_TSI12: TColumn;
    Col_7Tage: TColumn;
    Col_14Tage: TColumn;
    Col_30Tage: TColumn;
    Col_90Tage: TColumn;
    Col_180Tage: TColumn;
    Col_365: TColumn;
    Col_1Tag: TColumn;
    lbl_Aktie: TLabel;
    edt_Aktie: TEdit;
    Label1: TLabel;
    cbx_Depot: TComboBox;
    Col_KGV: TColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
    procedure grdGetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure grdHeaderClick(Column: TColumn);
    procedure cbx_DebotwerteFirstClick(Sender: TObject);
    procedure cbx_HochKursNachObenClick(Sender: TObject);
    procedure grdCellDblClick(const Column: TColumn; const Row: Integer);
    procedure grdCellClick(const Column: TColumn; const Row: Integer);
    procedure edt_AktieKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    fCol: RCol;
    fSortDirection: RSortDirection;
    fAnsichtList: TRestAnsichtList;
    fDepotnameList: TRestDepotnameList;
    fDepotwerteList: TRestDepotwerteList;
    fAktieFilter: string;
    fGridList: TRestAnsichtList;
    fOnGridDblClick: TGridDblClickEvent;
    function getDpId: Integer;
    procedure AktualGrid;
    procedure Grid1ApplyStyleLookup(Sender: TObject);
    procedure DepotwerteNachOben;
    procedure DepotwerteHoechstKurseNachOben;
  public
    procedure setAnsichtList(aAnsichtList: TRestAnsichtList);
    procedure setDepotnameList(aDepotnameList: TRestDepotnameList);
    procedure setDepotwerteList(aDepotwerteList: TRestDepotwerteList);
    property OnGridDblClick: TGridDblClickEvent read  fOnGridDblClick write fOnGridDblClick;
  end;

var
  frm_TSI2: Tfrm_TSI2;

implementation

{$R *.fmx}

{ Tfrm_TSI2 }

uses
  ClientModul.Classes, ClientModul.Module, fmx.Header;



procedure Tfrm_TSI2.FormCreate(Sender: TObject);
begin
  fGridList := TRestAnsichtList.Create;
  fAnsichtList := nil;
  grd.OnApplyStyleLookup := Grid1ApplyStyleLookup;
  fSortDirection.Aktie := true;
  fSortDirection.Tage_365 := false;
  fAktieFilter := '';
end;

procedure Tfrm_TSI2.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fGridList);
end;


procedure Tfrm_TSI2.AktualGrid;
var
  i1, i2: Integer;
  NeuRestAnsicht: TRestAnsicht;
  s: string;
begin
  if Trim(fAktieFilter) = '' then
    fAnsichtList.CopyList(fGridList)
  else
  begin
    fGridList.Clear;
    if (fAktieFilter > '') then
    begin
      for i1 := 0 to fAnsichtList.Count -1 do
      begin
        s := copy(fAnsichtList.Item[i1].FieldByName('AK_AKTIE').AsString, 1, Length(fAktieFilter));
        if SameText(s, fAktieFilter) then
        begin
          NeuRestAnsicht := fGridList.Add;
          for i2 := 0 to fAnsichtList.Item[i1].FeldList.Count -1 do
           NeuRestAnsicht.FeldList.Feld[i2].AsString := fAnsichtList.Item[i1].FeldList.Feld[i2].AsString;
        end;
      end;
    end;
  end;
  grd.BeginUpdate;
  grd.RowCount := fGridList.Count;
  grd.EndUpdate;
  //grd.Columns[fCol.WKN].Width := 80;
  //grd.Columns[fCol.Aktie].Width := 300;
  //grd.Columns[fCol.LetzterKurs].Width := 80;
  //grd.Columns[fCol.TSI27].Width := 80;
  //grd.Columns[fCol.TSI12].Width := 80;
end;


procedure Tfrm_TSI2.Grid1ApplyStyleLookup(Sender: TObject);
var
  H: THeader;
  I: THeaderItem;
  A: Integer;
begin
  if grd.FindStyleResource<THeader>('header', H) then
  begin
    H.Height := 30;
    for A := 0 to H.Count -1 do
    begin
      I := THeaderItem(H.Items[A]);
     // I.StyledSettings := [TStyledSetting.FontColor];  was der Style nicht verändern soll
      //I.TextSettings.HorzAlign := TTextAlign.Center;
      I.TextSettings.Font.Family := 'Tw Cen MT';
      i.TextSettings.Font.Size := 25;
    end;
  end;

end;

procedure Tfrm_TSI2.setAnsichtList(aAnsichtList: TRestAnsichtList);
begin
  fAnsichtList := aAnsichtList;
  fAnsichtList.CopyList(fGridList);
  AktualGrid;
end;



procedure Tfrm_TSI2.setDepotnameList(aDepotnameList: TRestDepotnameList);
var
  i1: Integer;
begin
  fDepotnameList := aDepotnameList;
  cbx_Depot.Clear;
  for i1 := 0 to fDepotnameList.Count -1 do
    cbx_Depot.Items.AddObject(fDepotnameList.Item[i1].FieldByName('dp_name').AsString, TObject(fDepotnameList.Item[i1].FieldByName('id').AsInteger));
  if cbx_Depot.Count > 0 then
    cbx_Depot.ItemIndex := 0;
end;

procedure Tfrm_TSI2.setDepotwerteList(aDepotwerteList: TRestDepotwerteList);
begin
  fDepotwerteList := aDepotwerteList;
end;

procedure Tfrm_TSI2.grdDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
  const Column: TColumn; const Bounds: TRectF; const Row: Integer;
  const Value: TValue; const State: TGridDrawStates);
var
  BgBrush: TBrush;
  Ansicht: TRestAnsicht;
  DpId: Integer;
begin
  if fAnsichtList = nil then
    exit;
  DpId := getDpId;
  bgBrush:= TBrush.Create(TBrushKind.Solid, TAlphaColors.White);
  if SameText(Column.Name, 'Col_AKTIE') then
  begin
    if (fGridList.Count >= Row) then
    begin
      Ansicht := fGridList.Item[Row];
      if fDepotwerteList.AktieInDepot(Ansicht.FieldByName('AK_ID').AsInteger, DpId) then
      begin
        bgBrush.Color := TAlphaColors.Skyblue;
        Canvas.FillRect(Bounds, 0, 0, [], 1, bgBrush);
        Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
      end;

      {
      if Ansicht.FieldByName('AK_DEPOT').AsString = 'T' then
      begin
        bgBrush.Color := TAlphaColors.Skyblue;
        Canvas.FillRect(Bounds, 0, 0, [], 1, bgBrush);
        Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
      end;
      }
    end;
  end;

  if SameText(Column.Name, 'Col_TSI27') then
  begin
//    if Ansicht.FieldByName('HT_LETZTERKURS').AsString then
    if (fGridList.Count >= Row) then
    begin
      Ansicht := fGridList.Item[Row];
      if Ansicht.FieldByName('HT_LETZTERKURS').AsFloat >= Ansicht.FieldByName('HT_HOCH_JAHRKURS').AsFloat then
      begin
        bgBrush.Color := TAlphaColors.Yellow;
        Canvas.FillRect(Bounds, 0, 0, [], 1, bgBrush);
        Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
      end;
    end;
  end;

  if SameText(Column.Name, 'Col_1Tag') then
  begin
//    if Ansicht.FieldByName('HT_LETZTERKURS').AsString then
    if (fGridList.Count >= Row) then
    begin
      Ansicht := fGridList.Item[Row];
      if Ansicht.FieldByName('AP_WERT1').AsFloat >= 10 then
      begin
        bgBrush.Color := TAlphaColors.Yellow;
        Canvas.FillRect(Bounds, 0, 0, [], 1, bgBrush);
        Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
      end;
      if Ansicht.FieldByName('AP_WERT1').AsFloat <= -10 then
      begin
        bgBrush.Color := TAlphaColors.Red;
        Canvas.FillRect(Bounds, 0, 0, [], 1, bgBrush);
        Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
      end;

    end;




  end;


  FreeAndNil(bgBrush);
end;


procedure Tfrm_TSI2.grdGetValue(Sender: TObject; const ACol, ARow: Integer;
  var Value: TValue);
var
  Ansicht: TRestAnsicht;
  s: string;
begin
  if fAnsichtList = nil then
    exit;
  if ARow > fGridList.Count -1 then
    exit;
  Ansicht := fGridList.Item[ARow];
  if fCol.WKN = aCol then
    Value := Ansicht.FieldByName('AK_WKN').AsString;
  if fCol.Aktie = aCol then
    Value := Ansicht.FieldByName('AK_AKTIE').AsString;
  if fCol.LetzterKurs = aCol then
    Value := Ansicht.FieldByName('TL_DATUM27').AsString;
  if fCol.TSI27 = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('TL_WERT27').AsFloat, 2);
  if fCol.TSI12 = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('TL_WERT12').AsFloat, 2);
  if fCol.Tage7 = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('AP_WERT7').AsFloat, 2);
  if fCol.Tage14 = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('AP_WERT14').AsFloat, 2);
  if fCol.Tage30 = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('AP_WERT30').AsFloat, 2);
  if fCol.Tage90 = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('AP_WERT90').AsFloat, 2);
  if fCol.Tage180 = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('AP_WERT180').AsFloat, 2);
  if fCol.Tage365 = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('AP_WERT365').AsFloat, 2);
  if fCol.Tag1 = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('AP_WERT1').AsFloat, 2);
  if fCol.KGV = aCol then
  begin
    Value := Ansicht.Runden(Ansicht.FieldByName('HT_KGV').AsFloat, 2);
    {
    if Value.AsString = '9999999999' then
      Value := 'Kein Wert';
    if Value.AsString = '9999999998' then
      Value := 'Negativ';
      }
  end;
end;

procedure Tfrm_TSI2.grdHeaderClick(Column: TColumn);
begin
  if SameText(Column.Name, 'Col_WKN') then
  begin
    fGridList.StringSort('AK_WKN', fSortDirection.Aktie);
    fAnsichtList.StringSort('AK_WKN', fSortDirection.Aktie);
    fSortDirection.Aktie := not fSortDirection.Aktie;
  end;
  if SameText(Column.Name, 'Col_Aktie') then
  begin
    fGridList.StringSort('AK_AKTIE', fSortDirection.Aktie);
    fAnsichtList.StringSort('AK_AKTIE', fSortDirection.Aktie);
    fSortDirection.Aktie := not fSortDirection.Aktie;
  end;
  if SameText(Column.Name, 'Col_365') then
  begin
    fGridList.FloatSort('AP_WERT365', fSortDirection.Tage_365);
    fAnsichtList.FloatSort('AP_WERT365', fSortDirection.Tage_365);
    fSortDirection.Tage_365 := not fSortDirection.Tage_365;
  end;
  if SameText(Column.Name, 'Col_7Tage') then
  begin
    fGridList.FloatSort('AP_WERT7', fSortDirection.Tage_365);
    fAnsichtList.FloatSort('AP_WERT7', fSortDirection.Tage_365);
    fSortDirection.Tage_365 := not fSortDirection.Tage_365;
  end;
  if SameText(Column.Name, 'Col_14Tage') then
  begin
    fGridList.FloatSort('AP_WERT14', fSortDirection.Tage_365);
    fAnsichtList.FloatSort('AP_WERT14', fSortDirection.Tage_365);
    fSortDirection.Tage_365 := not fSortDirection.Tage_365;
  end;
  if SameText(Column.Name, 'Col_30Tage') then
  begin
    fGridList.FloatSort('AP_WERT30', fSortDirection.Tage_365);
    fAnsichtList.FloatSort('AP_WERT30', fSortDirection.Tage_365);
    fSortDirection.Tage_365 := not fSortDirection.Tage_365;
  end;
  if SameText(Column.Name, 'Col_90Tage') then
  begin
    fGridList.FloatSort('AP_WERT90', fSortDirection.Tage_365);
    fAnsichtList.FloatSort('AP_WERT90', fSortDirection.Tage_365);
    fSortDirection.Tage_365 := not fSortDirection.Tage_365;
  end;
  if SameText(Column.Name, 'Col_180Tage') then
  begin
    fGridList.FloatSort('AP_WERT180', fSortDirection.Tage_365);
    fAnsichtList.FloatSort('AP_WERT180', fSortDirection.Tage_365);
    fSortDirection.Tage_365 := not fSortDirection.Tage_365;
  end;

  if SameText(Column.Name, 'Col_1Tag') then
  begin
    fGridList.FloatSort('AP_WERT1', fSortDirection.Tage_365);
    fAnsichtList.FloatSort('AP_WERT1', fSortDirection.Tage_365);
    fSortDirection.Tage_365 := not fSortDirection.Tage_365;
  end;


  if SameText(Column.Name, 'Col_TSI27') then
  begin
    fGridList.FloatSort('TL_WERT27', fSortDirection.Tage_365);
    fAnsichtList.FloatSort('TL_WERT27', fSortDirection.Tage_365);
    fSortDirection.Tage_365 := not fSortDirection.Tage_365;
  end;
  if SameText(Column.Name, 'Col_TSI12') then
  begin
    fGridList.FloatSort('TL_WERT12', fSortDirection.Tage_365);
    fAnsichtList.FloatSort('TL_WERT12', fSortDirection.Tage_365);
    fSortDirection.Tage_365 := not fSortDirection.Tage_365;
  end;


  AktualGrid;
end;


procedure Tfrm_TSI2.cbx_DebotwerteFirstClick(Sender: TObject);
begin //
  if cbx_HochKursNachOben.IsChecked then
    DepotwerteHoechstKurseNachOben;
  if not cbx_DebotwerteFirst.IsChecked then
    DepotwerteNachOben;
  AktualGrid;
end;


function Tfrm_TSI2.getDpId: Integer;
begin
  Result := 0;
  if cbx_Depot.Count > 0 then
    Result := Integer(cbx_Depot.Items.Objects[cbx_Depot.ItemIndex]);
end;

procedure Tfrm_TSI2.cbx_HochKursNachObenClick(Sender: TObject);
begin
  if not cbx_HochKursNachOben.IsChecked then
    DepotwerteHoechstKurseNachOben;
  if cbx_DebotwerteFirst.IsChecked then
    DepotwerteNachOben;
  AktualGrid;
end;

procedure Tfrm_TSI2.DepotwerteNachOben;
var
  i1: Integer;
  NewPos: Integer;
  Ansicht: TRestAnsicht;
  DpId: Integer;
begin

  DpId := getDpId;
  NewPos := 0;
  for i1 := 0 to fAnsichtList.Count -1 do
  begin
    Ansicht := fAnsichtList.Item[i1];
    //if Ansicht.FieldByName('AK_DEPOT').AsString = 'T' then
    if fDepotwerteList.AktieInDepot(Ansicht.FieldByName('AK_ID').AsInteger, DpId) then
    begin
      fAnsichtList.MoveItem(i1, NewPos);
      inc(NewPos);
    end;
  end;

  for i1 := 0 to fAnsichtList.Count -1 do
  begin
    Ansicht := fGridList.Item[i1];
    if Ansicht.FieldByName('AK_AKTIE').AsString = 'DAX' then
    begin
      fAnsichtList.MoveItem(i1, 0);
      break;
    end;
  end;


{
  NewPos := 0;
  for i1 := 0 to fGridList.Count -1 do
  begin
    Ansicht := fGridList.Item[i1];
    if Ansicht.FieldByName('AK_DEPOT').AsString = 'T' then
    begin
      fGridList.MoveItem(i1, NewPos);
      inc(NewPos);
    end;
  end;

  for i1 := 0 to fGridList.Count -1 do
  begin
    Ansicht := fGridList.Item[i1];
    if Ansicht.FieldByName('AK_AKTIE').AsString = 'DAX' then
    begin
      fGridList.MoveItem(i1, 0);
      break;
    end;
  end;
}
  AktualGrid;


end;

procedure Tfrm_TSI2.edt_AktieKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  fAktieFilter := Trim(edt_Aktie.Text);
  AktualGrid;
end;

procedure Tfrm_TSI2.DepotwerteHoechstKurseNachOben;
var
  i1: Integer;
  NewPos: Integer;
  Ansicht: TRestAnsicht;
begin
  NewPos := 0;
  for i1 := 0 to fGridList.Count -1 do
  begin
    Ansicht := fGridList.Item[i1];
    if Ansicht.FieldByName('HT_LETZTERKURS').AsFloat >= Ansicht.FieldByName('HT_HOCH_JAHRKURS').AsFloat then
    begin
      fGridList.MoveItem(i1, NewPos);
      inc(NewPos);
    end;
  end;

  NewPos := 0;
  for i1 := 0 to fAnsichtList.Count -1 do
  begin
    Ansicht := fAnsichtList.Item[i1];
    if Ansicht.FieldByName('HT_LETZTERKURS').AsFloat >= Ansicht.FieldByName('HT_HOCH_JAHRKURS').AsFloat then
    begin
      fAnsichtList.MoveItem(i1, NewPos);
      inc(NewPos);
    end;
  end;
end;


procedure Tfrm_TSI2.grdCellClick(const Column: TColumn; const Row: Integer);
begin
  if SameText(Column.Name, 'Col_WKN') then
    grdCellDblClick(Column, Row);
end;

procedure Tfrm_TSI2.grdCellDblClick(const Column: TColumn; const Row: Integer);
var
  Ansicht: TRestAnsicht;
begin
  Ansicht := fGridList.Item[Row];
  if Ansicht = nil then
    exit;
  if Assigned(fOnGridDblClick) then
    fOnGridDblClick(Ansicht.FieldByName('AK_ID').AsInteger);
end;




end.
