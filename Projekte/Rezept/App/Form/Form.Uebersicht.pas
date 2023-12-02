unit Form.Uebersicht;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, Rest.RezeptList, FMX.Layouts,
  FMX.ListBox, FMX.TabControl, Rest.Rezept, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, Form.Rezept, Rest.ZutatenlistennameList, Objekt.RestSchnittstelle,
  Rest.RezeptZutatenList, FMX.TMSBaseControl, FMX.TMSScrollControl,
  FMX.TMSRichEditorBase, FMX.TMSRichEditor, FMX.TMSToolBar,
  FMX.TMSRichEditorToolBar;

type
  Tfrm_Uebersicht = class(TForm)
    tbc_Rezept: TTabControl;
    tbs_Uebersicht: TTabItem;
    tbs_Rezept: TTabItem;
    lb: TListBox;
    ListBoxItem1: TListBoxItem;
    Lay_Rezept: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    fRezeptList: TRestRezeptList;
    fRezept: TRestRezept;
    fFormRezept: Tfrm_Rezept;
    procedure HoleAlleRezepte;
    procedure HoleRezept(aId: Integer);
    procedure HoleZutatenListenname(aRzId: Integer);
    procedure LadeListBox;
    procedure ListBoxItemClick(Sender: TObject);
    procedure RezeptReturnClick(Sender: TObject);
  public
  end;

var
  frm_Uebersicht: Tfrm_Uebersicht;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

uses
  ClientModul.Classes, ClientModul.Module;



procedure Tfrm_Uebersicht.FormCreate(Sender: TObject);
begin
  fRezeptList := TRestRezeptList.Create;
  fRezept     := TRestRezept.Create;
  fFormRezept := Tfrm_Rezept.Create(Self);
  while fFormRezept.ChildrenCount>0 do
    fFormRezept.Children[0].Parent := lay_Rezept;
  fFormRezept.OnReturnClick := RezeptReturnClick;
  lb.Clear;
end;

procedure Tfrm_Uebersicht.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fRezeptList);
  FreeAndNil(fRezept);
end;

procedure Tfrm_Uebersicht.FormShow(Sender: TObject);
begin
  HoleAlleRezepte;
  LadeListBox;
end;

procedure Tfrm_Uebersicht.Button1Click(Sender: TObject);
begin
  HoleZutatenListenname(2);
//  HoleAlleRezepte;
//  LadeListBox;
end;

procedure Tfrm_Uebersicht.Button2Click(Sender: TObject);
begin //
  HoleRezept(2);
end;



procedure Tfrm_Uebersicht.HoleAlleRezepte;
var
  Temp: TRezeptServerMethodsClient;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TRezeptServerMethodsClient.Create(ClientModule1.DSRestConnection1);
  Stream := Temp.RezeptAll;
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRezeptList.LoadFromStream(MemStream);
  //Button1.Text := fRezeptList.Item[0].FieldByName('Rezeptname').AsString;
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;



procedure Tfrm_Uebersicht.HoleRezept(aId: Integer);
var
  Temp: TRezeptServerMethodsClient;
  Stream: TStream;
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  Temp := TRezeptServerMethodsClient.Create(ClientModule1.DSRestConnection1);
  Stream := Temp.Rezept(aId);
  Stream.Position := 0;
  MemStream.CopyFrom(Stream, Stream.Size);
  fRezept.LoadFromStream(MemStream);
  //ShowMessage(fRezept.FieldByName('rezeptname').AsString);
  //Button1.Text := fRezeptList.Item[0].FieldByName('Rezeptname').AsString;
  FreeAndNil(MemStream);
  FreeAndNil(Temp);
end;

procedure Tfrm_Uebersicht.HoleZutatenListenname(aRzId: Integer);
var
  ZutatenlistennameList: TRestZutatenlistennameList;
  RezeptZutatenList: TRestRezeptZutatenList;
  s: string;
begin
  RezeptZutatenList     := TRestRezeptZutatenList.Create;
  ZutatenlistennameList := TRestZutatenlistennameList.Create;
  try
    RestSchnittstelle.HoleZutatenlistenname(ZutatenlistennameList, aRZId);
    s := ZutatenListennameList.Item[0].FieldByName('Listenname').AsString;
    RestSchnittstelle.HoleZutatenlist(RezeptZutatenlist, ZutatenListennameList.Item[0].FieldByName('RZ_ID').AsInteger, ZutatenListennameList.Item[0].FieldByName('ZL_ID').AsInteger);
    s := RezeptZutatenList.Item[0].FieldByName('NAME').AsString;
    //ShowMessage(s);
  finally
    FreeAndNil(ZutatenlistennameList);
    FreeAndNil(RezeptZutatenList);
  end;
end;

procedure Tfrm_Uebersicht.LadeListBox;
var
  lbItem: TListBoxItem;
  i1: Integer;
begin
  lb.Clear;
  lb.BeginUpdate;
  try
    for i1 := 0 to fRezeptList.Count -1 do
    begin
      lbItem := TListBoxItem.Create(lb);
      lbItem.StyledSettings := lbItem.StyledSettings - [TStyledSetting.Size];
      lbItem.StyledSettings := lbItem.StyledSettings - [TStyledSetting.Family];
      lbItem.Height := 44;
      lbItem.Text := fRezeptList.Item[i1].FieldByName('Rezeptname').AsString;
      lbItem.TextSettings.Font.Family := 'Times New Roman';
      lbItem.TextSettings.Font.Size := 25;
      lbItem.ItemData.Accessory := TListBoxItemData.TAccessory(1);
      lbItem.Margins.Left := 0;
      lbItem.OnClick := ListBoxItemClick;
      lbItem.Data := fRezeptList.Item[i1];
      lb.AddObject(lbItem);
    end;
  finally
    lb.EndUpdate;
  end;
end;

procedure Tfrm_Uebersicht.ListBoxItemClick(Sender: TObject);
var
  Rezept: TRestRezept;
begin
  Rezept := TRestRezept(TListBoxItem(Sender).Data);
  fFormRezept.setRezept(Rezept);
  tbc_Rezept.ActiveTab := tbs_Rezept;
 // TMSFMXRichEditor1.InsertAsRTF(Rezept.FieldByName('Notiz').AsString);
  //Memo1.Text := Rezept.FieldByName('PLAINBESCHREIBUNG').AsString;
end;

procedure Tfrm_Uebersicht.RezeptReturnClick(Sender: TObject);
begin
  tbc_Rezept.ActiveTab := tbs_Uebersicht;
end;

end.
