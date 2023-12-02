program TSIAnsichtWin;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.TSIAnsicht in 'Form\Form.TSIAnsicht.pas' {frm_TSIAnsicht},
  ClientModul.Classes in 'Clientmodul\ClientModul.Classes.pas',
  ClientModul.Module in 'Clientmodul\ClientModul.Module.pas' {ClientModule2: TDataModule},
  Form.TSI in 'Form\Form.TSI.pas' {frm_TSI},
  Form.TSI2 in 'Form\Form.TSI2.pas' {frm_TSI2},
  Form.Chart in 'Form\Form.Chart.pas' {frm_Chart},
  Form.Charts in 'Form\Form.Charts.pas' {frm_Charts},
  Rest.TSI in '..\..\Rest\Rest.TSI.pas',
  Rest.TSIList in '..\..\Rest\Rest.TSIList.pas',
  Form.ChartTSI in 'Form\Form.ChartTSI.pas' {frm_ChartTSI},
  Rest.Ansicht in '..\..\Rest\Rest.Ansicht.pas',
  Form.GuVJahre in 'Form\Form.GuVJahre.pas' {frm_GuVJahre},
  Objekt.Invest in '..\..\Objekt\Objekt.Invest.pas',
  Objekt.InvestList in '..\..\Objekt\Objekt.InvestList.pas',
  Objekt.Basislist in '..\..\..\Allgemein\Objekt\Objekt.Basislist.pas',
  Objekt.Rechenweg in '..\..\Objekt\Objekt.Rechenweg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_TSIAnsicht, frm_TSIAnsicht);
  Application.CreateForm(TClientModule2, ClientModule2);
  Application.CreateForm(Tfrm_GuVJahre, frm_GuVJahre);
  Application.Run;
end.
