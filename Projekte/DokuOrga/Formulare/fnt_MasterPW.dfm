object frm_MasterPW: Tfrm_MasterPW
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Hauptpasswort'
  ClientHeight = 300
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 259
    Width = 387
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 48
    ExplicitTop = 240
    ExplicitWidth = 185
    DesignSize = (
      387
      41)
    object btn_Cancel: TTBButton
      Left = 193
      Top = 8
      Width = 99
      Height = 25
      Flat = True
      SelectColor = clSkyBlue
      DownColor = clSkyBlue
      BtnLabel.HAlign = tbHLeft
      BtnLabel.VAlign = tbVTop
      BtnLabel.HMargin = 3
      BtnLabel.VMargin = 0
      BtnLabel.Caption = 'Abbrechen'
      BtnLabel.HTextAlign = tbHTextCenter
      BtnLabel.VTextAlign = tbVTextCenter
      BtnLabel.Font.Charset = ANSI_CHARSET
      BtnLabel.Font.Color = clWindowText
      BtnLabel.Font.Height = -11
      BtnLabel.Font.Name = 'Verdana'
      BtnLabel.Font.Style = []
      BtnLabel.Wordwrap = True
      BtnImage.AlignLeft = True
      BtnImage.AlignRight = False
      BtnImage.Margin = 10
      BtnImage.Height = 16
      BtnImage.Width = 16
      Images = dm.Img_Small
      ImageIndex = 1
      OnClick = btn_CancelClick
      Anchors = [akTop, akRight]
      ExplicitLeft = 310
    end
    object btn_Ok: TTBButton
      Left = 298
      Top = 8
      Width = 75
      Height = 25
      Flat = True
      SelectColor = clSkyBlue
      DownColor = clSkyBlue
      BtnLabel.HAlign = tbHLeft
      BtnLabel.VAlign = tbVTop
      BtnLabel.HMargin = 0
      BtnLabel.VMargin = 0
      BtnLabel.Caption = 'Ok'
      BtnLabel.HTextAlign = tbHTextCenter
      BtnLabel.VTextAlign = tbVTextCenter
      BtnLabel.Font.Charset = ANSI_CHARSET
      BtnLabel.Font.Color = clWindowText
      BtnLabel.Font.Height = -11
      BtnLabel.Font.Name = 'Verdana'
      BtnLabel.Font.Style = []
      BtnLabel.Wordwrap = True
      BtnImage.AlignLeft = True
      BtnImage.AlignRight = False
      BtnImage.Margin = 15
      BtnImage.Height = 16
      BtnImage.Width = 16
      Images = dm.Img_Small
      ImageIndex = 0
      OnClick = btn_OkClick
      Anchors = [akTop, akRight]
      ExplicitLeft = 415
    end
  end
end
