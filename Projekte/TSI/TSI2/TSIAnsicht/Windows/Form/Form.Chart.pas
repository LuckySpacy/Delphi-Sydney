unit Form.Chart;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
 // FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMXTee.Engine,
  FMXTee.Procs, FMXTee.Chart, Rest.Kurs, Rest.KursList, fmxTee.Series, FMX.Forms,
  FMX.Controls.Presentation, FMX.StdCtrls, FMXTee.Engine, FMX.Types,
  FMX.Controls;

type
  Tfrm_Chart = class(TForm)
    Chart: TChart;
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    fKursList: TRestKursList;
    fDaxList: TRestKursList;
    fDaxAnzeigen: Boolean;
    fAktie: string;
    fWKN: string;
    procedure DaxAnzeigen(aAkKurs:real; aDatumVon, aDatumBis: TDateTime);
  public
    procedure setKursList(aKursList: TRestKursList);
    procedure setDaxKursList(aKursList: TRestKursList);
    procedure ShowChart(aDatumVon, aDatumBis: TDateTime; aDaxAnzeigen: Boolean);
    property WKN: string read fWKN write fWKN;
    property Aktie: string read fAktie write fAktie;
  end;

var
  frm_Chart: Tfrm_Chart;

implementation

{$R *.fmx}


procedure Tfrm_Chart.FormCreate(Sender: TObject);
begin //
  fKursList := nil;
  fDaxList  := nil;
  fDaxAnzeigen := false;
end;

procedure Tfrm_Chart.FormDeactivate(Sender: TObject);
begin //

end;

procedure Tfrm_Chart.setDaxKursList(aKursList: TRestKursList);
begin
  fDaxList := aKursList;
end;

procedure Tfrm_Chart.setKursList(aKursList: TRestKursList);
begin
  fKursList := aKursList;
end;

procedure Tfrm_Chart.ShowChart(aDatumVon, aDatumBis: TDateTime; aDaxAnzeigen: Boolean);
var
  s : TLineSeries;
  i1: Integer;
  Kurs: TRestKurs;
  AkKurs: real;
  //DaxKurs: real;
  //Faktor: real;
  //Kurswert: real;
begin
  fDaxAnzeigen := aDaxAnzeigen;
  for i1 := Chart.SeriesList.Count -1 downto 0 do
    Chart.SeriesList.Delete(i1);

  Chart.ClearChart;
  Chart.Title.Text.Clear;
  Chart.Title.Text.Add('[' + fWkn + '] ' + fAktie);
  Chart.View3D := false;

  s := TLineSeries.Create(nil);
  s.Clear;
  s.Title := '[' + fWkn + '] ' + fAktie;
  s.ParentChart := Chart;
  s.XValues.DateTime := true;


  AkKurs := -1;
  //DaxKurs := -1;
  for i1 := 0 to fKursList.Count -1 do
  begin
    Kurs := fKursList.Item[i1];
    if Kurs.FieldByName('ku_datum').AsDateTime < aDatumVon then
      continue;
    if Kurs.FieldByName('ku_datum').AsDateTime > aDatumBis then
      continue;
    if AkKurs = -1 then
      AkKurs := Kurs.FieldByName('ku_kurs').AsFloat;
    s.AddXY(Kurs.FieldByName('ku_datum').AsDateTime, Kurs.FieldByName('ku_kurs').AsFloat);
  end;

  if fDaxAnzeigen then
    DaxAnzeigen(AkKurs, aDatumVon, aDatumBis);

  {
  s := TLineSeries.Create(nil);
  s.Clear;
  s.ParentChart := Chart;
  s.XValues.DateTime := true;

  for i1 := 0 to fDaxList.Count -1 do
  begin
    Kurs := fDaxList.Item[i1];
    if Kurs.FieldByName('ku_datum').AsDateTime < aDatumVon then
      continue;
    if Kurs.FieldByName('ku_datum').AsDateTime > aDatumBis then
      continue;
    if DaxKurs = -1 then
    begin
      DaxKurs := Kurs.FieldByName('ku_kurs').AsFloat;
      break;
    end;
  end;

  Faktor := 1;
  if AkKurs > 0 then
    Faktor := DaxKurs / AkKurs;

  for i1 := 0 to fDaxList.Count -1 do
  begin
    Kurs := fDaxList.Item[i1];
    if Kurs.FieldByName('ku_datum').AsDateTime < aDatumVon then
      continue;
    if Kurs.FieldByName('ku_datum').AsDateTime > aDatumBis then
      continue;
    Kurswert := Kurs.Runden(Kurs.FieldByName('ku_kurs').AsFloat / Faktor, 2);
    s.AddXY(Kurs.FieldByName('ku_datum').AsDateTime, Kurswert);
  end;

  if DaxKurs <> AkKurs then
    exit;
  }

end;


procedure Tfrm_Chart.DaxAnzeigen(aAkKurs: real; aDatumVon, aDatumBis: TDateTime);
var
  s : TLineSeries;
  i1: Integer;
  Kurs: TRestKurs;
  //AkKurs: real;
  DaxKurs: real;
  Faktor: real;
  Kurswert: real;
begin
  DaxKurs := -1;
  s := TLineSeries.Create(nil);
  s.Clear;
  s.ParentChart := Chart;
  s.XValues.DateTime := true;

  for i1 := 0 to fDaxList.Count -1 do
  begin
    Kurs := fDaxList.Item[i1];
    if Kurs.FieldByName('ku_datum').AsDateTime < aDatumVon then
      continue;
    if Kurs.FieldByName('ku_datum').AsDateTime > aDatumBis then
      continue;
    if DaxKurs = -1 then
    begin
      DaxKurs := Kurs.FieldByName('ku_kurs').AsFloat;
      break;
    end;
  end;

  Faktor := 1;
  if aAkKurs > 0 then
    Faktor := DaxKurs / aAkKurs;

  for i1 := 0 to fDaxList.Count -1 do
  begin
    Kurs := fDaxList.Item[i1];
    if Kurs.FieldByName('ku_datum').AsDateTime < aDatumVon then
      continue;
    if Kurs.FieldByName('ku_datum').AsDateTime > aDatumBis then
      continue;
    Kurswert := Kurs.Runden(Kurs.FieldByName('ku_kurs').AsFloat / Faktor, 2);
    s.AddXY(Kurs.FieldByName('ku_datum').AsDateTime, Kurswert);
  end;

end;



end.
