object dm_Datenbank: Tdm_Datenbank
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 437
  Width = 447
  object db: TIBDatabase
    DatabaseName = 'localhost:d:\temp\Test2.fdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 48
    Top = 32
  end
  object IBqry_Read: TIBQuery
    Database = db
    Transaction = IBTrans_Read
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 112
    Top = 32
  end
  object IBTrans_Read: TIBTransaction
    DefaultDatabase = db
    Left = 56
    Top = 112
  end
  object IBTrans_Write: TIBTransaction
    DefaultDatabase = db
    Left = 136
    Top = 120
  end
  object IBqry_Write: TIBQuery
    Database = db
    Transaction = IBTrans_Write
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 184
    Top = 32
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=IB'
      'CharacterSet=UTF8'
      
        'Database=localhost:d:\Bachmann\Daten\OneDrive\Asus-PC-2018\Progr' +
        'ammierung\Delphi\Sydney\Projekte\HarddriveClone2\bin\HARDDRIVECL' +
        'ONE2.FDB'
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    Left = 216
    Top = 104
  end
  object dbx: TUniConnection
    ProviderName = 'InterBase'
    Database = 
      'd:\Bachmann\Daten\OneDrive\Asus-PC-2018\Programmierung\Delphi\Sy' +
      'dney\Projekte\HarddriveClone2\bin\HARDDRIVECLONE2.FDB'
    Username = 'sysdba'
    Server = 'localhost'
    LoginPrompt = False
    Left = 336
    Top = 240
    EncryptedPassword = '92FF9EFF8CFF8BFF9AFF8DFF94FF9AFF86FF'
  end
  object Trans_Read: TUniTransaction
    DefaultConnection = dbx
    ReadOnly = True
    Left = 176
    Top = 272
  end
  object qry_Read: TUniQuery
    Connection = dbx
    Transaction = Trans_Read
    Left = 72
    Top = 248
  end
  object Trans_Write: TUniTransaction
    DefaultConnection = dbx
    Left = 264
    Top = 320
  end
  object qry_Write: TUniQuery
    Connection = dbx
    Transaction = Trans_Write
    Left = 96
    Top = 312
  end
end
