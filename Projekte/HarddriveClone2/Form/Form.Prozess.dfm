inherited frm_Prozess: Tfrm_Prozess
  Caption = 'frm_Prozess'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Prozess: TPanel
    Left = 24
    Top = 112
    Width = 585
    Height = 97
    BevelOuter = bvNone
    Caption = 'pnl_Prozess'
    ShowCaption = False
    TabOrder = 0
    object lbl_Prozessname: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 45
      Width = 96
      Height = 16
      Align = alTop
      Caption = 'lbl_Prozessname'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl_Caption: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 54
      Height = 19
      Margins.Bottom = 20
      Align = alTop
      Caption = 'Caption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object pg: TProgressBar
      AlignWithMargins = True
      Left = 3
      Top = 67
      Width = 579
      Height = 17
      Align = alTop
      TabOrder = 0
    end
  end
end
