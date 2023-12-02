object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 398
  Width = 581
  object IB_MusikOrga: TIBDatabase
    DatabaseName = 
      'localhost:d:\Firebird\Entwicklung-Datenbank\tbMusikOrga\MusikOrg' +
      'a.fdb'
    Params.Strings = (
      'user_name=sysdba')
    ServerType = 'IBServer'
    Left = 48
    Top = 32
  end
  object IBT_Standard: TIBTransaction
    DefaultDatabase = IB_MusikOrga
    Left = 120
    Top = 32
  end
end
