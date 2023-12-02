object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 421
  ClientWidth = 627
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
  object btn_Firebird: TButton
    Left = 16
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Firebird'
    TabOrder = 0
    OnClick = btn_FirebirdClick
  end
  object btn_MySql: TButton
    Left = 120
    Top = 8
    Width = 75
    Height = 25
    Caption = 'MySql'
    TabOrder = 1
    OnClick = btn_MySqlClick
  end
  object Button1: TButton
    Left = 16
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object IB_Rezept: TIBDatabase
    DatabaseName = 'localhost:D:\MeineProgramme\VServerStrato\Datenbank\REZEPT.FDB'
    Params.Strings = (
      'user_name=sysdba')
    ServerType = 'IBServer'
    Left = 208
    Top = 232
  end
  object IBT_Standard: TIBTransaction
    DefaultDatabase = IB_Rezept
    Left = 480
    Top = 152
  end
  object DB_MySql: TFDConnection
    Left = 376
    Top = 120
  end
  object FDTransaction1: TFDTransaction
    Connection = DB_MySql
    Left = 208
    Top = 120
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 296
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 384
    Top = 40
  end
  object qry: TFDQuery
    Connection = DB_MySql
    Transaction = FDTransaction1
    Left = 504
    Top = 16
  end
end
