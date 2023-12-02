inherited frm_Bilder: Tfrm_Bilder
  Caption = 'frm_Bilder'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object sc: TScrollBox
    Left = 0
    Top = 0
    Width = 598
    Height = 542
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 0
    OnMouseMove = scMouseMove
    OnMouseWheel = scMouseWheel
    OnResize = scResize
  end
end
