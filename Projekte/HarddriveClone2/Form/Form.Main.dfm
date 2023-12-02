inherited frm_Main: Tfrm_Main
  Caption = 'frm_Main'
  ClientHeight = 460
  OnCreate = FormCreate
  ExplicitHeight = 460
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object btn_Start: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 75
      Height = 35
      Align = alLeft
      Caption = 'Start'
      TabOrder = 0
      OnClick = btn_StartClick
    end
    object btn_Stop: TButton
      AlignWithMargins = True
      Left = 84
      Top = 3
      Width = 75
      Height = 35
      Align = alLeft
      Caption = 'Stop'
      TabOrder = 1
      OnClick = btn_StopClick
    end
    object btn_Einstellung: TButton
      AlignWithMargins = True
      Left = 165
      Top = 3
      Width = 75
      Height = 35
      Align = alLeft
      Caption = 'Einstellung'
      TabOrder = 2
      OnClick = btn_EinstellungClick
    end
  end
end
