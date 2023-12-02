unit Form.Zutaten;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.ExtCtrls, Vcl.StdCtrls, nfsButton, DB.Rezept, DB.RezeptZutatenlist,
  DB.Zutaten, DB.Zutatenlist, DB.Zutatenlistenname, DB.RezeptZutaten, DB.RzZt,
  Objekt.Abgleich, Form.ZutatenListe, Form.RezeptZutatenListe,
  Objekt.VergleichRezeptZutat;


type
  TZutatennameChangeEvent=procedure(Sender: TObject; aName: string) of object;
  Tfrm_Zutaten = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel6: TPanel;
    Panel7: TPanel;
    Label3: TLabel;
    edt_Zutatenname: TEdit;
    pnl_Zutatenliste: TPanel;
    pnl_Rezeptzutatenliste: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure edt_ZutatennameChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_ZutatenDblClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    fFormZutatenListe: Tfrm_Zutatenliste;
    fFormRezeptZutatenListe: Tfrm_RezeptZutatenliste;
    fOnZutatennameChange: TZutatennameChangeEvent;
    fRezept: TDBRezept;
    fDBRezeptZutatenList: TDBRezeptzutatenlist;
    fDBRezeptZutat: TDBRezeptZutaten;
    fZutaten: TDBZutaten;
    fZutatenList: TDBZutatenList;
    fDBRzZt: TDBRzZt;
    fZutatenlistenname: TDBZutatenlistenname;
    fAbgleich: TAbgleich;
    procedure AbgleichChangeList(aId: Integer);
  public
    property OnZutatennameChange: TZutatennameChangeEvent read fOnZutatennameChange write fOnZutatennameChange;
    procedure setDBRezept(aDBRezept: TDBRezept; aZlId: Integer);
    procedure Save;
  end;

var
  frm_Zutaten: Tfrm_Zutaten;

implementation

{$R *.dfm}

uses
  Datamodul.Database;



procedure Tfrm_Zutaten.FormCreate(Sender: TObject);
begin //
  fAbgleich := TAbgleich.Create;
  fAbgleich.OnChangeList := AbgleichChangeList;
  fDBRezeptZutatenList  := TDBRezeptzutatenlist.Create;
  fDBRezeptZutatenList.Trans := dm.getTrans;
  //fDBRezeptZutatenList.Trans := dm.IBT_Standard;
  fZutaten := TDBZutaten.Create(nil);
  fZutaten.Trans := dm.getTrans;
  //fZutaten.Trans := dm.IBT_Standard;
  fZutatenList := TDBZutatenList.Create;
  fZutatenList.Trans := dm.getTrans;
  //fZutatenList.Trans := dm.IBT_Standard;

  fZutatenlistenname := TDBZutatenlistenname.Create(nil);
  fZutatenlistenname.Trans := dm.getTrans;
  //fZutatenlistenname.Trans := dm.IBT_Standard;

  fDBRzZt := TDBRzZt.Create(nil);
  fDBRzZt.Trans := dm.getTrans;
  //fDBRzZt.Trans := dm.IBT_Standard;

  fFormZutatenListe := Tfrm_Zutatenliste.Create(Self);
  fFormZutatenListe.Parent := pnl_Zutatenliste;
  fFormZutatenListe.Align := alClient;
  fFormZutatenListe.Show;

  fFormRezeptZutatenListe := Tfrm_RezeptZutatenliste.Create(Self);
  fFormRezeptZutatenListe.Parent := pnl_Rezeptzutatenliste;
  fFormRezeptZutatenListe.Align := alClient;



  fDBRezeptZutat := TDBRezeptZutaten.Create(nil);
  fDBRezeptZutat.Trans := dm.getTrans;
  //fDBRezeptZutat.Trans := dm.IBT_Standard;


  edt_Zutatenname.Text := 'Zutaten';

  fFormRezeptZutatenListe.Show;


end;

procedure Tfrm_Zutaten.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fAbgleich);
  FreeAndNil(fZutaten);
  FreeAndNil(fDBRezeptZutatenList);
  FreeAndNil(fZutatenList);
  FreeAndNil(fZutatenlistenname);
  FreeAndNil(fDBRzZt);
  FreeAndNil(fDBRezeptZutat);
end;

procedure Tfrm_Zutaten.FormShow(Sender: TObject);
begin
  fZutatenList.ReadAll;
  fFormZutatenListe.AktualGrid(0);
  fFormRezeptZutatenListe.AktualGrid(0);
