object frmConnectIB: TfrmConnectIB
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmConnectIB'
  ClientHeight = 262
  ClientWidth = 350
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
  object Label5: TLabel
    Left = 24
    Top = 11
    Width = 40
    Height = 13
    Caption = 'DBName'
  end
  object Label2: TLabel
    Left = 24
    Top = 75
    Width = 103
    Height = 13
    Caption = 'Laufwerksbuchstabe:'
  end
  object Label1: TLabel
    Left = 24
    Top = 102
    Width = 36
    Height = 13
    Caption = 'Server:'
  end
  object Label3: TLabel
    Left = 24
    Top = 129
    Width = 57
    Height = 13
    Caption = 'Verzeichnis:'
  end
  object Label4: TLabel
    Left = 24
    Top = 156
    Width = 82
    Height = 13
    Caption = 'Datenbankname:'
  end
  object cbx_DBName: TComboBox
    Left = 70
    Top = 8
    Width = 192
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnChange = cbx_DBNameChange
  end
  object cmdNew: TButton
    Left = 266
    Top = 6
    Width = 57
    Height = 25
    Caption = 'Neu'
    TabOrder = 1
    OnClick = cmdNewClick
  end
  object cbb_Laufwerk: TComboBox
    Left = 141
    Top = 72
    Width = 52
    Height = 21
    Style = csDropDownList
    TabOrder = 2
    Items.Strings = (
      'A:'
      'B:'
      'C:'
      'D:'
      'E:'
      'F:'
      'G:'
      'H:'
      'I:'
      'J:'
      'K:'
      'L:'
      'M:'
      'N:'
      'O:'
      'P:'
      'Q:'
      'R:'
      'S:'
      'T:'
      'U:'
      'V:'
      'W:'
      'X:'
      'Y:'
      'Z:')
  end
  object edt_Server: TEdit
    Left = 141
    Top = 99
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'edt_Server'
  end
  object edt_Verzeichnis: TEdit
    Left = 141
    Top = 126
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
  object edt_Datenbank: TEdit
    Left = 141
    Top = 153
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'edt_Datenbank'
  end
  object cmd_Cancel: TAdvGlowButton
    Left = 24
    Top = 192
    Width = 100
    Height = 41
    Caption = 'Abbrechen'
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    TabOrder = 6
    OnClick = cmd_CancelClick
    Appearance.ColorChecked = 16111818
    Appearance.ColorCheckedTo = 16367008
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16111818
    Appearance.ColorDownTo = 16367008
    Appearance.ColorHot = 16117985
    Appearance.ColorHotTo = 16372402
    Appearance.ColorMirrorHot = 16107693
    Appearance.ColorMirrorHotTo = 16775412
    Appearance.ColorMirrorDown = 16102556
    Appearance.ColorMirrorDownTo = 16768988
    Appearance.ColorMirrorChecked = 16102556
    Appearance.ColorMirrorCheckedTo = 16768988
    Appearance.ColorMirrorDisabled = 11974326
    Appearance.ColorMirrorDisabledTo = 15921906
  end
  object cmd_Ok: TAdvGlowButton
    Left = 162
    Top = 192
    Width = 100
    Height = 41
    Caption = 'Ok'
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    TabOrder = 7
    OnClick = cmd_OkClick
    Appearance.ColorChecked = 16111818
    Appearance.ColorCheckedTo = 16367008
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16111818
    Appearance.ColorDownTo = 16367008
    Appearance.ColorHot = 16117985
    Appearance.ColorHotTo = 16372402
    Appearance.ColorMirrorHot = 16107693
    Appearance.ColorMirrorHotTo = 16775412
    Appearance.ColorMirrorDown = 16102556
    Appearance.ColorMirrorDownTo = 16768988
    Appearance.ColorMirrorChecked = 16102556
    Appearance.ColorMirrorCheckedTo = 16768988
    Appearance.ColorMirrorDisabled = 11974326
    Appearance.ColorMirrorDisabledTo = 15921906
  end
end
