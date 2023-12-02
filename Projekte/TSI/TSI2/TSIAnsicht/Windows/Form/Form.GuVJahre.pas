unit Form.GuVJahre;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.StdCtrls,
  FMX.Controls.Presentation, Rest.GuVJahre, Rest.GuVJahreList, FMX.Header,
  FMX.TextLayout, Rest.Ansicht, Rest.AnsichtList, FMX.Edit, FMX.Menus, Objekt.Rechenweg,
  FMX.ListBox, Rest.DepotnameList, Rest.DepotwerteList;

type
  RCol = Record
    const WKN: Integer = 0;
    const Aktie: Integer = 1;
    const Prozent1: Integer = 2;
    const Prozent2: Integer = 3;
    const Prozent3: Integer = 4;
    const Prozent4: Integer = 5;
    const Prozent5: Integer = 6;
    const Prozent6: Integer = 7;
    const Col365Tage: Integer = 8;
    const Durchschnitt: Integer = 9;
    const TSI27: Integer = 10;
    const ProzAbw: Integer = 11;
    const count: Integer = 12;
  End;

type
  TGridDblClickEvent = procedure(AkId: Integer) of object;
  Tfrm_GuVJahre = class(TForm)
    Panel1: TPanel;
    cbx_DebotwerteFirst: TCheckBox;
    cbx_HochKursNachOben: TCheckBox;
    grd: TGrid;
    Col_WKN: TColumn;
    Col_Aktie: TColumn;
    Col_Prozent1: TColumn;
    Col_Prozent2: TColumn;
    Col_Prozent3: TColumn;
    Col_Prozent4: TColumn;
    Col_Prozent5: TColumn;
    Col_Prozent6: TColumn;
    Col_Durchschnitt: TColumn;
    Col_365Tage: TColumn;
    Col_TSI27: TColumn;
    Col_AbwProz: TColumn;
    edt_Aktie: TEdit;
    lbl_Aktie: TLabel;
    pop: TPopupMenu;
    men_365Tage: TMenuItem;
    Label1: TLabel;
    cbx_Depot: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdGetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure grdDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
    procedure grdDrawColumnHeader(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF);
    procedure grdHeaderClick(Column: TColumn);
    procedure grdCellClick(const Column: TColumn; const Row: Integer);
    procedure grdCellDblClick(const Column: TColumn; const Row: Integer);
    procedure cbx_DebotwerteFirstClick(Sender: TObject);
    procedure edt_AktieKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure men_365TageClick(Sender: TObject);
  private
    fCol: RCol;
    fGridList:TRestGuVJahreList;
    fGuVJahreList: TRestGuVJahreList;
    fAnsichtList: TRestAnsichtList;
    fRestAnsicht: TRestAnsicht;
    fSortDirection: Boolean;
    fOnGridDblClick: TGridDblClickEvent;
    fRechenweg: TRechenweg;
    fAktieFilter: string;
    fDepotnameList: TRestDepotnameList;
    fDepotwerteList: TRestDepotwerteList;
    procedure Grid1ApplyStyleLookup(Sender: TObject);
    procedure AktualGrid;
    procedure DepotwerteNachOben;
    function getDpId: Integer;
    //function getAnsichtRow(aWKN: string): TRestAnsicht;
  public
    procedure setGuVJahreList(aGuVJahreList: TRestGuVJahreList);
    procedure setAnsichtList(aAnsichtList: TRestAnsichtList);
    property OnGridDblClick: TGridDblClickEvent read  fOnGridDblClick write fOnGridDblClick;
    procedure setDepotnameList(aDepotnameList: TRestDepotnameList);
    procedure setDepotwerteList(aDepotwerteList: TRestDepotwerteList);
  end;

var
  frm_GuVJahre: Tfrm_GuVJahre;

implementation

{$R *.fmx}


procedure Tfrm_GuVJahre.FormCreate(Sender: TObject);
begin  //
  fSortDirection := false;
  fGridList := TRestGuVJahreList.Create;
  fGuVJahreList := nil;
  fAnsichtList := nil;
  fRestAnsicht := nil;
  fAktieFilter := '';
  grd.OnApplyStyleLookup := Grid1ApplyStyleLookup;
  fRechenweg := TRechenweg.Create;
