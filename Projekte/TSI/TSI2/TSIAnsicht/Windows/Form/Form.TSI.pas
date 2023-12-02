unit Form.TSI;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  Rest.Ansicht, Rest.AnsichtList, FMX.StdCtrls, FMX.Edit;

type
  TGridDblClickEvent = procedure(AkId: Integer) of object;
  RSortDirection = Record
    Aktie: Boolean;
    TSI27: Boolean;
    TSI12: Boolean;
  end;

type
  RCol = Record
    const WKN: Integer = 0;
    const Aktie: Integer = 1;
    const LetzterKurs: Integer = 2;
    const TSI27: Integer = 3;
    const TSI12: Integer = 4;
    const Kurs: Integer = 5;
    const JHochkurs: Integer = 6;
    const JHochDat: Integer = 7;
    const JTiefkurs: Integer = 8;
    const JTiefDat: Integer = 9;
    const count: Integer = 10;
  End;

type
  Tfrm_TSI = class(TForm)
    grd: TGrid;
    Col_WKN: TColumn;
    Col_Aktie: TColumn;
    Col_LetzterKurs: TColumn;
    Col_TSI27: TColumn;
    Col_TSI12: TColumn;
    Col_Kurs: TColumn;
    Col_JHochkurs: TColumn;
    Col_JHochDat: TColumn;
    Col_JTiefkurs: TColumn;
    Col_JTiefDat: TColumn;
    Panel1: TPanel;
    cbx_DebotwerteFirst: TCheckBox;
    cbx_HochKursNachOben: TCheckBox;
    edt_Aktie: TEdit;
    lbl_Aktie: TLabel;
    procedure grdGetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure FormCreate(Sender: TObject);
    procedure grdHeaderClick(Column: TColumn);
    procedure grdDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
    procedure FormDestroy(Sender: TObject);
    procedure cbx_DebotwerteFirstClick(Sender: TObject);
    procedure DepotwerteNachOben;
    procedure DepotwerteHoechstKurseNachOben;
    procedure cbx_HochKursNachObenClick(Sender: TObject);
    procedure grdCellClick(const Column: TColumn; const Row: Integer);
    procedure grdCellDblClick(const Column: TColumn; const Row: Integer);
    procedure edt_AktieKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    fCol: RCol;
    fSortDirection: RSortDirection;
    fAnsichtList: TRestAnsichtList;
    fGridList: TRestAnsichtList;
    fOnGridDblClick: TGridDblClickEvent;
    fAktieFilter: string;
    procedure AktualGrid;
    procedure Grid1ApplyStyleLookup(Sender: TObject);
  public
    procedure setAnsichtList(aAnsichtList: TRestAnsichtList);
    property OnGridDblClick: TGridDblClickEvent read  fOnGridDblClick write fOnGridDblClick;
  end;

var
  frm_TSI: Tfrm_TSI;

implementation

{$R *.fmx}

uses
  ClientModul.Classes, ClientModul.Module, fmx.Header;

{ Tfrm_TSI }



procedure Tfrm_TSI.FormCreate(Sender: TObject);
begin
  fGridList := TRestAnsichtList.Create;
  fAnsichtList := nil;
  grd.OnApplyStyleLookup := Grid1ApplyStyleLookup;
  fSortDirection.Aktie := true;
  fSortDirection.TSI27 := true;
  fSortDirection.TSI12 := true;
  fAktieFilter := '';
end;

procedure Tfrm_TSI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fGridList);
end;

procedure Tfrm_TSI.setAnsichtList(aAnsichtList: TRestAnsichtList);
//var
//  i1: Integer;
begin
  fAnsichtList := aAnsichtList;
  fAnsichtList.CopyList(fGridList);
  AktualGrid;
end;

procedure Tfrm_TSI.AktualGrid;
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
  //grd.Columns[fCol.Zutat].Align := TAlignLayout.Client;
  grd.RowCount := fGridList.Count;
  grd.EndUpdate;
  grd.Columns[fCol.WKN].Width := 80;
  grd.Columns[fCol.Aktie].Width := 300;
  grd.Columns[fCol.LetzterKurs].Width := 80;
  grd.Columns[fCol.TSI27].Width := 80;
  grd.Columns[fCol.TSI12].Width := 80;
  grd.Columns[fCol.Kurs].Width := 80;
  grd.Columns[fCol.JHochkurs].Width := 80;
  grd.Columns[fCol.JHochDat].Width := 80;
  grd.Columns[fCol.JTiefkurs].Width := 80;
  grd.Columns[fCol.JTiefDat].Width := 80;
end;





procedure Tfrm_TSI.grdDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
  const Column: TColumn; const Bounds: TRectF; const Row: Integer;
  const Value: TValue; const State: TGridDrawStates);
var
  BgBrush: TBrush;
  Ansicht: TRestAnsicht;
