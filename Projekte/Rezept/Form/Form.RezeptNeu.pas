unit Form.RezeptNeu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.MainChild, nfsButton, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Form.Notiz, Form.Zutaten, Datamodul.Bilder,
  DB.Rezept, DB.RzZt, DB.RzZtList, Vcl.Samples.Spin;

type
  Tfrm_RezeptNeu = class(Tfrm_MainChild)
    Panel1: TPanel;
    btn_Zurueck: TnfsButton;
    Panel2: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Panel3: TPanel;
    pnl_Button: TPanel;
    btn_Speichern: TnfsButton;
    Panel4: TPanel;
    pg: TPageControl;
    tbs_Beschreibung: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    edt_Rezept: TEdit;
    tbs_Notiz: TTabSheet;
    Panel7: TPanel;
    btn_NeuesRezept: TnfsButton;
    btn_NeueZutatenliste: TnfsButton;
    btn_DeleteZutatenliste: TnfsButton;
    Label2: TLabel;
    edt_Basismenge: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_ZurueckClick(Sender: TObject);
    procedure btn_NeueZutatenlisteClick(Sender: TObject);
    procedure pgChange(Sender: TObject);
    procedure btn_DeleteZutatenlisteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FormBeschreibung: Tfrm_Notiz;
    FormNotiz: Tfrm_Notiz;
    fFormZutatenList: TList;
    fFormZutatenId: Integer;
    fDBRezept: TDBRezept;
    fDBRzZtList: TDBRzZtList;
    fDBRzZt: TDBRzZt;
    procedure ZutatennameChange(Sender: TObject; aName: string);
    function AddZutatenList(aTabSheet: TTabSheet; aZlId: Integer): Tfrm_Zutaten;
    procedure TabSheetZutatenListLoeschen;
    //function getZutatenForm(aTabSheet: TTabSheet): Tfrm_Zutaten;
    procedure DeleteFormAusFormZutatenList(aTag: Integer);
    procedure Save;
  public
    procedure setRzId(aRzId: Integer);
  end;

var
  frm_RezeptNeu: Tfrm_RezeptNeu;

implementation

{$R *.dfm}

uses
  System.UITypes, Datamodul.Database;



procedure Tfrm_RezeptNeu.FormCreate(Sender: TObject);
begin   //
  inherited;

  fDBRezept := TDBRezept.Create(nil);
  fDBRezept.Trans := dm.getTrans;
//  fDBRezept.Trans := dm.IBT_Standard;

  fDBRzZtList := TDBRzZtList.Create;
  fDBRzZtList.Trans := dm.getTrans;
  //fDBRzZtList.Trans := dm.IBT_Standard;

  fDBRzZt := TDBRzZt.Create(nil);
  fDBRzZt.Trans := dm.getTrans;
  //fDBRzZt.Trans := dm.IBT_Standard;

  fFormZutatenId := 0;
  edt_Rezept.Text := '';
  fFormZutatenList := TList.Create;

  FormBeschreibung := Tfrm_Notiz.Create(Self);
  FormNotiz        := Tfrm_Notiz.Create(Self);

  FormBeschreibung.Parent := tbs_Beschreibung;
  FormBeschreibung.Align  := alClient;
  FormBeschreibung.BorderStyle := bsNone;
  FormBeschreibung.Show;

  FormNotiz.Parent := tbs_Notiz;
  FormNotiz.Align  := alClient;
  FormNotiz.BorderStyle := bsNone;
  FormNotiz.Show;

  //AddZutatenList(tbs_Zutaten);

end;

procedure Tfrm_RezeptNeu.FormDestroy(Sender: TObject);
begin   //
  FreeAndNil(fDBRezept);
  FreeAndNil(fDBRzZtList);
  FreeAndNil(fDBRzZt);
  FreeAndNil(FormBeschreibung);
  FreeAndNil(FormNotiz);
  FreeAndNil(fFormZutatenList);
  inherited;
end;

procedure Tfrm_RezeptNeu.FormShow(Sender: TObject);
begin
  edt_Rezept.SetFocus;
end;

procedure Tfrm_RezeptNeu.pgChange(Sender: TObject);
begin
  btn_DeleteZutatenliste.Enabled := pg.ActivePageIndex > 1;

end;

procedure Tfrm_RezeptNeu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Save;
  inherited;
end;



procedure Tfrm_RezeptNeu.TabSheetZutatenListLoeschen;
var
  TabSheet: TTabSheet;
