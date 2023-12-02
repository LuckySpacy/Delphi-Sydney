unit Form.ChartTSI;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMXTee.Engine,
  FMXTee.Procs, FMXTee.Chart, Rest.TSI, Rest.TSIList, fmxTee.Series;

type
  Tfrm_ChartTSI = class(TForm)
    Chart: TChart;
  private
    fKursList: TRestTSIList;
    fAktie: string;
    fWKN: string;
  public
    procedure setKursList(aKursList: TRestTSIList);
    procedure ShowChart(aDatumVon, aDatumBis: TDateTime);
    property WKN: string read fWKN write fWKN;
    property Aktie: string read fAktie write fAktie;
  end;

var
  frm_ChartTSI: Tfrm_ChartTSI;

implementation

{$R *.fmx}

{ Tfrm_ChartTSI }

procedure Tfrm_ChartTSI.setKursList(aKursList: TRestTSIList);
begin
  fKursList := aKursList;
end;

procedure Tfrm_ChartTSI.ShowChart(aDatumVon, aDatumBis: TDateTime);
var
  s : TLineSeries;
  i1: Integer;
  Kurs: TRestTSI;
begin //
  for i1 := Chart.SeriesList.Count -1 downto 0 do
    Chart.SeriesList.Delete(i1);
  Chart.Title.Text.Clear;
  Chart.Title.Text.Add('[' + fWkn + '] ' + fAktie);
  Chart.View3D := false;

  s := TLineSeries.Create(nil);
  s.Clear;
  s.Title := '[' + fWkn + '] ' + fAktie;
  s.ParentChart := Chart;
  s.XValues.DateTime := true;


  for i1 := 0 to fKursList.Count -1 do
  begin
    Kurs := fKursList.Item[i1];
    if Kurs.FieldByName('ts_datum').AsDateTime < aDatumVon then
      continue;
    if Kurs.FieldByName('ts_datum').AsDateTime > aDatumBis then
      continue;
    s.AddXY(Kurs.FieldByName('ts_datum').AsDateTime, Kurs.FieldByName('ts_wert').AsFloat);
  end;

end;

end.
