object frm_Main: Tfrm_Main
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Rezepte'
  ClientHeight = 338
  ClientWidth = 651
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object btn_Einstellung: TnfsButton
      Left = 513
      Top = 0
      Width = 69
      Height = 44
      Images = dm_Bilder.img
      ImageAlignment = iaCenter
      ImageIndex = 1
      ImagePos.Left = 0
      ImagePos.Right = 0
      ImagePos.Top = 6
      TextPos.Left = 0
      TextPos.Right = 0
      TextPos.Top = 25
      Caption1 = 'Einstellung'
      OnClick = btn_EinstellungClick
      NumGlyphs = 1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      RoundRect = 0
      Align = alRight
      NotificationText.CirclePos.Left = 0
      NotificationText.CirclePos.Right = 0
      NotificationText.CirclePos.Top = 0
      NotificationText.CircleMarginX = 3
      NotificationText.CircleMarginY = 3
      NotificationText.Font.Charset = DEFAULT_CHARSET
      NotificationText.Font.Color = clWhite
      NotificationText.Font.Height = -9
      NotificationText.Font.Name = 'Tahoma'
      NotificationText.Font.Style = []
      TextAndImageCenter.ImageMargin.Left = 5
      TextAndImageCenter.ImageMargin.Right = 5
    end
    object btn_Close: TnfsButton
      Left = 582
      Top = 0
      Width = 69
      Height = 44
      Images = dm_Bilder.img
      ImageAlignment = iaCenter
      ImageIndex = 0
      ImagePos.Left = 0
      ImagePos.Right = 0
      ImagePos.Top = 6
      TextPos.Left = 0
      TextPos.Right = 0
      TextPos.Top = 25
      Caption1 = 'Schlie'#223'en'
      OnClick = btn_CloseClick
      NumGlyphs = 1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      RoundRect = 0
      Align = alRight
      ParentFont = False
      EscIsBtnClick = True
      NotificationText.CirclePos.Left = 0
      NotificationText.CirclePos.Right = 0
      NotificationText.CirclePos.Top = 0
      NotificationText.CircleMarginX = 3
      NotificationText.CircleMarginY = 3
      NotificationText.Font.Charset = DEFAULT_CHARSET
      NotificationText.Font.Color = clWhite
      NotificationText.Font.Height = -9
      NotificationText.Font.Name = 'Tahoma'
      NotificationText.Font.Style = []
      TextAndImageCenter.ImageMargin.Left = 5
      TextAndImageCenter.ImageMargin.Right = 5
    end
    object btn_neu: TnfsButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 50
      Height = 38
      Images = dm_Bilder.img
      ImageAlignment = iaCenter
      ImageIndex = 6
      ImagePos.Left = 0
      ImagePos.Right = 0
      ImagePos.Top = 6
      TextPos.Left = 0
      TextPos.Right = 0
      TextPos.Top = 25
      Caption1 = 'Neu'
      OnClick = btn_neuClick
      NumGlyphs = 1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      RoundRect = 0
      Align = alLeft
      NotificationText.CirclePos.Left = 0
      NotificationText.CirclePos.Right = 0
      NotificationText.CirclePos.Top = 0
      NotificationText.CircleMarginX = 3
      NotificationText.CircleMarginY = 3
      NotificationText.Font.Charset = DEFAULT_CHARSET
      NotificationText.Font.Color = clWhite
      NotificationText.Font.Height = -9
      NotificationText.Font.Name = 'Tahoma'
      NotificationText.Font.Style = []
      TextAndImageCenter.ImageMargin.Left = 5
      TextAndImageCenter.ImageMargin.Right = 5
    end
    object btn_RezeptDelete: TnfsButton
      AlignWithMargins = True
      Left = 120
      Top = 3
      Width = 50
      Height = 38
      Images = dm_Bilder.img
      ImageAlignment = iaCenter
      ImageIndex = 9
      ImagePos.Left = 0
      ImagePos.Right = 0
      ImagePos.Top = 6
      TextPos.Left = 0
      TextPos.Right = 0
      TextPos.Top = 25
      Caption1 = 'L'#246'schen'
      OnClick = btn_RezeptDeleteClick
      NumGlyphs = 1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      RoundRect = 0
      Align = alLeft
      NotificationText.CirclePos.Left = 0
      NotificationText.CirclePos.Right = 0
      NotificationText.CirclePos.Top = 0
      NotificationText.CircleMarginX = 3
      NotificationText.CircleMarginY = 3
      NotificationText.Font.Charset = DEFAULT_CHARSET
      NotificationText.Font.Color = clWhite
      NotificationText.Font.Height = -9
      NotificationText.Font.Name = 'Tahoma'
      NotificationText.Font.Style = []
      TextAndImageCenter.ImageMargin.Left = 5
      TextAndImageCenter.ImageMargin.Right = 5
    end
    object btn_RezeptEdit: TnfsButton
      AlignWithMargins = True
      Left = 59
      Top = 3
      Width = 55
      Height = 38
      Images = dm_Bilder.img
      ImageAlignment = iaCenter
      ImageIndex = 8
      ImagePos.Left = 0
      ImagePos.Right = 0
      ImagePos.Top = 6
      TextPos.Left = 0
      TextPos.Right = 0
      TextPos.Top = 25
      Caption1 = 'Bearbeiten'
      OnClick = btn_RezeptEditClick
      NumGlyphs = 1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      RoundRect = 0
      Align = alLeft
      NotificationText.CirclePos.Left = 0
      NotificationText.CirclePos.Right = 0
      NotificationText.CirclePos.Top = 0
      NotificationText.CircleMarginX = 3
      NotificationText.CircleMarginY = 3
      NotificationText.Font.Charset = DEFAULT_CHARSET
      NotificationText.Font.Color = clWhite
      NotificationText.Font.Height = -9
      NotificationText.Font.Name = 'Tahoma'
      NotificationText.Font.Style = []
      TextAndImageCenter.ImageMargin.Left = 5
      TextAndImageCenter.ImageMargin.Right = 5
    end
  end
end
