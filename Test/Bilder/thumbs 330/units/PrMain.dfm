object MainForm: TMainForm
  Left = 389
  Top = 129
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 566
  ClientWidth = 576
  Color = 14671839
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 310
    Top = 8
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Maximum Thumbs:'
    Transparent = True
  end
  object Label2: TLabel
    Left = 310
    Top = 32
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Verzeichnis f'#252'r Thumbs:'
    Transparent = True
  end
  object LabelDir: TLabel
    Left = 8
    Top = 532
    Width = 563
    Height = 13
    AutoSize = False
    Caption = 'C:\Dev\WorkTools'
    Transparent = True
  end
  object Label3: TLabel
    Left = 310
    Top = 56
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Prefix f'#252'r Thumbs:'
    Transparent = True
  end
  object Label4: TLabel
    Left = 310
    Top = 84
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Maximum Normalbilder:'
    Transparent = True
  end
  object Label5: TLabel
    Left = 310
    Top = 108
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Verzeichnis f'#252'r Normalbilder:'
    Transparent = True
  end
  object Label6: TLabel
    Left = 310
    Top = 132
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Prefix f'#252'r Normalbilder:'
    Transparent = True
  end
  object Label7: TLabel
    Left = 310
    Top = 160
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Maximum Bigbilder:'
    Transparent = True
  end
  object Label8: TLabel
    Left = 310
    Top = 184
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Verzeichnis f'#252'r Bigbilder:'
    Transparent = True
  end
  object Label9: TLabel
    Left = 310
    Top = 208
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Prefix f'#252'r Bigbilder:'
    Transparent = True
  end
  object StartButton: TSpeedButton
    Left = 206
    Top = 4
    Width = 100
    Height = 22
    Cursor = crHandPoint
    Caption = 'Starten'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Erstellen1Click
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 547
    Width = 576
    Height = 19
    Panels = <>
    SimplePanel = False
    SizeGrip = False
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 4
    Width = 193
    Height = 19
    BevelInner = bvNone
    BevelKind = bkFlat
    Color = 15724527
    DirList = DirBox
    TabOrder = 1
    TextCase = tcUpperCase
  end
  object DirBox: TDirectoryListBox
    Left = 8
    Top = 32
    Width = 296
    Height = 489
    BevelEdges = []
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Color = 15724527
    Ctl3D = False
    DirLabel = LabelDir
    FileList = FileBox
    ItemHeight = 16
    ParentCtl3D = False
    TabOrder = 2
    OnChange = DirBoxChange
  end
  object FileBox: TFileListBox
    Left = 308
    Top = 250
    Width = 260
    Height = 271
    TabStop = False
    BevelEdges = []
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Color = 15724527
    Ctl3D = False
    ExtendedSelect = False
    ItemHeight = 13
    Mask = '*.jpg'
    ParentCtl3D = False
    TabOrder = 3
    OnDblClick = FileBoxDblClick
  end
  object ThEdit: TSpinEdit
    Left = 466
    Top = 4
    Width = 100
    Height = 22
    TabStop = False
    Ctl3D = False
    MaxLength = 4
    MaxValue = 500
    MinValue = 50
    ParentCtl3D = False
    TabOrder = 4
    Value = 100
  end
  object ThPathEdit: TEdit
    Left = 466
    Top = 28
    Width = 100
    Height = 19
    BevelEdges = []
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 5
    Text = 'thumbs'
  end
  object ThPreEdit: TEdit
    Left = 466
    Top = 52
    Width = 100
    Height = 19
    BevelEdges = []
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 6
    Text = 't_'
  end
  object NormEdit: TSpinEdit
    Left = 466
    Top = 80
    Width = 100
    Height = 22
    TabStop = False
    Ctl3D = False
    MaxLength = 4
    MaxValue = 1000
    MinValue = 200
    ParentCtl3D = False
    TabOrder = 7
    Value = 480
  end
  object NormPathEdit: TEdit
    Left = 466
    Top = 104
    Width = 100
    Height = 19
    BevelEdges = []
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 8
  end
  object NormPreEdit: TEdit
    Left = 466
    Top = 128
    Width = 100
    Height = 19
    BevelEdges = []
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 9
  end
  object BigEdit: TSpinEdit
    Left = 466
    Top = 156
    Width = 100
    Height = 22
    TabStop = False
    Ctl3D = False
    MaxLength = 4
    MaxValue = 5000
    MinValue = 500
    ParentCtl3D = False
    TabOrder = 10
    Value = 1024
  end
  object BigPathEdit: TEdit
    Left = 466
    Top = 180
    Width = 100
    Height = 19
    BevelEdges = []
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 11
    Text = 'bigs'
  end
  object BigPreEdit: TEdit
    Left = 466
    Top = 204
    Width = 100
    Height = 19
    BevelEdges = []
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 12
    Text = 'b_'
  end
  object indexBox: TCheckBox
    Left = 329
    Top = 230
    Width = 212
    Height = 17
    Caption = 'index.html in jedes Verzeichnis kopieren'
    Checked = True
    State = cbChecked
    TabOrder = 13
  end
end
