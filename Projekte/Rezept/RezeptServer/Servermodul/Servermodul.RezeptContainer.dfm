object RezeptServerContainer: TRezeptServerContainer
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSRezeptServer: TDSServer
    Left = 96
    Top = 11
  end
  object DSRezeptServerClass: TDSServerClass
    OnGetClass = DSRezeptServerClassGetClass
    Server = DSRezeptServer
    Left = 200
    Top = 11
  end
end
