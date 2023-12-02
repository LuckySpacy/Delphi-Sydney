object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 359
  Width = 561
  object DatabaseKurse: TIBDatabase
    DefaultTransaction = IBTKursex
    ServerType = 'IBServer'
    Left = 40
    Top = 16
  end
  object IBTKursex: TIBTransaction
    DefaultDatabase = DatabaseKurse
    Left = 112
    Top = 16
  end
  object DatabaseTSI: TIBDatabase
    DatabaseName = 'localhost:d:\db\tsi.fdb'
    Params.Strings = (
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTKursex
    ServerType = 'IBServer'
    Left = 40
    Top = 88
  end
  object IBTTSI: TIBTransaction
    DefaultDatabase = DatabaseTSI
    Left = 120
    Top = 88
  end
  object IBQuery1: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 264
    Top = 112
  end
  object db: TFDConnection
    Left = 152
    Top = 160
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 360
    Top = 176
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 232
    Top = 56
  end
  object MySqlTrans: TFDTransaction
    Connection = db
    Left = 376
    Top = 40
  end
end
