object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 435
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object btn_Start: TButton
      Left = 8
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = btn_StartClick
    end
    object btn_Test: TButton
      Left = 89
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Test'
      TabOrder = 1
      OnClick = btn_TestClick
    end
  end
  object mem: TMemo
    Left = 0
    Top = 41
    Width = 635
    Height = 394
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'mem')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
