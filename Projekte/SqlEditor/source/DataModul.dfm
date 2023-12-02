object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 231
  Width = 221
  object IBDatabase: TIBDatabase
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'sql_dialect=1')
    LoginPrompt = False
    ServerType = 'IBServer'
    SQLDialect = 1
    Left = 88
    Top = 16
  end
  object ds_IB: TDataSource
    DataSet = IBQuery
    Left = 16
    Top = 8
  end
  object IBTransaction: TIBTransaction
    DefaultDatabase = IBDatabase
    Left = 32
    Top = 80
  end
  object IBQuery: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from kunden')
    Left = 88
    Top = 72
  end
  object IBQuery2: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from kunden')
    Left = 96
    Top = 120
  end
end
