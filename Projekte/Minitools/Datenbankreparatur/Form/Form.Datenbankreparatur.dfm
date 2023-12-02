object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 413
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object btn_Vorgangpos: TButton
    Left = 104
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Vorgangpos'
    TabOrder = 1
    OnClick = btn_VorgangposClick
  end
  object pg: TProgressBar
    Left = 8
    Top = 368
    Width = 574
    Height = 17
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 8
    Top = 48
    Width = 574
    Height = 298
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 3
  end
  object btn_Abbruch: TButton
    Left = 200
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Abbruch'
    TabOrder = 4
    OnClick = btn_AbbruchClick
  end
  object IBD: TIBDatabase
    DatabaseName = '172.16.10.17:e:/Datenbank/demo4.fdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'sql_dialect=1')
    LoginPrompt = False
    ServerType = 'IBServer'
    SQLDialect = 1
    TraceFlags = [tfQExecute, tfTransact]
    Left = 376
    Top = 56
  end
  object IBD_Alt: TIBDatabase
    DatabaseName = 'localhost:c:\datenbank\REHATEC_vorUpdate.fdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'sql_dialect=1')
    LoginPrompt = False
    ServerType = 'IBServer'
    SQLDialect = 1
    TraceFlags = [tfQExecute, tfTransact]
    Left = 464
    Top = 48
  end
  object Trans: TIBTransaction
    DefaultDatabase = IBD
    Left = 336
    Top = 128
  end
  object Trans_Alt: TIBTransaction
    DefaultDatabase = IBD_Alt
    Left = 464
    Top = 120
  end
  object qry: TIBQuery
    Database = IBD
    Transaction = Trans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 352
    Top = 216
  end
  object qry_Alt: TIBQuery
    Database = IBD_Alt
    Transaction = Trans_Alt
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 424
    Top = 208
  end
end
