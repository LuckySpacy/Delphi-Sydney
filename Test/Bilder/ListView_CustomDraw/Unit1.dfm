object Form1: TForm1
  Left = 57
  Top = 118
  Width = 482
  Height = 327
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    474
    300)
  PixelsPerInch = 96
  TextHeight = 13
  object Lv: TListView
    Left = 8
    Top = 8
    Width = 457
    Height = 273
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <>
    LargeImages = ImageList1
    TabOrder = 0
    OnCustomDrawItem = LvCustomDrawItem
  end
  object ImageList1: TImageList
    Height = 80
    Width = 140
    Left = 96
    Top = 24
  end
end
