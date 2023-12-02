unit Form.Zutat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, Rest.Rezept, System.Rtti,
  FMX.Grid.Style, FMX.Grid, Rest.RezeptZutatenList, FMX.Layouts, Objekt.Allg,
  FMX.Header;

type
  RCol = Record
    const Menge: Integer = 0;
    const Einheit: Integer = 1;
    const Zutat: Integer = 2;
  End;

type
  Tfrm_Zutat = class(TForm)
    Layout1: TLayout;
    grd: TGrid;
    Col_Menge: TFloatColumn;
    Col_Einheit: TStringColumn;
    Col_Zutat: TStringColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdGetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
  private
    fBasismenge: real;
    fAnsichtMenge: real;
    fCol : RCol;
    fRestRezept: TRestRezept;
    fRezeptZutatenList: TRestRezeptZutatenList;
    fAllg : TAllg;
    procedure AktualGrid;
    procedure setAnsichtMenge(const Value: real);
    procedure Grid1ApplyStyleLookup(Sender: TObject);
  public
    procedure setRezept(aRezept: TRestRezept; aZlId: Integer);
    property AnsichtMenge: real read fAnsichtMenge write setAnsichtMenge;
  end;

var
  frm_Zutat: Tfrm_Zutat;

implementation

{$R *.fmx}

{ Tfrm_Zutat }

uses
  Objekt.RestSchnittstelle;


procedure Tfrm_Zutat.FormCreate(Sender: TObject);
begin
  fAllg := TAllg.Create;
  fRezeptZutatenList := TRestRezeptZutatenList.Create;
  grd.RowCount := 0;
  grd.OnApplyStyleLookup := Grid1ApplyStyleLookup;
end;

procedure Tfrm_Zutat.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fRezeptZutatenList);
  FreeAndNil(fAllg);
end;


procedure Tfrm_Zutat.setAnsichtMenge(const Value: real);
begin
  fAnsichtMenge := Value;
  AktualGrid;
end;

procedure Tfrm_Zutat.setRezept(aRezept: TRestRezept; aZlId: Integer);
var
  i1: Integer;
begin
  fRestRezept := aRezept;
  fBasismenge := fRestRezept.FieldByName('Basismenge').AsInteger;
  fAnsichtMenge := fBasismenge;
  RestSchnittstelle.HoleZutatenlist(fRezeptZutatenList, fRestRezept.FieldByName('Id').AsInteger, aZlId);
  fBasismenge := fRestRezept.FieldByName('Basismenge').AsInteger;
  fAnsichtMenge := fBasisMenge;
  AktualGrid;

end;


procedure Tfrm_Zutat.AktualGrid;
begin
  grd.BeginUpdate;
  //grd.Columns[fCol.Zutat].Align := TAlignLayout.Client;
  grd.RowCount := fRezeptZutatenList.Count;
  grd.EndUpdate;
  grd.Columns[fCol.Zutat].Width := 300;
  grd.Columns[fCol.Menge].Width := 80;
  grd.Columns[fCol.Einheit].Width := 65;
end;

procedure Tfrm_Zutat.grdGetValue(Sender: TObject; const ACol, ARow: Integer;
  var Value: TValue);
var
  NewValue: real;
begin
  if ARow > fRezeptZutatenList.Count -1 then
    exit;
  if fCol.Zutat = ACol then
    Value := fRezeptZutatenList.Item[ARow].FieldByName('NAME').AsString;
  if fCol.Menge = ACol then
  begin
    if (fBasismenge > 0) and (fRezeptZutatenList.Item[ARow].FieldByName('MENGE').AsFloat > 0) then
    begin
      NewValue := (fRezeptZutatenList.Item[ARow].FieldByName('MENGE').AsFloat / fBasismenge) * fAnsichtMenge;
      NewValue := fAllg.Runden(NewValue, 2);
      Value := NewValue;
    end
    else
      Value := fRezeptZutatenList.Item[ARow].FieldByName('MENGE').AsFloat;
  end;
  if fCol.Einheit = ACol then
    Value := fRezeptZutatenList.Item[ARow].FieldByName('EINHEIT').AsString;
end;

procedure Tfrm_Zutat.Grid1ApplyStyleLookup(Sender: TObject);
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



end.
