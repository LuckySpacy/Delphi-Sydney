object frm_Einstellung: Tfrm_Einstellung
  Left = 0
  Top = 0
  Caption = 'Einstellung'
  ClientHeight = 440
  ClientWidth = 739
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Button: TPanel
    Left = 0
    Top = 0
    Width = 739
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnl_Button'
    ShowCaption = False
    TabOrder = 0
    OnDblClick = pnl_ButtonDblClick
    ExplicitWidth = 635
    object btn_Pfad: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 50
      Height = 44
      Align = alLeft
      Caption = 'Pfad'
      TabOrder = 0
      OnClick = btn_PfadClick
    end
    object btn_Schnittstelle: TButton
      AlignWithMargins = True
      Left = 59
      Top = 3
      Width = 70
      Height = 44
      Align = alLeft
      Caption = 'Schnittstelle'
      TabOrder = 1
      OnClick = btn_SchnittstelleClick
    end
    object btn_AkSt: TButton
      AlignWithMargins = True
      Left = 135
      Top = 3
      Width = 122
      Height = 44
      Align = alLeft
      Caption = 'Aktie --> Schnittstelle'
      TabOrder = 2
      OnClick = btn_AkStClick
    end
    object btn_KurseLoeschen: TButton
      AlignWithMargins = True
      Left = 263
      Top = 3
      Width = 82
      Height = 44
      Align = alLeft
      Caption = 'Kurse l'#246'schen'
      TabOrder = 3
      OnClick = btn_KurseLoeschenClick
    end
    object btn_Aktie: TButton
      AlignWithMargins = True
      Left = 351
      Top = 3
      Width = 82
      Height = 44
      Align = alLeft
      Caption = 'Aktien'
      TabOrder = 4
      OnClick = btn_AktieClick
    end
    object btn_Dateiformat: TButton
      AlignWithMargins = True
      Left = 439
      Top = 3
      Width = 90
      Height = 44
      Align = alLeft
      Caption = 'Dateiformat'
      TabOrder = 5
      OnClick = btn_DateiformatClick
    end
  end
end