end;

procedure Tfrm_GuVJahre.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fRechenweg);
  FreeAndNil(fGridList);
end;



procedure Tfrm_GuVJahre.grdDrawColumnCell(Sender: TObject;
  const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF;
  const Row: Integer; const Value: TValue; const State: TGridDrawStates);
var
  GuVJahre: TRestGuVJahre;
  BgBrush: TBrush;
  DpId: Integer;
begin
  DpId := getDpId;
  bgBrush:= TBrush.Create(TBrushKind.Solid, TAlphaColors.White);
  if SameText(Column.Name, 'Col_AKTIE') then
  begin
    if (fGridList.Count >= Row) then
    begin
      GuVJahre := fGridList.Item[Row];
      //if GuVJahre.FieldByName('AK_DEPOT').AsString = 'T' then
      if fDepotwerteList.AktieInDepot(GuVJahre.FieldByName('AK_ID').AsInteger, DpId) then
      begin
        bgBrush.Color := TAlphaColors.Skyblue;
        Canvas.FillRect(Bounds, 0, 0, [], 1, bgBrush);
        Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
      end;
    end;
  end;

  FreeAndNil(bgBrush);


end;

function Tfrm_GuVJahre.getDpId: Integer;
begin
  Result := 0;
  if cbx_Depot.Count > 0 then
    Result := Integer(cbx_Depot.Items.Objects[cbx_Depot.ItemIndex]);
end;


procedure Tfrm_GuVJahre.grdDrawColumnHeader(Sender: TObject;
  const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF);
var
  GuVJahre: TRestGuVJahre;
begin
  if fGuVJahreList = nil then
    exit;
  GuVJahre := fGridList.Item[0];
  if GuVJahre = nil then
    exit;
  if SameText('col_Prozent1', Column.Name) then
    Column.Header := GuVJahre.FieldByName('GJ_JAHR1').AsString;
  if SameText('col_Prozent2', Column.Name) then
    Column.Header := GuVJahre.FieldByName('GJ_JAHR2').AsString;
  if SameText('col_Prozent3', Column.Name) then
    Column.Header := GuVJahre.FieldByName('GJ_JAHR3').AsString;
  if SameText('col_Prozent4', Column.Name) then
    Column.Header := GuVJahre.FieldByName('GJ_JAHR4').AsString;
  if SameText('col_Prozent5', Column.Name) then
    Column.Header := GuVJahre.FieldByName('GJ_JAHR5').AsString;
  if SameText('col_Prozent6', Column.Name) then
    Column.Header := GuVJahre.FieldByName('GJ_JAHR6').AsString;
end;

procedure Tfrm_GuVJahre.grdGetValue(Sender: TObject; const ACol, ARow: Integer;
  var Value: TValue);
var
  GuVJahre: TRestGuVJahre;
begin
 // Log.d('Start --> grdGetValue (' + IntToStr(ACol) + ' / ' + IntToStr(ARow));
  try
    if fGuVJahreList = nil then
      exit;
    if ARow > fGridList.Count then
      exit;
    if fGridList.Count = 0 then
      exit;
    GuVJahre := fGridList.Item[ARow];
    if GuVJahre = nil then
      exit;
    if fCol.WKN = aCol then
    begin
      Value := GuVJahre.FieldByName('AK_WKN').AsString;
    end;
    if fCol.Aktie = aCol then
      Value := GuVJahre.FieldByName('AK_AKTIE').AsString;
    if fCol.Prozent1 = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_PROZENT1').AsFloat, 2);
    if fCol.Prozent2 = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_PROZENT2').AsFloat, 2);
    if fCol.Prozent3 = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_PROZENT3').AsFloat, 2);
    if fCol.Prozent4 = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_PROZENT4').AsFloat, 2);
    if fCol.Prozent5 = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_PROZENT5').AsFloat, 2);
    if fCol.Prozent6 = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_PROZENT6').AsFloat, 2);
    if fCol.Durchschnitt = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_DURCHSCHNITT').AsFloat, 2);
    if fCol.Col365Tage = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_PROZ365TAGE').AsFloat, 2);
    if fCol.TSI27 = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_TSI27').AsFloat, 2);
    if fCol.ProzAbw = aCol then
      Value := GuVJahre.Runden(GuVJahre.FieldByName('GJ_ABWPROZ').AsFloat, 2);
  finally
    //Log.d('Ende --> grdGetValue');
  end;



