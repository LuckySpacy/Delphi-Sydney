unit Form.Einstellung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.ChildBase, VirtualTrees,
  Vcl.ExtCtrls, Form.IniFirebird, Form.IniEinstellung;

type
  Tfrm_Einstellung = class(Tfrm_ChildBase)
    pnl_Left: TPanel;
    vt: TVirtualStringTree;
    pnl_Client: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
  private
    fFormList: TList;
    fFormIniFirebird: Tfrm_IniFireBird;
    fFormIniEinstellung: Tfrm_IniEinstellung;
    procedure LoadTree;
    procedure setNodeData(aNode: PVirtualNode; aCaption: string; aId: Integer; const aImageIndex: Integer);
    procedure ShowForm(aIndex: Integer);
    procedure AddForm(aForm: TForm; aIndex: Integer);
  public
  end;

var
  frm_Einstellung: Tfrm_Einstellung;

implementation

{$R *.dfm}

type
  PTreeRec = ^TTreeRec;
  TTreeRec = record
    Caption: WideString;
    Id: Integer;
    ImageIndex: Integer;
  end;

procedure Tfrm_Einstellung.FormCreate(Sender: TObject);
begin    //
  inherited;
  fFormList := TList.Create;

  fFormIniFirebird := Tfrm_IniFireBird.Create(Self);
  AddForm(fFormIniFirebird, 0);

  fFormIniEinstellung := Tfrm_IniEinstellung.Create(Self);
  AddForm(fFormIniEinstellung, 1);

  vt.NodeDataSize  := SizeOf(TTreeRec);
  vt.RootNodeCount := 0;
  LoadTree;
end;

procedure Tfrm_Einstellung.FormDestroy(Sender: TObject);
var
  i1: Integer;
  Form: TForm;
begin  //
  for i1 := fFormList.Count -1 downto 0 do
  begin
    Form := TForm(fFormList.Items[i1]);
    FreeAndNil(Form);
  end;
  FreeAndNil(fFormList);
  inherited;
end;

procedure Tfrm_Einstellung.AddForm(aForm: TForm; aIndex: Integer);
begin
  aForm.BorderStyle := bsNone;
  aForm.Parent := pnl_Client;
  aForm.Align  := alClient;
  aForm.Tag    := aIndex;
  fFormList.Add(aForm);
end;

procedure Tfrm_Einstellung.LoadTree;
var
  pNode: PVirtualNode;
  pNode1: PVirtualNode;
begin
  vt.Clear;
  pNode := vt.InsertNode(nil, amInsertAfter);
  setNodeData(pNode, 'Datenbank', 0, -1);
  pNode1 := vt.InsertNode(pNode, amInsertAfter);
  setNodeData(pNode1, 'Photo', 1, -1);
end;

procedure Tfrm_Einstellung.setNodeData(aNode: PVirtualNode; aCaption: string;
  aId: Integer; const aImageIndex: Integer);
var
  Data: PTreeRec;
begin
  Data := vt.GetNodeData(aNode);
  Data^.Caption := aCaption;
  Data^.Id := aId;
  if aImageIndex > -1 then
    Data^.ImageIndex := aImageIndex;
end;


procedure Tfrm_Einstellung.vtFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PTreeRec;
begin
  Data := Sender.GetNodeData(Node);
  Data^.Caption := '';
  Data^.id := 0;
  Finalize(Data^);
end;

procedure Tfrm_Einstellung.vtGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PTreeRec;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    CellText := Data.Caption;
end;

procedure Tfrm_Einstellung.vtInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PTreeRec;
begin
  if Sender = nil then
    exit;
  Data := Sender.GetNodeData(Node);
  Data^.Caption := '';
  Data^.Id := 0;
end;

procedure Tfrm_Einstellung.vtNodeClick(Sender: TBaseVirtualTree;
  const HitInfo: THitInfo);
var
  Data: PTreeRec;
begin
  if Sender = nil then
    exit;
  if vt.FocusedNode = nil then
    exit;
  Data := Sender.GetNodeData(vt.FocusedNode);
  ShowForm(Data^.Id);
end;


procedure Tfrm_Einstellung.ShowForm(aIndex: Integer);
var
  i1: Integer;
begin
  for i1 := 0 to fFormList.Count -1 do
    TForm(fFormList.Items[i1]).Visible := false;

  for i1 := 0 to fFormList.Count -1 do
  begin
    if TForm(fFormList.Items[i1]).Tag = aIndex then
    begin
      TForm(fFormList.Items[i1]).Show;
      exit;
    end;
  end;
end;

end.
