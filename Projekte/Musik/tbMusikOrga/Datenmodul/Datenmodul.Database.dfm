object dm: Tdm
  OldCreateOrder = False
  Height = 211
  Width = 324
  object IB_MusikOrga: TIBDatabase
    DatabaseName = 
      'localhost:d:\Firebird\Entwicklung-Datenbank\tbMusikOrga\\MusikOr' +
      'ga.FDB'
    Params.Strings = (
      'user_name=sysdba')
    ServerType = 'IBServer'
    Left = 48
    Top = 32
  end
  object IBT_Standard: TIBTransaction
    DefaultDatabase = IB_MusikOrga
    Left = 168
    Top = 40
  end
end