end;

procedure Tfrm_GuVJahre.grdHeaderClick(Column: TColumn);
begin
  fSortDirection := not fSortDirection;
  if SameText(Column.Name, 'Col_Aktie') then
    fGuVJahreList.StringSort('AK_AKTIE', fSortDirection);
  if SameText(Column.Name, 'Col_Prozent1') then
    fGuVJahreList.FloatSort('GJ_PROZENT1', fSortDirection);
  if SameText(Column.Name, 'Col_Prozent2') then
    fGuVJahreList.FloatSort('GJ_PROZENT2', fSortDirection);
  if SameText(Column.Name, 'Col_Prozent3') then
    fGuVJahreList.FloatSort('GJ_PROZENT3', fSortDirection);
  if SameText(Column.Name, 'Col_Prozent4') then
    fGuVJahreList.FloatSort('GJ_PROZENT4', fSortDirection);
  if SameText(Column.Name, 'Col_Prozent5') then
    fGuVJahreList.FloatSort('GJ_PROZENT5', fSortDirection);
  if SameText(Column.Name, 'Col_Prozent6') then
    fGuVJahreList.FloatSort('GJ_PROZENT6', fSortDirection);
  if SameText(Column.Name, 'Col_Durchschnitt') then
  begin
    fGridList.FloatSort('GJ_DURCHSCHNITT', fSortDirection);
    fGuVJahreList.FloatSort('GJ_DURCHSCHNITT', fSortDirection);
  end;
  if SameText(Column.Name, 'Col_AbwProz') then
    fGuVJahreList.FloatSort('GJ_ABWPROZSORT', fSortDirection);
  if cbx_DebotwerteFirst.IsChecked then
    DepotwerteNachOben;
  AktualGrid;
end;

procedure Tfrm_GuVJahre.Grid1ApplyStyleLookup(Sender: TObject);
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
      //I.Text := 'Blabla';
     // I.StyledSettings := [TStyledSetting.FontColor];  was der Style nicht verändern soll
      //I.TextSettings.HorzAlign := TTextAlign.Center;
      I.TextSettings.Font.Family := 'Tw Cen MT';
      i.TextSettings.Font.Size := 25;
    end;
  end;
end;



procedure Tfrm_GuVJahre.setAnsichtList(aAnsichtList: TRestAnsichtList);
begin
  fAnsichtList := aAnsichtList;
end;

procedure Tfrm_GuVJahre.setDepotnameList(aDepotnameList: TRestDepotnameList);
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


procedure Tfrm_GuVJahre.setDepotwerteList(aDepotwerteList: TRestDepotwerteList);
begin
  fDepotwerteList := aDepotwerteList;
end;

procedure Tfrm_GuVJahre.setGuVJahreList(aGuVJahreList: TRestGuVJahreList);
begin
  fGuVJahreList := aGuVJahreList;
  fGuVJahreList.CopyList(fGridList);
  AktualGrid;
end;

procedure Tfrm_GuVJahre.AktualGrid;
var
  i1, i2: Integer;
  NeuRestAnsicht: TRestGuVJahre;
  s: string;
begin
  log.d('Start --> AktualGrid');
  fGridList.Clear;
  if Trim(fAktieFilter) = '' then
    fGuVJahreList.CopyList(fGridList)
  else
  begin
    if (fAktieFilter > '') then
    begin
      for i1 := 0 to fGuVJahreList.Count -1 do
      begin
        s := copy(fGuVJahreList.Item[i1].FieldByName('AK_AKTIE').AsString, 1, Length(fAktieFilter));
        if SameText(s, fAktieFilter) then
        begin
          NeuRestAnsicht := fGridList.Add;
          for i2 := 0 to fGuVJahreList.Item[i1].FeldList.Count -1 do
           NeuRestAnsicht.FeldList.Feld[i2].AsString := fGuVJahreList.Item[i1].FeldList.Feld[i2].AsString;
        end;
      end;
    end;
  end;

  grd.BeginUpdate;
  grd.RowCount := fGridList.Count;
  grd.EndUpdate;
  log.d('Ende --> AktualGrid');
