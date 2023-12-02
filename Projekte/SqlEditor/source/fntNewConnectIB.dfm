object frmNewConnectIB: TfrmNewConnectIB
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Neue Verbindung'
  ClientHeight = 206
  ClientWidth = 269
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
  object lbl_Name: TLabel
    Left = 13
    Top = 24
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 13
    Top = 51
    Width = 103
    Height = 13
    Caption = 'Laufwerksbuchstabe:'
  end
  object Label1: TLabel
    Left = 13
    Top = 78
    Width = 36
    Height = 13
    Caption = 'Server:'
  end
  object Label3: TLabel
    Left = 13
    Top = 105
    Width = 57
    Height = 13
    Caption = 'Verzeichnis:'
  end
  object Label4: TLabel
    Left = 13
    Top = 132
    Width = 82
    Height = 13
    Caption = 'Datenbankname:'
  end
  object edt_DBName: TEdit
    Left = 130
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object cbb_Laufwerk: TComboBox
    Left = 130
    Top = 48
    Width = 52
    Height = 21
    Style = csDropDownList
    TabOrder = 1
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
    Left = 130
    Top = 75
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'edt_Server'
  end
  object edt_Verzeichnis: TEdit
    Left = 130
    Top = 102
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object edt_Datenbank: TEdit
    Left = 130
    Top = 129
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'edt_Datenbank'
  end
  object cmd_Cancel: TButton
    Left = 8
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 5
    OnClick = cmd_CancelClick
  end
  object cmd_Save: TButton
    Left = 176
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Speichern'
    TabOrder = 6
    OnClick = cmd_SaveClick
  end
end
