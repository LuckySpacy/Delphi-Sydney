unit Form.PhotoBaum;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.ChildBase, VirtualTrees, Vcl.Menus,
  db.PhotoBaumList, db.PhotoBaum;

type
  TStringNotifyEvent = procedure (aValue: string) of object;
  Tfrm_PhotoBaum = class(Tfrm_ChildBase)
    vt: TVirtualStringTree;
    pop: TPopupMenu;
    pop_AlbumAufDieserEbeneErstellen: TMenuItem;
    pop_AlbumaufuntereEbeneErstellen: TMenuItem;
    pop_AlbumLoeschen: TMenuItem;
    pop_Bezeichnungndern: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pop_AlbumAufDieserEbeneErstellenClick(Sender: TObject);
    procedure vtFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure FormShow(Sender: TObject);
    procedure vtFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure pop_AlbumaufuntereEbeneErstellenClick(Sender: TObject);
    procedure pop_AlbumLoeschenClick(Sender: TObject);
    procedure pop_BezeichnungndernClick(Sender: TObject);
  private
    fDBPhotoBaumList: TDBPhotoBaumList;
    fDBPhotoBaum: TDBPhotoBaum;
    fSelectedNode: PVirtualNode;
    fOnZweigClick: TStringNotifyEvent;
    procedure AlbumAufEbeneErstellen;
    procedure AlbumAufUntereEbeneErstellen;
    procedure AlbumLoeschen;
    procedure LoadTree(aParentIndex: Integer; aParentUId: string; aParentNode: PVirtualNode; aStartId: Integer = -1);
    procedure setNodeData(aNode: PVirtualNode; aCaption, aUId: string; aId: Integer; const aImageIndex: Integer);
    procedure getDeleteNodeList(aNode: PVirtualNode; aStrings: TStrings);
    procedure BezeichnungAendern;
  public
    property OnZweigClick: TStringNotifyEvent read fOnZweigClick write fOnZweigClick;
  end;

var
  frm_PhotoBaum: Tfrm_PhotoBaum;

implementation

{$R *.dfm}

uses
  Datamodul.Database, System.UITypes, Objekt.Types;

type
  PTreeRec = ^TTreeRec;
  TTreeRec = record
    Caption: WideString;
    Id: Integer;
    UId: String;
    ImageIndex: Integer;
  end;



procedure Tfrm_PhotoBaum.FormCreate(Sender: TObject);
begin
  inherited;
  fDBPhotoBaumList := TDBPhotoBaumList.Create;
  fDBPhotoBaumList.Trans := dm.Trans_Standard;
  fDBPhotoBaumList.ReadAll;
  fDBPhotoBaum := TDBPhotoBaum.Create(Self);
  fDBPhotoBaum.Trans := dm.Trans_Standard;
  vt.NodeDataSize := SizeOf(TTreeRec);
  vt.RootNodeCount := 0;
  fSelectedNode := nil;
end;

procedure Tfrm_PhotoBaum.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDBPhotoBaumList);
  FreeAndNil(fDBPhotoBaum);
  inherited;
end;


procedure Tfrm_PhotoBaum.FormShow(Sender: TObject);
var
  pNode: PVirtualNode;
begin
  inherited;
  {
  fDBPhotoBaum.ReadUId(cBaumZweig_Neu);
  if not fDBPhotoBaum.Gefunden then
  begin
    fDBPhotoBaum.Init;
    fDBPhotoBaum.UID := cBaumZweig_Neu;
    fDBPhotoBaum.Bez := 'Neu';
    fDBPhotoBaum.SaveToDB;
  end;
  }
  pNode := vt.InsertNode(nil, amInsertAfter);
  setNodeData(pNode, 'Neu', cBaumZweig_Neu, -1, 0);
  LoadTree(0, '', nil);
end;

procedure Tfrm_PhotoBaum.pop_AlbumAufDieserEbeneErstellenClick(Sender: TObject);
begin
  AlbumAufEbeneErstellen;
end;

procedure Tfrm_PhotoBaum.pop_AlbumaufuntereEbeneErstellenClick(Sender: TObject);
begin
  AlbumAufUntereEbeneErstellen;
end;

procedure Tfrm_PhotoBaum.pop_AlbumLoeschenClick(Sender: TObject);
begin
  AlbumLoeschen;

