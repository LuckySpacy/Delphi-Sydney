object frm_Reportdesigner: Tfrm_Reportdesigner
  Left = 0
  Top = 0
  Caption = 'Reportdesigner'
  ClientHeight = 489
  ClientWidth = 1035
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object frxPreview1: TfrxPreview
    Left = 392
    Top = 0
    Width = 521
    Height = 231
    OutlineVisible = True
    OutlineWidth = 121
    ThumbnailVisible = False
    FindFmVisible = False
    UseReportHints = True
    HideScrolls = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1035
    Height = 489
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 56
    Top = 51
    object File1: TMenuItem
      Caption = 'File'
      object NewMI: TMenuItem
        Caption = 'New...'
      end
      object NewReportMI: TMenuItem
        Caption = 'New Report'
      end
      object NewPageMI: TMenuItem
        Caption = 'New Page'
      end
      object NewDialogMI: TMenuItem
        Caption = 'New Dialog'
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object OpenMI: TMenuItem
        Caption = 'Open...'
        Visible = False
      end
      object mnu_Open2: TMenuItem
        Caption = 'Open'
        OnClick = mnu_Open2Click
      end
      object SaveMI: TMenuItem
        Caption = 'Save'
        OnClick = SaveMIClick
      end
      object save1: TMenuItem
        Caption = 'Save as...'
        OnClick = save1Click
      end
      object SaveasMI: TMenuItem
        Caption = 'Save as...'
        Visible = False
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object PreviewMI: TMenuItem
        Caption = 'Preview'
      end
      object PagesettingsMI: TMenuItem
        Caption = 'Page settings...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object ExitMI: TMenuItem
        Caption = 'Exit'
        OnClick = ExitMIClick
      end
      object ESt1: TMenuItem
        Caption = 'TESt'
        Visible = False
        OnClick = ESt1Click
      end
      object RecentFiles1: TMenuItem
        Caption = 'RecentFiles'
        Visible = False
        OnClick = RecentFiles1Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object mnu_LastFiles: TMenuItem
        Caption = 'Last Reports'
        object mnu_File1: TMenuItem
          Caption = 'File1'
        end
        object mnu_File2: TMenuItem
          Caption = 'File2'
        end
        object mnu_File3: TMenuItem
          Caption = 'File3'
        end
        object mnu_File4: TMenuItem
          Caption = 'File4'
        end
        object mnu_File5: TMenuItem
          Caption = 'File5'
        end
        object mnu_File6: TMenuItem
          Caption = 'File6'
        end
        object mnu_File7: TMenuItem
          Caption = 'File7'
        end
        object mnu_File8: TMenuItem
          Caption = 'File8'
        end
        object mnu_File9: TMenuItem
          Caption = 'File9'
        end
        object mnu_File10: TMenuItem
          Caption = 'File10'
        end
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object UndoMI: TMenuItem
        Caption = 'Undo'
      end
      object RedoMI: TMenuItem
        Caption = 'Redo'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object CutMI: TMenuItem
        Caption = 'Cut'
      end
      object CopyMI: TMenuItem
        Caption = 'Copy'
      end
      object PasteMI: TMenuItem
        Caption = 'Paste'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object DeleteMI: TMenuItem
        Caption = 'Delete'
      end
      object DeletePageMI: TMenuItem
        Caption = 'Delete Page'
      end
      object SelectAllMI: TMenuItem
        Caption = 'Select All'
      end
      object GroupMI: TMenuItem
        Caption = 'Group'
      end
      object UngroupMI: TMenuItem
        Caption = 'Ungroup'
      end
      object EditMI: TMenuItem
        Caption = 'Edit'
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object FindMI: TMenuItem
        Caption = 'Find'
      end
      object ReplaceMI: TMenuItem
        Caption = 'Replace'
      end
      object FindNextMI: TMenuItem
        Caption = 'Find Next'
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object BringtoFrontMI: TMenuItem
        Caption = 'Bring to Front'
      end
      object SendtoBackMI: TMenuItem
        Caption = 'Send to Back'
      end
    end
    object Report1: TMenuItem
      Caption = 'Report'
      object DataMI: TMenuItem
        Caption = 'Data...'
      end
      object VariablesMI: TMenuItem
        Caption = 'Variables...'
      end
      object StylesMI: TMenuItem
        Caption = 'Styles...'
      end
      object ReportOptionsMI: TMenuItem
        Caption = 'Options...'
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object ToolbarsMI: TMenuItem
        Caption = 'Toolbars'
        object StandardMI: TMenuItem
          Caption = 'Standard'
        end
        object TextMI: TMenuItem
          Caption = 'Text'
        end
        object FrameMI: TMenuItem
          Caption = 'Frame'
        end
        object AlignmentPaletteMI: TMenuItem
          Caption = 'Alignment Palette'
        end
        object ObjectInspectorMI: TMenuItem
          Caption = 'Object Inspector'
        end
        object DataTreeMI: TMenuItem
          Caption = 'Data Tree'
        end
        object ReportTreeMI: TMenuItem
          Caption = 'Report Tree'
        end
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object RulersMI: TMenuItem
        Caption = 'Rulers'
      end
      object GuidesMI: TMenuItem
        Caption = 'Guides'
      end
      object DeleteGuidesMI: TMenuItem
        Caption = 'Delete Guides'
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object OptionsMI: TMenuItem
        Caption = 'Options...'
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object HelpContentsMI: TMenuItem
        Caption = 'Help Contents...'
      end
      object AboutFastReportMI: TMenuItem
        Caption = 'About FastReport...'
      end
    end
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 232
    Top = 112
  end
  object frxReport1: TfrxReport
    Version = '6.7.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    OldStyleProgress = True
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44028.399086863430000000
    ReportOptions.LastChange = 44028.399086863430000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 192
    Top = 40
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object ActionList1: TActionList
    Left = 48
    Top = 272
    object actOpen: TAction
      Caption = 'Open'
      ImageIndex = 1
      OnExecute = actOpenExecute
    end
  end
  object frxRichObject1: TfrxRichObject
    Left = 464
    Top = 136
  end
  object frxDBXComponents1: TfrxDBXComponents
    Left = 728
    Top = 72
  end
  object frxIBXComponents1: TfrxIBXComponents
    Left = 712
    Top = 144
  end
  object frxBMPExport1: TfrxBMPExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 768
    Top = 208
  end
  object frxTIFFExport1: TfrxTIFFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 880
    Top = 160
  end
  object frxPNGExport1: TfrxPNGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 736
    Top = 304
  end
  object frxZipCodeObject1: TfrxZipCodeObject
    Left = 472
    Top = 288
  end
  object frxReportTableObject1: TfrxReportTableObject
    Left = 544
    Top = 200
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 480
    Top = 48
  end
  object frxCrossObject1: TfrxCrossObject
    Left = 640
    Top = 104
  end
  object frxGaugeObject1: TfrxGaugeObject
    Left = 856
    Top = 328
  end
  object frxMapObject1: TfrxMapObject
    Left = 672
    Top = 336
  end
  object frxReportCellularTextObject1: TfrxReportCellularTextObject
    Left = 616
    Top = 280
  end
  object frxCheckBoxObject1: TfrxCheckBoxObject
    Left = 568
    Top = 360
  end
  object frxGradientObject1: TfrxGradientObject
    Left = 368
    Top = 320
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 432
    Top = 248
  end
  object frxChartObject1: TfrxChartObject
    Left = 824
    Top = 288
  end
  object frxCrypt1: TfrxCrypt
    Left = 840
    Top = 400
  end
end
