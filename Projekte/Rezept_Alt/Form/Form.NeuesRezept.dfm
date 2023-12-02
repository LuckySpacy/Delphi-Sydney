object frm_NeuesRezept: Tfrm_NeuesRezept
  Left = 0
  Top = 0
  Caption = 'Neues Rezept'
  ClientHeight = 424
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 635
    Height = 424
    ActivePage = tbs_Titel
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 299
    object tbs_Titel: TTabSheet
      Caption = 'Titel'
      ExplicitHeight = 271
    end
    object tbs_Zutatenliste: TTabSheet
      Caption = 'Zutatenliste'
      ImageIndex = 1
    end
    object tbs_Zutaten: TTabSheet
      Caption = 'Zutaten'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object tbs_Kategoire: TTabSheet
      Caption = 'Kategorie Zuordnung'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
end
