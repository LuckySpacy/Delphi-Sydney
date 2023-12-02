object frm_Option: Tfrm_Option
  Left = 0
  Top = 0
  Caption = 'Option'
  ClientHeight = 215
  ClientWidth = 543
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
  DesignSize = (
    543
    215)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_Backupname: TLabel
    Left = 16
    Top = 20
    Width = 21
    Height = 13
    Caption = 'Von'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 47
    Width = 27
    Height = 13
    Caption = 'Nach'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 155
    Width = 50
    Height = 13
    Caption = 'Startzeit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label9: TLabel
    Left = 16
    Top = 102
    Width = 295
    Height = 13
    Caption = 'Anzahl der verbleibenden Dateien im Zielverzeichnis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 130
    Width = 310
    Height = 13
    Caption = 'Anzahl der verbleibendene Dateien im Quellverzeichnis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edt_von: TEdit
    Left = 129
    Top = 17
    Width = 406
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'edt_Datenbankname'
  end
  object edt_Nach: TAdvDirectoryEdit
    Left = 129
    Top = 44
    Width = 406
    Height = 21
    BorderColor = 11250603
    EmptyTextStyle = []
    FlatLineColor = 11250603
    FocusColor = clWindow
    FocusFontColor = 3881787
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Anchors = [akLeft, akTop, akRight]
    Color = clWindow
    ShortCut = 0
    TabOrder = 1
    Text = ''
    Visible = True
    Version = '1.6.2.0'
    ButtonStyle = bsButton
    ButtonWidth = 18
    Flat = False
    Etched = False
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
      FDFDFDFDFDFDFDFDFDFDB7B76F67676767676767676767B7FDFD6FFDBFBFBFBF
      BFBFBFBFBFB7FD6FFDFD6FFDBFBFBFBFBF7F7F7F7777FD6FFDFD6FFDBFBFBFBF
      BFBFBFBF7F7FFD6FFDFD6FFDFDFDBFBFBFBFBFBFBF7FFD6FFDFD6FFDFDFDFDFD
      BFBFBFBFBFBFFD6FFDFD6FFDB76F6FAFFDFDFDFDFDFDFD6FFDFD6FFDBFBFBFB7
      6F6F6F6F6F6F6F6F525277FDBFBFBFBFFD9BF79B52F75AA49B4977FDFDFDFDFD
      FD9BF5A35B6D9BF5A35177B7B7B7B7B7779BF5F7A4089BEDF75AFDFDFDFDFDFD
      FD9B9B5252A452525249FDFDFDFDFDFDFDF75AED9BA39AF75AA4FDFDFDFDFDFD
      FDFD9BA352A452A452FDFDFDFDFDFDFDFDFDFDA39B089B9BFDFD}
    ReadOnly = False
    ButtonColor = clWhite
    ButtonColorHot = 15917525
    ButtonColorDown = 14925219
    ButtonTextColor = 4474440
    ButtonTextColorHot = 2303013
    ButtonTextColorDown = 2303013
    BrowseDialogText = 'Select Directory'
  end
  object edt_Startzeit: TDateTimePicker
    Left = 137
    Top = 149
    Width = 77
    Height = 21
    Date = 38959.000000000000000000
    Time = 0.470059490740823100
    Kind = dtkTime
    TabOrder = 2
    Visible = False
  end
  object edt_Anzahl_Ziel: TSpinEdit
    Left = 332
    Top = 99
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 174
    Width = 543
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 4
    object btn_Ok: TButton
      AlignWithMargins = True
      Left = 458
      Top = 5
      Width = 75
      Height = 31
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Speichern'
      TabOrder = 0
      OnClick = btn_OkClick
    end
    object btn_Cancel: TButton
      AlignWithMargins = True
      Left = 377
      Top = 5
      Width = 75
      Height = 31
      Margins.Top = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Abbrechen'
      TabOrder = 1
      OnClick = btn_CancelClick
    end
  end
  object cbx_Verschieben: TCheckBox
    Left = 129
    Top = 71
    Width = 142
    Height = 17
    Caption = 'Dateien verschieben'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object edt_Anzahl_Quell: TSpinEdit
    Left = 332
    Top = 127
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 0
  end
  object cbx_Zippen: TCheckBox
    Left = 277
    Top = 71
    Width = 142
    Height = 17
    Caption = 'Dateien zippen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
end
