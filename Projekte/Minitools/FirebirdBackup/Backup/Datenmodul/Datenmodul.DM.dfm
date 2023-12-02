object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object db: TIBDatabase
    DatabaseName = 'localhost:d:\MeineProgramme\VServerStrato\Datenbank\DOKUORGA.FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    AfterConnect = dbAfterConnect
    Left = 56
    Top = 48
  end
end
