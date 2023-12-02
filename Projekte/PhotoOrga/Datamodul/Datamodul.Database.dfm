object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 254
  Width = 330
  object IB_PhotoOrga: TIBDatabase
    DatabaseName = 
      'localhost:d:\Bachmann\Daten\OneDrive\Asus-PC-2018\Programmierung' +
      '\Delphi\Sydney\Projekte\PhotoOrga\bin\PHOTOORGA2.FDB'
    Params.Strings = (
      'user_name=sysdba')
    ServerType = 'IBServer'
    Left = 48
    Top = 32
  end
  object IBT_Standard: TIBTransaction
    DefaultDatabase = IB_PhotoOrga
    Left = 128
    Top = 32
  end
end