end;

procedure Tfrm_Zutaten.grd_ZutatenDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
//var
//  x: TDBZutaten;
//  RezeptZutat: TDBRezeptZutaten;
begin //
{
  x := TDBZutaten(grd_Zutaten.Objects[0, ARow]);
  if fZutatenlistenname.Id = 0 then
  begin
    fZutatenlistenname.ZutatenName := edt_Zutatenname.Text;
    fZutatenlistenname.saveToDB;
    fRzZt.Init;
    fRzZt.RZ_ID := fRezept.Id;
    fRzZt.ZL_ID := fZutatenlistenname.Id;
    fRzZt.SaveToDB;
  end;

  RezeptZutat := TDBRezeptZutaten.Create(nil);
  try
    RezeptZutat.ZutatenName := x.ZutatenName;
    RezeptZutat.RZ_ID       := fRezept.Id;
    RezeptZutat.ZL_ID       := fZutatenlistenname.Id;
    RezeptZutat.ZT_ID       := x.Id;
    RezeptZutat.SaveToDB;
  finally
    FreeAndNil(RezeptZutat);
  end;
}
end;


procedure Tfrm_Zutaten.Save;
var
  i1: Integer;
  VergleichRezeptZutat: TVergleichRezeptZutat;
begin
  if (fDBRzZt <> nil) and (fDBRzZt.ZL_ID > 0) then
  begin
    fDBRzZt.SaveToDB;

    fDBRezeptZutatenList.ReadAll(fDBRzZt.Rz_Id, fDBRzZt.ZL_ID);
    for i1 := 0 to fDBRezeptZutatenList.Count -1 do
    begin
      if not fAbgleich.IdInZielList(fDBRezeptZutatenList.Item[i1].ZT_ID) then
        fDBRezeptZutatenList.Item[i1].Delete;
    end;

    for i1 := 0 to fAbgleich.Ziellist.Count -1 do
    begin
      fDBRezeptZutat.Read(fDBRzZt.RZ_ID, fDBRzZt.ZL_ID, fAbgleich.Ziellist.Item[i1].Id);
      VergleichRezeptZutat := TVergleichRezeptZutat(fAbgleich.Ziellist.Item[i1].Objects);
      if not fDBRezeptZutat.Gefunden then
      begin
        fDBRezeptZutat.Init;
        fDBRezeptZutat.RZ_ID := fDBRzZt.RZ_ID;
        fDBRezeptZutat.ZL_ID := fDBRzZt.ZL_ID;
        fDBRezeptZutat.ZT_ID := fAbgleich.Ziellist.Item[i1].Id;
      end;
      if VergleichRezeptZutat <> nil then
      begin
        fDBRezeptZutat.Menge   := VergleichRezeptZutat.Menge;
        fDBRezeptZutat.Einheit := VergleichRezeptZutat.Einheit;
      end;
      fDBRezeptZutat.SaveToDB;
    end;
  end;

end;

procedure Tfrm_Zutaten.setDBRezept(aDBRezept: TDBRezept; aZlId: Integer);
begin
  fRezept := aDBRezept;
  fZutaten.Trans := fRezept.Trans;
  fDBRezeptZutatenList.Trans := fRezept.Trans;
  fZutatenList.Trans := fRezept.Trans;
  fZutatenlistenname.Trans := fRezept.Trans;
  fDBRzZt.Trans := fRezept.Trans;
  fFormZutatenListe.setDBRezept(fRezept);
  fFormZutatenListe.setAbgleich(fAbgleich);
  fFormRezeptZutatenListe.setDBRezept(fRezept, aZlId);
  fFormRezeptZutatenListe.setAbgleich(fAbgleich);
  fDBRzZt.Read(fRezept.Id, aZlId);
  edt_Zutatenname.Text := fDBRzZt.Zutatenlistenname;
end;




procedure Tfrm_Zutaten.AbgleichChangeList(aId: Integer);
begin
  fFormZutatenListe.AktualGrid(0);
  fFormRezeptZutatenListe.AktualGrid(0);
end;

procedure Tfrm_Zutaten.edt_ZutatennameChange(Sender: TObject);
begin
  if Assigned(fOnZutatennameChange) then
    fOnZutatennameChange(Self, edt_Zutatenname.Text);
  if (fDBRzZt <> nil) and (fDBRzZt.ZL_ID > 0) then
    fDBRzZt.Zutatenlistenname := edt_Zutatenname.Text;
end;

end.
