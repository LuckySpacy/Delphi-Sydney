object frm_MailOffice365: Tfrm_MailOffice365
  Left = 0
  Top = 0
  Caption = 'Mail Office 365'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 635
    Height = 299
    ActivePage = tbs_Einstellung
    Align = alClient
    TabOrder = 0
    object tbs_Mail: TTabSheet
      Caption = 'Mail'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 627
        Height = 129
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 56
          Height = 129
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'Panel2'
          ShowCaption = False
          TabOrder = 0
          object Label1: TLabel
            AlignWithMargins = True
            Left = 10
            Top = 25
            Width = 43
            Height = 13
            Margins.Left = 10
            Margins.Top = 25
            Align = alTop
            Caption = 'An:'
            ExplicitWidth = 17
          end
          object Label2: TLabel
            AlignWithMargins = True
            Left = 10
            Top = 52
            Width = 43
            Height = 13
            Margins.Left = 10
            Margins.Top = 11
            Align = alTop
            Caption = 'CC:'
            ExplicitWidth = 18
          end
          object Label3: TLabel
            AlignWithMargins = True
            Left = 10
            Top = 78
            Width = 43
            Height = 13
            Margins.Left = 10
            Margins.Top = 10
            Align = alTop
            Caption = 'BCC:'
            ExplicitWidth = 24
          end
          object Label4: TLabel
            AlignWithMargins = True
            Left = 10
            Top = 104
            Width = 43
            Height = 13
            Margins.Left = 10
            Margins.Top = 10
            Align = alTop
            Caption = 'Betreff:'
            ExplicitWidth = 38
          end
        end
        object Panel3: TPanel
          Left = 56
          Top = 0
          Width = 571
          Height = 129
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel3'
          ShowCaption = False
          TabOrder = 1
          object edt_Betreff: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 101
            Width = 565
            Height = 21
            Align = alTop
            TabOrder = 0
            Text = 'edt_Betreff'
          end
          object edt_An: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 20
            Width = 565
            Height = 21
            Margins.Top = 20
            Align = alTop
            TabOrder = 1
            Text = 'edt_An'
          end
          object edt_CC: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 47
            Width = 565
            Height = 21
            Align = alTop
            TabOrder = 2
            Text = 'edt_An'
          end
          object edt_BCC: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 74
            Width = 565
            Height = 21
            Align = alTop
            TabOrder = 3
            Text = 'edt_An'
          end
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 129
        Width = 56
        Height = 142
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel2'
        ShowCaption = False
        TabOrder = 1
        object btn_Senden: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 50
          Height = 25
          Align = alTop
          Caption = 'Senden'
          TabOrder = 0
          OnClick = btn_SendenClick
        end
      end
      object mem_Body: TMemo
        AlignWithMargins = True
        Left = 59
        Top = 132
        Width = 565
        Height = 136
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'mem_Body')
        ParentFont = False
        TabOrder = 2
      end
    end
    object tbs_Einstellung: TTabSheet
      Caption = 'Einstellung'
      ImageIndex = 1
      object Panel5: TPanel
        Left = 81
        Top = 0
        Width = 493
        Height = 271
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel5'
        ShowCaption = False
        TabOrder = 0
        object Edt_SMTP: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 10
          Width = 487
          Height = 21
          Margins.Top = 10
          Align = alTop
          MaxLength = 80
          TabOrder = 0
        end
        object Edt_User: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 37
          Width = 487
          Height = 21
          Align = alTop
          MaxLength = 80
          TabOrder = 1
        end
        object Edt_Passwort: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 91
          Width = 487
          Height = 21
          Align = alTop
          MaxLength = 40
          TabOrder = 2
        end
        object edt_Port: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 118
          Width = 487
          Height = 21
          Align = alTop
          MaxLength = 40
          TabOrder = 3
        end
        object cbo_TLS: TComboBox
          AlignWithMargins = True
          Left = 3
          Top = 145
          Width = 487
          Height = 21
          Align = alTop
          Style = csDropDownList
          TabOrder = 4
          Items.Strings = (
            'Verwenden (NoTLSSupport)'
            'Explizit verwenden (UseExplicitTLS)'
            'Impliziert verwenden (UseImplicitTLS)'
            'Ben'#246'tigt (UseRequireTLS)')
        end
        object cbo_AuthType: TComboBox
          AlignWithMargins = True
          Left = 3
          Top = 172
          Width = 487
          Height = 21
          Align = alTop
          Style = csDropDownList
          TabOrder = 5
          Items.Strings = (
            'Verwenden (NoTLSSupport)'
            'Explizit verwenden (UseExplicitTLS)'
            'Impliziert verwenden (UseImplicitTLS)'
            'Ben'#246'tigt (UseRequireTLS)')
        end
        object cbo_SSLVersion: TComboBox
          AlignWithMargins = True
          Left = 3
          Top = 199
          Width = 487
          Height = 21
          Align = alTop
          Style = csDropDownList
          TabOrder = 6
          Items.Strings = (
            'Verwenden (NoTLSSupport)'
            'Explizit verwenden (UseExplicitTLS)'
            'Impliziert verwenden (UseImplicitTLS)'
            'Ben'#246'tigt (UseRequireTLS)')
        end
        object edt_AbsMail: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 64
          Width = 487
          Height = 21
          Align = alTop
          MaxLength = 40
          TabOrder = 7
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 81
        Height = 271
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel5'
        ShowCaption = False
        TabOrder = 1
        object Label192: TLabel
          AlignWithMargins = True
          Left = 10
          Top = 14
          Width = 68
          Height = 13
          Margins.Left = 10
          Margins.Top = 14
          Align = alTop
          Caption = 'Server:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 36
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
        Left = 574
        Top = 0
        Width = 53
        Height = 271
        Align = alRight
        BevelOuter = bvNone
        Caption = 'Panel7'
        ShowCaption = False
        TabOrder = 2
      end
    end
  end
end
