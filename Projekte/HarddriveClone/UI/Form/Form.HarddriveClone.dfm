object frm_HarddriveClone: Tfrm_HarddriveClone
  Left = 0
  Top = 0
  Caption = 'Harddrive-Clone'
  ClientHeight = 430
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pg: TPageControl
    Left = 0
    Top = 0
    Width = 635
    Height = 430
    ActivePage = tbs_Job
    Align = alClient
    TabOrder = 0
    object tbs_Job: TTabSheet
      Caption = 'tbs_Job'
    end
    object tbs_detail: TTabSheet
      Caption = 'tbs_detail'
      ImageIndex = 1
    end
  end
end
