object frm_MusikOrga: Tfrm_MusikOrga
  Left = 0
  Top = 0
  Caption = 'Musikverwaltung'
  ClientHeight = 583
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 96
    Top = 64
    object mnu_Audiodatei: TMenuItem
      Caption = 'Audiodatei'
      object mnu_AudiodateiEinlesen: TMenuItem
        Caption = 'Alles einlesen'
        OnClick = mnu_AudiodateiEinlesenClick
      end
    end
    object men_Einstellung: TMenuItem
      Caption = 'Einstellung'
      OnClick = men_EinstellungClick
    end
    object mnu_Eigenschaft: TMenuItem
      Caption = 'Eigenschaft'
      OnClick = mnu_EigenschaftClick
    end
  end
end
