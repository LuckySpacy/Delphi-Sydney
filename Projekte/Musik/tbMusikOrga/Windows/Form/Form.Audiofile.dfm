inherited frm_AudioFile: Tfrm_AudioFile
  Caption = 'frm_AudioFile'
  ClientHeight = 602
  ClientWidth = 595
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 595
  ExplicitHeight = 602
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 44
    Width = 589
    Height = 555
    ActivePage = tbs_Details
    Align = alClient
    TabOrder = 0
    object tbs_Einfach: TTabSheet
      Caption = 'Einfach'
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 5
        Width = 575
        Height = 89
        Margins.Top = 5
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 65
          Height = 89
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'Panel1'
          ShowCaption = False
          TabOrder = 0
          object Label1: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 8
            Width = 59
            Height = 13
            Margins.Top = 8
            Align = alTop
            Caption = 'Speicherort:'
            ExplicitTop = 3
          end
          object Label2: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 32
            Width = 59
            Height = 13
            Margins.Top = 8
            Align = alTop
            Caption = 'Dateiname:'
            ExplicitWidth = 55
          end
          object Label3: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 60
            Width = 59
            Height = 13
            Margins.Top = 12
            Align = alTop
            Caption = 'Typ:'
            ExplicitWidth = 22
          end
        end
        object Panel3: TPanel
          Left = 65
          Top = 0
          Width = 510
          Height = 89
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel1'
          ShowCaption = False
          TabOrder = 1
          object edt_Typ: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 57
            Width = 504
            Height = 21
            Align = alTop
            TabOrder = 0
            Text = 'edt_Typ'
          end
          object edt_Dateiname: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 30
            Width = 504
            Height = 21
            Align = alTop
            TabOrder = 1
            Text = 'Edit1'
          end
          object edt_Speicherort: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 504
            Height = 21
            Align = alTop
            TabOrder = 2
            Text = 'Edit1'
          end
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 400
        Width = 581
        Height = 127
        Align = alBottom
        Caption = 'Panel4'
        TabOrder = 1
        object Kommentar: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 573
          Height = 13
          Align = alTop
          Caption = 'Kommentar'
          ExplicitWidth = 54
        end
        object mem_Kommentar: TMemo
          Left = 1
          Top = 20
          Width = 579
          Height = 106
          Align = alClient
          Lines.Strings = (
            'mem_Kommentar')
          TabOrder = 0
        end
      end
      object Panel5: TPanel
        Left = 329
        Top = 97
        Width = 252
        Height = 303
        Align = alClient
        Caption = 'Panel4'
        TabOrder = 2
        DesignSize = (
          252
          303)
        object edt_Genre: TLabeledEdit
          Left = 6
          Top = 16
          Width = 235
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Genre'
          TabOrder = 0
        end
        object edt_Jahr: TLabeledEdit
          Left = 6
          Top = 64
          Width = 235
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 21
          EditLabel.Height = 13
          EditLabel.Caption = 'Jahr'
          TabOrder = 1
        end
        object edt_TrackNo: TLabeledEdit
          Left = 6
          Top = 112
          Width = 235
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 24
          EditLabel.Height = 13
          EditLabel.Caption = 'Song'
          TabOrder = 2
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 97
        Width = 329
        Height = 303
        Align = alLeft
        Caption = 'Panel4'
        TabOrder = 3
        DesignSize = (
          329
          303)
        object edt_Titel: TLabeledEdit
          Left = 6
          Top = 16
          Width = 317
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Titel'
          TabOrder = 0
        end
        object edt_Interpret: TLabeledEdit
          Left = 6
          Top = 64
          Width = 317
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 44
          EditLabel.Height = 13
          EditLabel.Caption = 'Interpret'
          TabOrder = 1
        end
        object edt_Album: TLabeledEdit
          Left = 6
          Top = 112
          Width = 317
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Album'
          TabOrder = 2
        end
      end
    end
    object tbs_Details: TTabSheet
      Caption = 'Details'
      ImageIndex = 1
    end
    object tbs_Klassifikation: TTabSheet
      Caption = 'Klassifikation'
      ImageIndex = 2
    end
    object tbs_Liedtext: TTabSheet
      Caption = 'Liedtext'
      ImageIndex = 3
      object mem_Liedtext: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 575
        Height = 521
        Align = alClient
        Lines.Strings = (
          'mem_Liedtext')
        TabOrder = 0
      end
    end
    object tbs_Bild: TTabSheet
      Caption = 'Bild'
      ImageIndex = 4
      object Image1: TImage
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 575
        Height = 521
        Align = alClient
        Proportional = True
        Stretch = True
        ExplicitLeft = 96
        ExplicitTop = 232
        ExplicitWidth = 105
        ExplicitHeight = 65
      end
    end
    object tbs_Benutzerdefiniert: TTabSheet
      Caption = 'Benutzerdefiniert'
      ImageIndex = 5
    end
  end
  object pnl_Button: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnl_Button'
    ShowCaption = False
    TabOrder = 1
    object btn_Zurueck: TnfsButton
      AlignWithMargins = True
      Left = 510
      Top = 5
      Width = 75
      Height = 31
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      ImagePos.Left = 8
      ImagePos.Right = 8
      ImagePos.Top = 0
      TextPos.Left = 0
      TextPos.Right = 0
      TextPos.Top = 0
      Caption1 = 'Zur'#252'ck'
      NumGlyphs = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      RoundRect = 0
      Align = alRight
      NotificationText.CirclePos.Left = 0
      NotificationText.CirclePos.Right = 0
      NotificationText.CirclePos.Top = 0
      NotificationText.CircleMarginX = 3
      NotificationText.CircleMarginY = 3
      NotificationText.Font.Charset = DEFAULT_CHARSET
      NotificationText.Font.Color = clWhite
      NotificationText.Font.Height = -9
      NotificationText.Font.Name = 'Tahoma'
      NotificationText.Font.Style = []
      TextAndImageCenter.ImageMargin.Left = 5
      TextAndImageCenter.ImageMargin.Right = 5
    end
    object btn_Save: TnfsButton
      AlignWithMargins = True
      Left = 10
      Top = 5
      Width = 75
      Height = 31
      Margins.Left = 10
      Margins.Top = 5
      Margins.Bottom = 5
      ImagePos.Left = 8
      ImagePos.Right = 8
      ImagePos.Top = 0
      TextPos.Left = 0
      TextPos.Right = 0
      TextPos.Top = 0
      Caption1 = 'Speichern'
      OnClick = btn_SaveClick
      NumGlyphs = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      RoundRect = 0
      Align = alLeft
      NotificationText.CirclePos.Left = 0
      NotificationText.CirclePos.Right = 0
      NotificationText.CirclePos.Top = 0
      NotificationText.CircleMarginX = 3
      NotificationText.CircleMarginY = 3
      NotificationText.Font.Charset = DEFAULT_CHARSET
      NotificationText.Font.Color = clWhite
      NotificationText.Font.Height = -9
      NotificationText.Font.Name = 'Tahoma'
      NotificationText.Font.Style = []
      TextAndImageCenter.ImageMargin.Left = 5
      TextAndImageCenter.ImageMargin.Right = 5
    end
  end
end
