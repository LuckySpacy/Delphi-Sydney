inherited frm_Bild: Tfrm_Bild
  Caption = 'frm_Bild'
  ClientHeight = 185
  ClientWidth = 185
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 185
  ExplicitHeight = 185
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 185
    Height = 185
    Align = alClient
    ExplicitLeft = 144
    ExplicitTop = 56
    ExplicitWidth = 50
    ExplicitHeight = 50
  end
  object img: TImage
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 179
    Height = 179
    Align = alClient
    Proportional = True
    Stretch = True
    OnClick = imgClick
    OnDblClick = imgDblClick
    ExplicitWidth = 174
    ExplicitHeight = 158
  end
end
