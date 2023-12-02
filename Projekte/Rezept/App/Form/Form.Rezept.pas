unit Form.Rezept;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  FMX.TabControl, Rest.Rezept, FMX.Layouts, Form.Zutaten,
  FMX.TMSBaseControl, FMX.TMSScrollControl, FMX.TMSRichEditorBase,
  FMX.TMSRichEditor, FMX.TMSToolBar, FMX.TMSRichEditorToolBar,
  FMX.TMSCustomButton, FMX.TMSSpeedButton, FMX.TMSBitmapContainer,
  FMX.TMSRichEditorIO;

type
  Tfrm_Rezept = class(TForm)
    ToolBar1: TToolBar;
    btn_Zurueck: TSpeedButton;
    tbc: TTabControl;
    tbs_Rezept: TTabItem;
    mem_Rezept: TMemo;
    tbs_Zutaten: TTabItem;
    lay_Zutaten: TLayout;
    tbs_Notiz: TTabItem;
    lay_Notiz: TLayout;
    re_Notiz: TTMSFMXRichEditor;
    Layout1: TLayout;
    Layout2: TLayout;
    TMSFMXBitmapContainer1: TTMSFMXBitmapContainer;
    btn_Save: TTMSFMXSpeedButton;
    Layout3: TLayout;
    Toolbar_Notiz: TTMSFMXRichEditorFormatToolBar;
    TMSFMXRichEditorRTFIO1: TTMSFMXRichEditorRTFIO;
    tbs_PlainNotiz: TTabItem;
    mem_Notiz: TMemo;
    btn_SaveNotiz: TTMSFMXSpeedButton;
    procedure btn_ZurueckClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SaveNotizClick(Sender: TObject);
    procedure tbcChange(Sender: TObject);
  private
    fOnReturnClick: TNotifyEvent;
    fRestRezept: TRestRezept;
    fFormZutaten: Tfrm_Zutaten;
  public
    property OnReturnClick: TNotifyEvent read fOnReturnClick write fOnReturnClick;
    procedure setRezept(aRezept: TRestRezept);
  end;

var
  frm_Rezept: Tfrm_Rezept;

implementation

{$R *.fmx}

uses
  Objekt.RestSchnittstelle;


procedure Tfrm_Rezept.FormCreate(Sender: TObject);
begin
  fFormZutaten := Tfrm_Zutaten.Create(Self);
  while fFormZutaten.ChildrenCount>0 do
    fFormZutaten.Children[0].Parent := lay_Zutaten;
  tbs_Notiz.Visible := false;
  btn_SaveNotiz.Visible := false;
end;

procedure Tfrm_Rezept.FormShow(Sender: TObject);
begin
  tbc.ActiveTab := tbs_Rezept;
end;

procedure Tfrm_Rezept.setRezept(aRezept: TRestRezept);
begin
  re_Notiz.Clear;
  fRestRezept := aRezept;
  mem_Rezept.Text := fRestRezept.FieldByName('PLAINBESCHREIBUNG').AsString;
  fFormZutaten.setRezept(fRestRezept);
  re_Notiz.InsertAsRTF(fRestRezept.FieldByName('Notiz').AsString);
  mem_Notiz.Text := fRestRezept.FieldByName('PLAINNOTIZ').AsString;
  tbc.ActiveTab := tbs_Rezept;
end;

procedure Tfrm_Rezept.tbcChange(Sender: TObject);
begin
  btn_SaveNotiz.Visible := tbc.ActiveTab = tbs_PlainNotiz;
end;

procedure Tfrm_Rezept.btn_SaveClick(Sender: TObject);
var
  List: TStringList;
  m: TMemoryStream;
begin
  m := TMemoryStream.Create;
  List := TStringList.Create;
  try
    TMSFMXRichEditorRTFIO1.Save(m);
    m.Position := 0;
    List.LoadFromStream(m);
    fRestRezept.FieldByName('Notiz').AsString := Trim(List.Text);
    RestSchnittstelle.SaveRezept(fRestRezept.getStream);
  finally
    FreeAndNil(List);
    FreeAndNil(m);
  end;
end;

procedure Tfrm_Rezept.btn_SaveNotizClick(Sender: TObject);
var
  RestRezept: TRestRezept;
  i1: Integer;
begin
  RestRezept := TRestRezept.Create;
  try
    for i1 := 0 to fRestRezept.FeldList.Count -1 do
      RestRezept.FeldList.Feld[i1].AsString := fRestRezept.FeldList.Feld[i1].AsString;
    RestRezept.FieldByName('PLAINNOTIZ').AsString := mem_Notiz.Text;
    RestRezept.FieldByName('Notiz').AsString := mem_Notiz.Text;
    fRestRezept.FieldByName('PLAINNOTIZ').AsString := mem_Notiz.Text;
    fRestRezept.FieldByName('Notiz').AsString := mem_Notiz.Text;
    RestSchnittstelle.SaveRezeptPlainNotiz(RestRezept.getStream);
  finally
    //FreeAndNil(RestRezept);
  end;
end;

procedure Tfrm_Rezept.btn_ZurueckClick(Sender: TObject);
begin
  if Assigned(fOnReturnClick) then
    fOnReturnClick(Self);
end;


end.
