inherited frm_Joblist: Tfrm_Joblist
  Caption = 'frm_Joblist'
  ClientWidth = 874
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 874
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 874
    Height = 34
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 651
    object btn_Neu: TButton
      AlignWithMargins = True
      Left = 10
      Top = 3
      Width = 75
      Height = 28
      Margins.Left = 10
      Align = alLeft
      Caption = 'Neu'
      TabOrder = 0
      OnClick = btn_NeuClick
    end
    object btn_Zurueck: TButton
      AlignWithMargins = True
      Left = 789
      Top = 3
      Width = 75
      Height = 28
      Margins.Right = 10
      Align = alRight
      Caption = 'Zur'#252'ck'
      TabOrder = 1
      OnClick = btn_ZurueckClick
      ExplicitLeft = 566
    end
    object btn_Delete: TButton
      AlignWithMargins = True
      Left = 98
      Top = 3
      Width = 75
      Height = 28
      Margins.Left = 10
      Align = alLeft
      Caption = 'L'#246'schen'
      TabOrder = 2
      OnClick = btn_DeleteClick
    end
    object btn_SyncZielpfad: TButton
      AlignWithMargins = True
      Left = 186
      Top = 3
      Width = 87
      Height = 28
      Margins.Left = 10
      Align = alLeft
      Caption = 'Sync Zielpfad'
      TabOrder = 3
      OnClick = btn_SyncZielpfadClick
    end
    object btn_ResetChangeDatumForJob: TButton
      AlignWithMargins = True
      Left = 478
      Top = 3
      Width = 171
      Height = 28
      Margins.Left = 10
      Align = alLeft
      Caption = 'Reset '#196'nderungsdatum f'#252'r Job'
      TabOrder = 4
      OnClick = btn_ResetChangeDatumForJobClick
    end
    object btn_ResetChangedatumForAll: TButton
      AlignWithMargins = True
      Left = 286
      Top = 3
      Width = 179
      Height = 28
      Margins.Left = 10
      Align = alLeft
      Caption = 'Reset '#196'nderungsdatum f'#252'r alle'
      TabOrder = 5
      OnClick = btn_ResetChangedatumForAllClick
    end
  end
  object scb: TScrollBox
    AlignWithMargins = True
    Left = 3
    Top = 37
    Width = 868
    Height = 298
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 645
  end
end
