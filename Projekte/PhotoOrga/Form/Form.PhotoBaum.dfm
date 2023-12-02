inherited frm_PhotoBaum: Tfrm_PhotoBaum
  Caption = 'frm_PhotoBaum'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object vt: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 598
    Height = 542
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
    PopupMenu = pop
    TabOrder = 0
    OnFocusChanging = vtFocusChanging
    OnFreeNode = vtFreeNode
    OnGetText = vtGetText
    OnInitNode = vtInitNode
    Columns = <>
  end
  object pop: TPopupMenu
    Left = 136
    Top = 88
    object pop_AlbumAufDieserEbeneErstellen: TMenuItem
      Caption = 'Album auf dieser Ebene erstellen'
      OnClick = pop_AlbumAufDieserEbeneErstellenClick
    end
    object pop_AlbumaufuntereEbeneErstellen: TMenuItem
      Caption = 'Album auf untere Ebene Erstellen'
      OnClick = pop_AlbumaufuntereEbeneErstellenClick
    end
    object pop_AlbumLoeschen: TMenuItem
      Caption = 'Album l'#246'schen'
      OnClick = pop_AlbumLoeschenClick
    end
    object pop_Bezeichnungndern: TMenuItem
      Caption = 'Bezeichnung '#228'ndern'
      OnClick = pop_BezeichnungndernClick
    end
  end
end