end;


{
function Tfrm_GuVJahre.getAnsichtRow(aWKN: string): TRestAnsicht;
var
  i1: Integer;
begin
  Result := nil;
  if fAnsichtList = nil then
    exit;
  for i1 := 0 to fAnsichtList.Count -1 do
  begin
    if SameText(fAnsichtList.Item[i1].FieldByName('AK_WKN').AsString, aWKN) then
    begin
      Result := TRestAnsicht(fAnsichtList.Item[i1]);
      exit;
    end;

  end;
end;
}

procedure Tfrm_GuVJahre.grdCellClick(const Column: TColumn; const Row: Integer);
begin
  if SameText(Column.Name, 'Col_WKN') then
    grdCellDblClick(Column, Row);
end;

procedure Tfrm_GuVJahre.grdCellDblClick(const Column: TColumn;
  const Row: Integer);
var
  GuVJahre: TRestGuVJahre;
begin
  GuVJahre := fGridList.Item[Row];
  if GuVJahre = nil then
    exit;
  if Assigned(fOnGridDblClick) then
    fOnGridDblClick(GuVJahre.FieldByName('AK_ID').AsInteger);
end;

procedure Tfrm_GuVJahre.cbx_DebotwerteFirstClick(Sender: TObject);
begin
  if not cbx_DebotwerteFirst.IsChecked then
    DepotwerteNachOben;
  AktualGrid;
end;

procedure Tfrm_GuVJahre.DepotwerteNachOben;
var
  i1: Integer;
  NewPos: Integer;
  GuVJahre: TRestGuVJahre;
  DpId: Integer;
begin
  DpId := getDpId;
  NewPos := 0;
  {
  for i1 := 0 to fGridList.Count -1 do
  begin
    GuVJahre := fGridList.Item[i1];
    //if GuVJahre.FieldByName('AK_DEPOT').AsString = 'T' then
    if fDepotwerteList.AktieInDepot(GuVJahre.FieldByName('AK_ID').AsInteger, DpId) then
    begin
      fGridList.MoveItem(i1, NewPos);
      inc(NewPos);
    end;
  end;

  for i1 := 0 to fGridList.Count -1 do
  begin
    GuVJahre := fGridList.Item[i1];
    if GuVJahre.FieldByName('AK_AKTIE').AsString = 'DAX' then
    begin
      fGridList.MoveItem(i1, 0);
      break;
    end;
  end;
  }

  for i1 := 0 to fGuVJahreList.Count -1 do
  begin
    GuVJahre := fGuVJahreList.Item[i1];
    if fDepotwerteList.AktieInDepot(GuVJahre.FieldByName('AK_ID').AsInteger, DpId) then
    begin
      fGuVJahreList.MoveItem(i1, NewPos);
      inc(NewPos);
    end;
  end;


  for i1 := 0 to fGuVJahreList.Count -1 do
  begin
    GuVJahre := fGuVJahreList.Item[i1];
    if GuVJahre.FieldByName('AK_AKTIE').AsString = 'DAX' then
    begin
      fGuVJahreList.MoveItem(i1, 0);
      break;
    end;
  end;


end;


procedure Tfrm_GuVJahre.edt_AktieKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  fAktieFilter := Trim(edt_Aktie.Text);
  AktualGrid;
end;

procedure Tfrm_GuVJahre.men_365TageClick(Sender: TObject);
var
  GuVJahre: TRestGuVJahre;
  WKN: string;
  Aktie: string;
begin
  //Hier gehts weiter
  if fGuVJahreList = nil then
    exit;
  if grd.Row > fGridList.Count -1 then
    exit;
  GuVJahre := fGridList.Item[grd.Row];

  WKN := GuVJahre.FieldByName('AK_WKN').AsString;
  Aktie := GuVJahre.FieldByName('AK_AKTIE').AsString;

  if grd.Col = fCol.Col365Tage then
  begin
    ShowMessage('365 Tage');
    fRechenweg.Tage365(GuVJahre.FieldByName('AK_ID').AsInteger);
  end;
end;



end.