begin
  if MessageDlg('Zutatenliste wirklich löschen?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;
  TabSheet := pg.ActivePage;
  DeleteFormAusFormZutatenList(TabSheet.Tag);
  FreeAndNil(TabSheet);
end;

{
function Tfrm_RezeptNeu.getZutatenForm(aTabSheet: TTabSheet): Tfrm_Zutaten;
var
  i1: Integer;
begin
  Result := nil;
  for i1 := 0 to fFormZutatenList.Count -1 do
  begin
    if aTabSheet.Tag = Tfrm_Zutaten(fFormZutatenList.Items[i1]).Tag then
    begin
      Result := Tfrm_Zutaten(fFormZutatenList.Items[i1]);
      exit;
    end;
  end;
end;
}

procedure Tfrm_RezeptNeu.ZutatennameChange(Sender: TObject; aName: string);
var
  tbs: TTabsheet;
begin
  tbs := TTabsheet(TForm(Sender).Parent);
  tbs.Caption := aName;
end;

function Tfrm_RezeptNeu.AddZutatenList(aTabSheet: TTabSheet; aZlId: Integer): Tfrm_Zutaten;
begin
  Result      := Tfrm_Zutaten.Create(Self);
  Result.Parent := aTabSheet;
  Result.Align  := alClient;
  Result.BorderStyle := bsNone;
  Result.OnZutatennameChange := ZutatennameChange;
  Result.setDBRezept(fDBRezept, aZlId);
  Result.Show;
  Result.Tag := aZlId;
  aTabSheet.Tag := aZlId;
  fFormZutatenList.Add(Result);
  pg.ActivePage := aTabSheet;
end;

procedure Tfrm_RezeptNeu.btn_DeleteZutatenlisteClick(Sender: TObject);
begin
  TabSheetZutatenListLoeschen;
end;

procedure Tfrm_RezeptNeu.btn_NeueZutatenlisteClick(Sender: TObject);
var
  TabSheet: TTabSheet;
  RzZt: TDBRzZt;
begin
  TabSheet := TTabSheet.Create(pg);
  TabSheet.Caption := 'Zutaten';
  TabSheet.PageControl := pg;
  RzZt := TDBRzZt.Create(nil);
  RzZt.Trans := fDBRezept.Trans;
  RzZt.RZ_ID := fDBRezept.Id;
  RzZt.SaveToDB;
  AddZutatenList(TabSheet, RzZt.ZL_ID);
  FreeAndNil(RzZt);
end;

procedure Tfrm_RezeptNeu.btn_ZurueckClick(Sender: TObject);
begin
  close;
end;


procedure Tfrm_RezeptNeu.DeleteFormAusFormZutatenList(aTag: Integer);
var
  i1: Integer;
begin
  for i1 := 0 to fFormZutatenList.Count -1 do
  begin
    if Tfrm_Zutaten(fFormZutatenList.Items[i1]).Tag = aTag then
    begin
      fDBRzZt.Read(fDBRezept.Id, aTag);
      fDBRzZt.Delete;
      fFormZutatenList.Delete(i1);
      exit;
    end;
  end;
end;



procedure Tfrm_RezeptNeu.Save;
var
  i1: Integer;
begin
  fDBRezept.Rezeptname   := edt_Rezept.Text;
  fDBRezept.Beschreibung := FormBeschreibung.rv.AsRTFString;
  fDBRezept.Notiz        := FormNotiz.rv.AsRTFString;
  FDBRezept.Basismenge   := edt_Basismenge.Value;
  fDBRezept.SaveToDB;
  for i1 := 0 to fFormZutatenList.Count -1 do
  begin
    Tfrm_Zutaten(fFormZutatenList.Items[i1]).save;
  end;
end;


procedure Tfrm_RezeptNeu.setRzId(aRzId: Integer);
var
  TabSheet: TTabSheet;
  i1: Integer;
begin
  if aRzId = 0 then
  begin
    fDBRezept.Init;
    save;
    exit;
  end;
  fDBRezept.Read(aRzId);

  fDBRzZtList.ReadAll(fDBRezept.Id);

  edt_Rezept.Text := fDBRezept.Rezeptname;
  FormBeschreibung.rv.AsRTFString := fDBRezept.Beschreibung;
  FormNotiz.rv.AsRTFString        := fDBRezept.Notiz;
  edt_Basismenge.Value := fDBRezept.Basismenge;

  for i1 := 0 to fDBRzZtList.count -1 do
  begin
    TabSheet := TTabSheet.Create(pg);
    TabSheet.Caption := fDBRzZtList.Item[i1].Zutatenlistenname;
    TabSheet.PageControl := pg;
    AddZutatenList(TabSheet, fDBRzZtList.Item[i1].Zl_Id);
  end;

end;

end.
