object frm_BugreportMailUI: Tfrm_BugreportMailUI
  Left = 0
  Top = 0
  Caption = 'Bugreport - Einstellung'
  ClientHeight = 366
  ClientWidth = 415
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
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 409
    Height = 330
    ActivePage = tbs_Datei
    Align = alClient
    TabOrder = 0
    object tbs_MailAbsender: TTabSheet
      Caption = 'Mail Absender'
    end
    object tbs_Datei: TTabSheet
      Caption = 'Dateien'
      ImageIndex = 1
      ExplicitLeft = 1
      ExplicitTop = 25
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 336
    Width = 415
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object btn_Ok: TButton
      AlignWithMargins = True
      Left = 330
      Top = 3
      Width = 75
      Height = 24
      Margins.Right = 10
      Align = alRight
      Caption = 'Ok'
      TabOrder = 0
      OnClick = btn_OkClick
    end
  end
end