begin
  if fAnsichtList = nil then
    exit;
  bgBrush:= TBrush.Create(TBrushKind.Solid, TAlphaColors.White);

  if SameText(Column.Name, 'Col_AKTIE') then
  begin
    if (fGridList.Count >= Row) then
    begin
      Ansicht := fGridList.Item[Row];
      if Ansicht.FieldByName('AK_DEPOT').AsString = 'T' then
      begin
        bgBrush.Color := TAlphaColors.Skyblue;
        Canvas.FillRect(Bounds, 0, 0, [], 1, bgBrush);
        Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
      end;
    end;
  end;

  if SameText(Column.Name, 'Col_TSI27') then
  begin
    if (fGridList.Count >= Row) then
    begin
      Ansicht := fGridList.Item[Row];
      if Ansicht.FieldByName('HT_LETZTERKURS').AsFloat >= Ansicht.FieldByName('HT_HOCH_JAHRKURS').AsFloat then
      begin
        bgBrush.Color := TAlphaColors.Yellow;
        Canvas.FillRect(Bounds, 0, 0, [], 1, bgBrush);
        Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
      end;
      if Ansicht.FieldByName('HT_LETZTERKURS').AsFloat <= Ansicht.FieldByName('HT_TIEF_JAHRKURS').AsFloat then
      begin
        bgBrush.Color := TAlphaColors.red;
        Canvas.FillRect(Bounds, 0, 0, [], 1, bgBrush);
        Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
      end;
    end;
  end;
  FreeAndNil(bgBrush);
end;

procedure Tfrm_TSI.grdGetValue(Sender: TObject; const ACol, ARow: Integer;
  var Value: TValue);
var
  Ansicht: TRestAnsicht;
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
  if fCol.Kurs = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('HT_LETZTERKURS').AsFloat, 2);
  if fCol.JHochkurs = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('HT_HOCH_JAHRKURS').AsFloat, 2);
  if fCol.JHochDat = aCol then
    Value := Ansicht.FieldByName('HT_HOCH_JAHRDATUM').AsString;
  if fCol.JTiefkurs = aCol then
    Value := Ansicht.Runden(Ansicht.FieldByName('HT_TIEF_JAHRKURS').AsFloat, 2);
  if fCol.JTiefDat = aCol then
    Value := Ansicht.FieldByName('HT_TIEF_JAHRDATUM').AsString;
end;


procedure Tfrm_TSI.grdHeaderClick(Column: TColumn);
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
  if SameText(Column.Name, 'Col_TSI27') then
  begin
    fGridList.FloatSort('TL_WERT27', fSortDirection.TSI27);
    fAnsichtList.FloatSort('TL_WERT27', fSortDirection.TSI27);
    fSortDirection.TSI27 := not fSortDirection.TSI27;
  end;
  if SameText(Column.Name, 'Col_TSI12') then
  begin
    fGridList.FloatSort('TL_WERT12', fSortDirection.TSI12);
    fAnsichtList.FloatSort('TL_WERT12', fSortDirection.TSI27);
    fSortDirection.TSI12 := not fSortDirection.TSI12;
  end;

  if SameText(Column.Name, 'Col_LetzterKurs') then
  begin
    fGridList.DateSort('TL_DATUM27', true);
    fAnsichtList.DateSort('TL_DATUM27', true);
  end;

  AktualGrid;
end;

procedure Tfrm_TSI.Grid1ApplyStyleLookup(Sender: TObject);
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

procedure Tfrm_TSI.cbx_DebotwerteFirstClick(Sender: TObject);
begin //
  if cbx_HochKursNachOben.IsChecked then
    DepotwerteHoechstKurseNachOben;
  if not cbx_DebotwerteFirst.IsChecked then
    DepotwerteNachOben;
  AktualGrid;
end;

procedure Tfrm_TSI.cbx_HochKursNachObenClick(Sender: TObject);
begin
  if not cbx_HochKursNachOben.IsChecked then
    DepotwerteHoechstKurseNachOben;
  if cbx_DebotwerteFirst.IsChecked then
    DepotwerteNachOben;
  AktualGrid;
end;

procedure Tfrm_TSI.DepotwerteNachOben;
var
  i1: Integer;
  NewPos: Integer;
  Ansicht: TRestAnsicht;
begin
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

end;


procedure Tfrm_TSI.edt_AktieKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  fAktieFilter := Trim(edt_Aktie.Text);
  AktualGrid;
end;

procedure Tfrm_TSI.DepotwerteHoechstKurseNachOben;
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
end;


procedure Tfrm_TSI.grdCellClick(const Column: TColumn; const Row: Integer);
begin
  if SameText(Column.Name, 'Col_WKN') then
    grdCellDblClick(Column, Row);
end;

procedure Tfrm_TSI.grdCellDblClick(const Column: TColumn; const Row: Integer);
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
