object frm_Uebersicht: Tfrm_Uebersicht
  Left = 0
  Top = 0
  Caption = 'frm_Uebersicht'
  ClientHeight = 590
  ClientWidth = 970
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 185
    Top = 0
    Height = 590
    ExplicitLeft = 264
    ExplicitTop = 120
    ExplicitHeight = 100
  end
  object pnl_Kategorie: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 590
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnl_Kategorie'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 104
    ExplicitTop = 120
    ExplicitHeight = 41
  end
  object pnl_Client: TPanel
    Left = 188
    Top = 0
    Width = 782
    Height = 590
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnl_Kategorie'
    ShowCaption = False
    TabOrder = 1
    OnResize = FormResize
    ExplicitLeft = 191
    object Edit1: TEdit
      Left = 208
      Top = 152
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
  end
end