end;

procedure Tfrm_PhotoBaum.pop_BezeichnungndernClick(Sender: TObject);
begin
  BezeichnungAendern;
end;

procedure Tfrm_PhotoBaum.AlbumAufEbeneErstellen;
var
  Album: String;
  Data: PTreeRec;
  ParentId: Integer;
  UId: string;
  pNode: PVirtualNode;
begin  //

  if not InputQuery('Album auf dieser Ebene erstellen', 'Album', Album) then
    exit;

  ParentId := 0;
  UId := '';
  if fSelectedNode <> nil then
  begin
    Data := vt.GetNodeData(fSelectedNode);
    fDBPhotoBaum.Read(Data.Id);
    if fDBPhotoBaum.Gefunden then
    begin
     ParentId := fDBPhotoBaum.ParentId;
     UId      := fDBPhotoBaum.Parent_UId;
    end;
  end;

  fDBPhotoBaum.Init;
  fDBPhotoBaum.ParentId := ParentId;
  fDBPhotoBaum.Parent_UId := UId;
  fDBPhotoBaum.Bez := Album;

  fDBPhotoBaum.SaveToDB;

   pNode := vt.InsertNode(fSelectedNode, amInsertAfter);
   setNodeData(pNode, fDBPhotoBaum.Bez, fDBPhotoBaum.UID, fDBPhotoBaum.Id, 0);
   vt.ScrollIntoView(pnode, true);
   vt.Selected[pNode] := true;


end;


procedure Tfrm_PhotoBaum.AlbumAufUntereEbeneErstellen;
var
  Album: String;
  Data: PTreeRec;
  pNode: PVirtualNode;
begin  //
  if fSelectedNode = nil then
  begin
    MessageDlg('Es wurde kein Album selektiert', TMsgDlgType.mtInformation, [mbOk], 0);
    exit;
  end;

  if fSelectedNode <> nil then
  begin
    Data := vt.GetNodeData(fSelectedNode);
    if Data^.UId = cBaumZweig_Neu then
    begin
      MessageDlg('Hier kann keine untere Ebene angelegt werden.', TMsgDlgType.mtInformation, [mbOk], 0);
      exit;
    end;
  end;

  if not InputQuery('Album auf untere Ebene erstellen', 'Album', Album) then
    exit;
  fDBPhotoBaum.Init;
  fDBPhotoBaum.ParentId := 0;
  fDBPhotoBaum.Parent_UId := '';
  fDBPhotoBaum.Bez := Album;

  Data := vt.GetNodeData(fSelectedNode);
  fDBPhotoBaum.ParentId   := data.Id;
  fDBPhotoBaum.Parent_UId := data.UId;

  fDBPhotoBaum.SaveToDB;

  pNode := vt.InsertNode(fSelectedNode, amAddChildLast);
  setNodeData(pNode, fDBPhotoBaum.Bez, fDBPhotoBaum.UID, fDBPhotoBaum.Id, 0);
  vt.ScrollIntoView(pnode, true);
  vt.Selected[pNode] := true;

  //vt.Clear;
  //LoadTree(0, '', nil);

end;


procedure Tfrm_PhotoBaum.LoadTree(aParentIndex: Integer; aParentUId: string; aParentNode: PVirtualNode; aStartId: Integer = -1);
var
  i1: Integer;
  DBPhotoBaumList: TDBPhotoBaumList;
  pNode: PVirtualNode;
begin
  DBPhotoBaumList := TDBPhotoBaumList.Create;
  try
    DBPhotoBaumList.Trans := dm.Trans_Standard;
    DBPhotoBaumList.ReadAllParentUid(aParentUId);
    for i1 := 0 to DBPhotoBaumList.Count -1 do
    begin
      if not Assigned(aParentNode) then
      begin
        pNode := vt.InsertNode(nil, amInsertAfter);
        setNodeData(pNode, DBPhotoBaumList.Item[i1].Bez, DBPhotoBaumList.Item[i1].UID, DBPhotoBaumList.Item[i1].Id, 0);
        LoadTree(0, DBPhotoBaumList.Item[i1].UID, pNode);
      end;
      if Assigned(aParentNode) then
      begin
        pNode := vt.InsertNode(aParentNode, amAddChildLast);
        setNodeData(pNode, DBPhotoBaumList.Item[i1].Bez, DBPhotoBaumList.Item[i1].UID, DBPhotoBaumList.Item[i1].Id, 0);
        LoadTree(0, DBPhotoBaumList.Item[i1].UID, pNode);
      end;
    end;
  finally
    FreeAndNil(DBPhotoBaumList);
  end;

