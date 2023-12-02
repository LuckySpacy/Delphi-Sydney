inherited fra_GDriveBaum2: Tfra_GDriveBaum2
  Width = 598
  Height = 335
  ExplicitWidth = 598
  ExplicitHeight = 335
  object vt: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 413
    Height = 335
    Align = alClient
    Colors.BorderColor = 15987699
    Colors.DisabledColor = clGray
    Colors.DropMarkColor = 15385233
    Colors.DropTargetColor = 15385233
    Colors.DropTargetBorderColor = 15385233
    Colors.FocusedSelectionColor = 15385233
    Colors.FocusedSelectionBorderColor = 15385233
    Colors.GridLineColor = 15987699
    Colors.HeaderHotColor = clBlack
    Colors.HotColor = clBlack
    Colors.SelectionRectangleBlendColor = 15385233
    Colors.SelectionRectangleBorderColor = 15385233
    Colors.SelectionTextColor = clBlack
    Colors.TreeLineColor = 9471874
    Colors.UnfocusedColor = clGray
    Colors.UnfocusedSelectionColor = 13421772
    Colors.UnfocusedSelectionBorderColor = 13421772
    Header.AutoSizeIndex = 0
    Header.MainColumn = -1
    TabOrder = 0
    OnChange = vtChange
    OnExpanded = vtExpanded
    OnFreeNode = vtFreeNode
    OnGetText = vtGetText
    OnInitNode = vtInitNode
    OnNodeClick = vtNodeClick
    Columns = <>
  end
  object Panel1: TPanel
    Left = 413
    Top = 0
    Width = 185
    Height = 335
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Btn_CreateFolder: TButton
      Left = 5
      Top = 16
      Width = 164
      Height = 25
      Hint = 'Einen Ordner erstellen'
      Caption = 'Ordner erstellen'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Btn_CreateFolderClick
    end
    object btn_Delete: TButton
      Left = 6
      Top = 47
      Width = 163
      Height = 25
      Hint = 'Eine Datei l'#246'schen'
      Caption = 'L'#246'schen'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btn_DeleteClick
    end
  end
end
