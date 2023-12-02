object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 398
  Width = 581
  object IB_Rezept: TIBDatabase
    DatabaseName = 'localhost:D:\MeineProgramme\VServerStrato\Datenbank\REZEPT.FDB'
    Params.Strings = (
      'user_name=sysdba')
    ServerType = 'IBServer'
    Left = 48
    Top = 32
  end
  object IBT_Standard: TIBTransaction
    DefaultDatabase = IB_Rezept
    Left = 120
    Top = 32
  end
  object DB_MySql: TFDConnection
    Left = 72
    Top = 104
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
    Left = 448
    Top = 40
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 200
  end
  object DataSource1: TDataSource
    Left = 368
    Top = 248
  end
end