end;

procedure Tfrm_PhotoBaum.setNodeData(aNode: PVirtualNode; aCaption, aUId: string;
  aId: Integer; const aImageIndex: Integer);
var
  Data: PTreeRec;
begin
  Data := vt.GetNodeData(aNode);
  Data^.Caption := aCaption;
  Data^.Id := aId;
  Data^.UId := aUId;
  if aImageIndex > -1 then
    Data^.ImageIndex := aImageIndex;
end;


procedure Tfrm_PhotoBaum.vtFocusChanging(Sender: TBaseVirtualTree; OldNode,
  NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
var
  Data: PTreeRec;
begin
  fSelectedNode := NewNode;
  Data := Sender.GetNodeData(fSelectedNode);
  if Assigned(fOnZweigClick) then
    fOnZweigClick(Data^.UId);
end;

procedure Tfrm_PhotoBaum.vtFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PTreeRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure Tfrm_PhotoBaum.vtGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Data: PTreeRec;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    CellText := Data.Caption;
end;

procedure Tfrm_PhotoBaum.vtInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PTreeRec;
begin
  with Sender do
  begin
    Data := GetNodeData(Node);
    Data.Caption := '';
  end;
end;


procedure Tfrm_PhotoBaum.AlbumLoeschen;
var
  DeleteList: TStringList;
  Data: PTreeRec;
begin
  if fSelectedNode = nil then
  begin
    MessageDlg('Es wurde kein Album selektiert', TMsgDlgType.mtInformation, [mbOk], 0);
    exit;
  end;

  Data := vt.GetNodeData(fSelectedNode);
  if Data^.UId = cBaumZweig_Neu then
  begin
    MessageDlg('Zweig ist nicht löschbar', TMsgDlgType.mtInformation, [mbOk], 0);
    exit;
  end;

  if MessageDlg('Möchtest du das Album wirklich löschen?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;

  if vt.HasChildren[fSelectedNode] then
    if MessageDlg('Es werden auch alle untergeordnete Alben gelöschen', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      exit;

  DeleteList := TStringList.Create;
  try
    getDeleteNodeList(fSelectedNode, DeleteList);
    fDBPhotoBaumList.DeleteFromList(DeleteList);
  finally
    FreeAndNil(DeleteList);
  end;

  vt.DeleteNode(fSelectedNode);
end;

procedure Tfrm_PhotoBaum.BezeichnungAendern;
var
  Album: string;
  Data: PTreeRec;
begin
  if fSelectedNode = nil then
  begin
    MessageDlg('Es wurde kein Album selektiert', TMsgDlgType.mtInformation, [mbOk], 0);
    exit;
  end;

  Data := vt.GetNodeData(fSelectedNode);
  Album := data.Caption;

  if not InputQuery('Album ändern', 'Album', Album) then
    exit;

  fDBPhotoBaum.Read(Data.Id);
  if not fDBPhotoBaum.Gefunden then
    exit;
  fDBPhotoBaum.Bez := Album;
  fDBPhotoBaum.SaveToDB;
  Data.Caption := Album;

end;

procedure Tfrm_PhotoBaum.getDeleteNodeList(aNode: PVirtualNode; aStrings: TStrings);
  procedure SubNodes(aNode: PVirtualNode; aStrings: TStrings);
  var
    SubNode: PVirtualNode;
    Data: PTreeRec;
  begin
    SubNode := vt.GetFirstChild(aNode);
    while Assigned(SubNode) do
    begin
      Data := vt.GetNodeData(SubNode);
      aStrings.Add(IntToStr(Data.Id));
      SubNodes(SubNode, aStrings);
      SubNode := vt.GetNextSibling(SubNode);
    end;
  end;
var
  Data: PTreeRec;
begin
  aStrings.Clear;
  vt.BeginUpdate;
  try
    Data := vt.GetNodeData(aNode);
    aStrings.Add(IntToStr(Data.Id));
    SubNodes(aNode, aStrings);
  finally
    vt.EndUpdate;
  end;
end;


end.
