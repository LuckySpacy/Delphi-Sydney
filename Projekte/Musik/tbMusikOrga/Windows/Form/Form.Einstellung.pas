unit Form.Einstellung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.ExtCtrls, Form.IniFirebird, Form.MainChild,
  nfsButton, Form.Musikpfad, IBX.IBDatabase;

type
  Tfrm_Einstellung = class(Tfrm_MainChild)
    pnl_Left: TPanel;
    pnl_Client: TPanel;
    vt: TVirtualStringTree;
    Panel1: TPanel;
    btn_Zurueck: TnfsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure vtGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure btn_ZurueckClick(Sender: TObject);
  private
    fFormIniFirebird: Tfrm_IniFirebird;
    fFormMusikpfad: Tfrm_Musikpfad;
    fFormList: TList;
    procedure LoadTree;
    procedure setNodeData(aNode: PVirtualNode; aCaption: string; aId: Integer; const aImageIndex: Integer);
    procedure ShowForm(aIndex: Integer);
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
begin  //
  fFormList := TList.Create;
  fFormIniFirebird := nil;
  fFormMusikpfad   := nil;
  vt.NodeDataSize := SizeOf(TTreeRec);
  vt.RootNodeCount := 0;
end;

procedure Tfrm_Einstellung.FormDestroy(Sender: TObject);
begin  //
  if fFormIniFirebird <> nil then
    FreeAndNil(fFormIniFireBird);
  if fFormMusikpfad <> nil then
    FreeAndNil(fFormMusikpfad);
  FreeAndNil(fFormList);
end;

procedure Tfrm_Einstellung.FormShow(Sender: TObject);
begin //
  LoadTree;
end;

procedure Tfrm_Einstellung.btn_ZurueckClick(Sender: TObject);
begin
  close;
end;


procedure Tfrm_Einstellung.LoadTree;
var
  pNode: PVirtualNode;
  //pNode1: PVirtualNode;
begin
  vt.Clear;
  pNode := vt.InsertNode(nil, amInsertAfter);
  setNodeData(pNode, 'Datenbank', 0, -1);
  pNode := vt.InsertNode(nil, amInsertAfter);
  setNodeData(pNode, 'Musikpfad', 1, -1);
  //pNode1 := vt.InsertNode(pNode, amAddChildLast);
  //setNodeData(pNode1, 'Firebird', 1, -1);
  //pNode1 := vt.InsertNode(pNode, amAddChildLast);
  //setNodeData(pNode1, 'MySql', 2, -1);
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
  with Sender do
  begin
    Data := GetNodeData(Node);
    Data.Caption := '';
  end;
end;

procedure Tfrm_Einstellung.vtNodeClick(Sender: TBaseVirtualTree;
  const HitInfo: THitInfo);
var
  Data: PTreeRec;
begin
  if vt.FocusedNode = nil then
    exit;
  Data := vt.GetNodeData(vt.FocusedNode);
  ShowForm(Data^.Id);
end;


procedure Tfrm_Einstellung.ShowForm(aIndex: Integer);
var
  i1: Integer;
  Form: TForm;
begin
  for i1 := 0 to fFormList.Count -1 do
    TForm(fFormList.Items[i1]).Visible := false;

  for i1 := 0 to fFormList.Count -1 do
  begin
    if TForm(fFormList.Items[i1]).Tag = aIndex then
    begin
      TForm(fFormList.Items[i1]).Visible := true;
      exit;
    end;
  end;

  Form := nil;
  case aIndex of
    0: Form := Tfrm_IniFirebird.Create(Self);
    1: Form := Tfrm_Musikpfad.Create(Self);
  end;

  if Form = nil then
    exit;

  Tfrm_MainChild(Form).Trans := fTrans;
  Form.BorderStyle := bsNone;
  Form.Parent := pnl_Client;
  Form.Align  := alClient;
  Form.Tag    := aIndex;
  Form.Show;
  fFormList.Add(Form);

end;



end.
