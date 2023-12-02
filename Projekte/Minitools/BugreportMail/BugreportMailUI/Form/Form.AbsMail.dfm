object frm_AbsMail: Tfrm_AbsMail
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frm_AbsMail'
  ClientHeight = 408
  ClientWidth = 651
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 81
    Height = 408
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel5'
    ShowCaption = False
    TabOrder = 0
    object Label192: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 14
      Width = 68
      Height = 13
      Margins.Left = 10
      Margins.Top = 14
      Align = alTop
      Caption = 'Smtp:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 28
    end
    object Label193: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 40
      Width = 68
      Height = 13
      Margins.Left = 10
      Margins.Top = 10
      Align = alTop
      Caption = 'Benutzer:'
      ExplicitWidth = 47
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 96
      Width = 68
      Height = 13
      Margins.Left = 10
      Margins.Top = 12
      Align = alTop
      Caption = 'Passwort:'
      ExplicitWidth = 48
    end
    object lbl_MailPort: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 123
      Width = 68
      Height = 13
      Margins.Left = 10
      Margins.Top = 11
      Align = alTop
      Caption = 'Port:'
      ExplicitWidth = 24
    end
    object Label11: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 150
      Width = 68
      Height = 13
      Margins.Left = 10
      Margins.Top = 11
      Align = alTop
      Caption = 'TLS:'
      ExplicitWidth = 21
    end
    object Label12: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 177
      Width = 68
      Height = 13
      Margins.Left = 10
      Margins.Top = 11
      Align = alTop
      Caption = 'Auth.-Type:'
      ExplicitWidth = 59
    end
    object Label13: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 204
      Width = 68
      Height = 13
      Margins.Left = 10
      Margins.Top = 11
      Align = alTop
      Caption = 'SSL-Version:'
      ExplicitWidth = 60
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 68
      Width = 68
      Height = 13
      Margins.Left = 10
      Margins.Top = 12
      Align = alTop
      Caption = 'Absender Mail:'
      ExplicitWidth = 71
    end
  end
  object Panel7: TPanel
    Left = 598
    Top = 0
    Width = 53
    Height = 408
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel7'
    ShowCaption = False
    TabOrder = 1
    OnMouseDown = Panel7MouseDown
  end
  object Panel5: TPanel
    Left = 81
    Top = 0
    Width = 517
    Height = 408
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel5'
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      517
      408)
    object Label1: TLabel
      Left = 119
      Top = 237
      Width = 17
      Height = 13
      Caption = 'An:'
    end
    object Edt_SMTP: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 10
      Width = 511
      Height = 21
      Margins.Top = 10
      Align = alTop
      MaxLength = 80
      PasswordChar = '*'
      TabOrder = 0
      OnExit = EditExit
    end
    object Edt_User: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 37
      Width = 511
      Height = 21
      Align = alTop
      MaxLength = 80
      PasswordChar = '*'
      TabOrder = 1
      OnExit = EditExit
    end
    object Edt_Passwort: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 91
      Width = 511
      Height = 21
      Align = alTop
      MaxLength = 40
      PasswordChar = '*'
      TabOrder = 2
      OnExit = EditExit
    end
    object edt_Port: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 118
      Width = 511
      Height = 21
      Align = alTop
      MaxLength = 40
      TabOrder = 3
      OnExit = EditExit
    end
    object cbo_TLS: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 145
      Width = 511
      Height = 21
      Align = alTop
      Style = csDropDownList
      TabOrder = 4
      OnExit = cbo_TLSExit
      Items.Strings = (
        'NoTLSSupport'
        'UseImplicitTLS'
        'UseRequireTLS'
        'UseExplicitTLS')
    end
    object cbo_AuthType: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 172
      Width = 511
      Height = 21
      Align = alTop
      Style = csDropDownList
      TabOrder = 5
      OnExit = cbo_AuthTypeExit
      Items.Strings = (
        'Kein'
        'Default'
        'SASL')
    end
    object cbo_SSLVersion: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 199
      Width = 511
      Height = 21
      Align = alTop
      Style = csDropDownList
      TabOrder = 6
      OnExit = cbo_SSLVersionExit
      Items.Strings = (
        'sslvSSLv2'
        'sslvSSLv23'
        'sslvSSLv3'
        'sslvTLSv1'
        'sslvTLSv1_1'
        'sslvTLSv1_2'
        '')
    end
    object edt_AbsMail: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 64
      Width = 511
      Height = 21
      Align = alTop
      MaxLength = 40
      PasswordChar = '*'
      TabOrder = 7
      OnExit = EditExit
    end
    object btn_Mail: TButton
      Left = 3
      Top = 232
      Width = 110
      Height = 25
      Caption = 'Mailversand testen'
      TabOrder = 8
      OnClick = btn_MailClick
    end
    object edt_MailAn: TEdit
      AlignWithMargins = True
      Left = 142
      Top = 234
      Width = 369
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 40
      TabOrder = 9
      OnExit = EditExit
    end
  end
end
