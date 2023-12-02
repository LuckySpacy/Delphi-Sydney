object frm_Vergleichsliste: Tfrm_Vergleichsliste
  Left = 0
  Top = 0
  Caption = 'frm_Vergleichsliste'
  ClientHeight = 521
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lst_Ziel: TListBox
    Left = 0
    Top = 0
    Width = 297
    Height = 521
    Align = alLeft
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = lst_ZielDblClick
  end
  object lst_Quelle: TListBox
    Left = 321
    Top = 0
    Width = 314
    Height = 521
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = lst_QuelleDblClick
  end
  object Panel1: TPanel
    Left = 297
    Top = 0
    Width = 24
    Height = 521
    Align = alLeft
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
  end
end
