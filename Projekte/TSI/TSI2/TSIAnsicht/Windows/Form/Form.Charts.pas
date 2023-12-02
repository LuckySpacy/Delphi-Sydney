unit Form.Charts;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Form.Chart,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, Rest.Ansicht, Rest.AnsichtList,
  FMX.DateTimeCtrls, Rest.Kurs, Rest.KursList, Form.ChartTSI,
  Rest.TSI, Rest.TSIList;

type
  Tfrm_Charts = class(TForm)
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    btn_Aktualisieren: TButton;
    edt_Datumvon: TDateEdit;
    edt_Datumbis: TDateEdit;
    Lay_TSIChart: TLayout;
    Lay_AktieChart: TLayout;
    Splitter1: TSplitter;
    cbx_DaxAnzeigen: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btn_AktualisierenClick(Sender: TObject);
  private
    fAkId: Integer;
    fFormChart: Tfrm_Chart;
    fFormChartTSI: Tfrm_ChartTSI;
    fAnsichtList: TRestAnsichtList;
    fKursList: TRestKursList;
    fDaxKursList: TRestKursList;
    fTSIList: TRestTSIList;
  public
    procedure setAnsichtList(aAnsichtList: TRestAnsichtList);
    procedure setKursList(aKursList: TRestKursList);
    procedure setTSIKursList(aTSIList: TRestTSIList);
    procedure setDaxKursList(aKursList: TRestKursList);
    procedure ShowChart(aAkId: Integer);
  end;

var
  frm_Charts: Tfrm_Charts;

implementation

{$R *.fmx}



procedure Tfrm_Charts.FormCreate(Sender: TObject);
begin
  fAkId := 0;
  fAnsichtList := nil;
  fTSIList := nil;
  fKursList := nil;
  fDaxKursList := nil;

  fFormChart := Tfrm_Chart.Create(Self);
  while fFormChart.ChildrenCount>0 do
    fFormChart.Children[0].Parent := Lay_AktieChart;


  fFormChartTSI := Tfrm_ChartTSI.Create(Self);
  while fFormChartTSI.ChildrenCount>0 do
    fFormChartTSI.Children[0].Parent := Lay_TSIChart;

  edt_Datumvon.Date := StrToDate('01.01.2000');
  edt_Datumbis.Date := trunc(now);
end;

procedure Tfrm_Charts.setAnsichtList(aAnsichtList: TRestAnsichtList);
begin
  fAnsichtList := aAnsichtList;
end;

procedure Tfrm_Charts.setDaxKursList(aKursList: TRestKursList);
begin
  fDaxKursList := aKursList;
  fFormChart.setDaxKursList(fDaxKursList);
end;

procedure Tfrm_Charts.setKursList(aKursList: TRestKursList);
begin
  fKursList := aKursList;
end;

procedure Tfrm_Charts.setTSIKursList(aTSIList: TRestTSIList);
begin
  fTSIList := aTSIList;
end;

procedure Tfrm_Charts.ShowChart(aAkId: Integer);
var
  AnsichtIndex: Integer;
begin
  if fAnsichtList = nil then
    exit;
  AnsichtIndex := fAnsichtList.getItemIndex(aAkId);
  if AnsichtIndex < 0 then
    exit;
  fAkId := aAkId;
  fFormChart.WKN   := fAnsichtList.Item[AnsichtIndex].FeldList.FieldByName('AK_WKN').AsString;
  fFormChart.Aktie := fAnsichtList.Item[AnsichtIndex].FeldList.FieldByName('AK_AKTIE').AsString;
  fFormChart.setKursList(fKurslist);
  fFormChart.ShowChart(edt_Datumvon.Date, edt_Datumbis.Date, cbx_DaxAnzeigen.IsChecked);

  fFormChartTSI.WKN   := fAnsichtList.Item[AnsichtIndex].FeldList.FieldByName('AK_WKN').AsString;
  fFormChartTSI.Aktie := fAnsichtList.Item[AnsichtIndex].FeldList.FieldByName('AK_AKTIE').AsString;
  fFormChartTSI.setKursList(fTSIList);
  fFormChartTSI.ShowChart(edt_Datumvon.Date, edt_Datumbis.Date);


end;

procedure Tfrm_Charts.btn_AktualisierenClick(Sender: TObject);
begin
  ShowChart(fAkId);
end;

end.
