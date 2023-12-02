object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 418
  Width = 615
  object Database: TIBDatabase
    DefaultTransaction = IBT
    ServerType = 'IBServer'
    Left = 40
    Top = 16
  end
  object IBT: TIBTransaction
    Left = 112
    Top = 16
  end
  object db: TFDConnection
    Left = 152
    Top = 160
  end
  object MySqlTrans: TFDTransaction
    Connection = db
    Left = 376
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 232
    Top = 56
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 360
    Top = 176
  end
end
