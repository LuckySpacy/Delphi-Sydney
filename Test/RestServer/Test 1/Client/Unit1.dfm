object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 219
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 51
    Width = 7
    Height = 13
    Caption = 'A'
  end
  object Label2: TLabel
    Left = 48
    Top = 78
    Width = 6
    Height = 13
    Caption = 'B'
  end
  object Label3: TLabel
    Left = 48
    Top = 146
    Width = 41
    Height = 13
    Caption = 'Ergebnis'
  end
  object EditA: TEdit
    Left = 136
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'EditA'
  end
  object EditB: TEdit
    Left = 136
    Top = 75
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 48
    Top = 112
    Width = 209
    Height = 25
    Caption = 'Rechnen'
    TabOrder = 2
    OnClick = Button1Click
  end
  object EditResult: TEdit
    Left = 136
    Top = 143
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
end
