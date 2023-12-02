unit Form.Bilder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.ChildBase, vw.PhotoUndBaumList,
  Vcl.ExtCtrls, vcl.Imaging.jpeg, Form.Bild, Form.BildOri;

type
  Tfrm_Bilder = class(Tfrm_ChildBase)
    sc: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure scResize(Sender: TObject);
    procedure scMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure scMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    fVWPhotoUndBaumList: TVWPhotoUndBaumList;
    fBilderList: TList;
    fBildWidth: Integer;
    fBildHeight: Integer;
    fLastAnzahlBilderInRow: Integer;
    fOldScWidth: Integer;
    fBilderNeuAnordnen: Boolean;
    fFormBildOri: Tfrm_BildOri;
    procedure ErzeugeBildImages;
    function AnzahlBilderInRow(aWidth: Integer): Integer;
    procedure ClearBilderList;
    procedure BilderNeuAnordnen;
    procedure ShowBildOri(Sender: TObject);
  public
    procedure LoadBilder(aUId: string);
    property BildHeight: Integer read fBildHeight write fBildHeight;
    property BildWidth: Integer read fBildWidth write fBildWidth;
  end;

var
  frm_Bilder: Tfrm_Bilder;

implementation

{$R *.dfm}

{ Tfrm_Bilder }

uses
  Datamodul.Database, objekt.PhotoOrga, fmx.Types, VW.PhotoUndBaum;


procedure Tfrm_Bilder.FormCreate(Sender: TObject);
begin //
  inherited;
  fOldScWidth := 0;
  fBilderNeuAnordnen := false;
  fVWPhotoUndBaumList := TVWPhotoUndBaumList.Create;
  fVWPhotoUndBaumList.Trans := dm.Trans_Standard;
  fBilderList := TList.Create;
  fBildWidth  := 185;
  fBildHeight := 185;
  fFormBildOri := Tfrm_BildOri.Create(Self);
end;

procedure Tfrm_Bilder.FormDestroy(Sender: TObject);
begin  //
  FreeAndNil(fVWPhotoUndBaumList);
  FreeAndNil(fBilderList);
  FreeAndNil(fFormBildOri);
  inherited;
end;

procedure Tfrm_Bilder.LoadBilder(aUId: string);
var
  Pfad: string;
  FullDateiname: string;
  i1: Integer;
  Bild: Tfrm_Bild;
  Cur: TCursor;
begin
  Cur := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    ClearBilderList;
    fVWPhotoUndBaumList.Read(aUId);
    if fVWPhotoUndBaumList.Count = 0 then
      exit;
    Pfad := PhotoOrga.Ini.Einstellung.Bilderpfad + fVWPhotoUndBaumList.Item[0].Pfad;
    ErzeugeBildImages;
    for i1 := 0 to fVWPhotoUndBaumList.Count -1 do
    begin
      log.d(IntToStr(i1));
      Bild := Tfrm_Bild(fBilderList.Items[i1]);
      FullDateiname := IncludeTrailingPathDelimiter(Pfad) + fVWPhotoUndBaumList.Item[i1].Dateiname;
      Bild.Objects := fVWPhotoUndBaumList.Item[i1];
      Bild.OnImageDblClick := ShowBildOri;
      //Bild.LoadJpg(FullDateiname);
      try
        Bild.LoadFromStream(fVWPhotoUndBaumList.Item[i1].Bild);
      except
        ShowMessage('Ladefelder: "' + FullDateiname + '"');
        log.d(fVWPhotoUndBaumList.Item[i1].Dateiname);
      end;
    end;
  finally
    Screen.Cursor := Cur;
  end;
end;


procedure Tfrm_Bilder.scMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if fOldScWidth <> sc.Width then
    BilderNeuAnordnen;
end;

procedure Tfrm_Bilder.scMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  Wnd: HWnd;
  Msg: Cardinal;
  Code: Cardinal;
  N, i: Integer;
begin

    if fOldScWidth <> sc.Width then
      BilderNeuAnordnen;
//  Wnd := WindowFromPoint(Mouse.CursorPos);
//  if Wnd = sc.Handle then
//  begin
    //One way of dealing with horz and vert scrollbars:
    if ssShift in Shift then
      Msg := WM_HSCROLL
    else
      Msg := WM_VSCROLL;
    if WheelDelta < 0 then
      Code := SB_LINEDOWN
    else
      Code := SB_LINEUP;
    N:= Mouse.WheelScrollLines;
    for i:= 1 to N do
      sc.Perform(Msg, Code, 0);
    sc.Perform(Msg, SB_ENDSCROLL, 0);
    Handled := True;
//  end
//  else
//    Handled := False;
end;

procedure Tfrm_Bilder.scResize(Sender: TObject);
begin
 // BilderNeuAnordnen;
end;



procedure Tfrm_Bilder.BilderNeuAnordnen;
var
  i1: Integer;
  BilderInRow: Integer;
  iLeft: Integer;
  iTop: Integer;
  BildInRow: Integer;
  Bild: Tfrm_Bild;
begin
  if fBilderNeuAnordnen then
    exit;
  sc.Perform(WM_VSCROLL, MakeWParam(SB_PAGEUP, 0), 0);
  fOldScWidth := sc.Width;
  fBilderNeuAnordnen := true;
  try
    BilderInRow  := AnzahlBilderInRow(fBildWidth);
    iLeft := 0;
    iTop := 0;
    BildInRow := 0;

    if fLastAnzahlBilderInRow = BilderInRow then
      exit;


    for i1 := 0 to fBilderList.Count -1 do
    begin
      if BildInRow >= BilderInRow then
      begin
        BildInRow := 1;
        iLeft := 0;
        iTop  := iTop + fBildHeight;
      end
      else
        inc(BildInRow);

      Bild := Tfrm_Bild(fBilderList.Items[i1]);
      Bild.Left := iLeft;
      Bild.Top  := iTop;

      iLeft := iLeft + fBildWidth;
    end;
  finally
    fBilderNeuAnordnen := false;
  end;

end;

function Tfrm_Bilder.AnzahlBilderInRow(aWidth: Integer): Integer;
var
  Gesamtbreite: Integer;
begin
  Result := 0;
  Gesamtbreite := aWidth;
  while Gesamtbreite < sc.ClientWidth do
  begin
    inc(Result);
    Gesamtbreite := Gesamtbreite + aWidth;
  end;
  //dec(Result);
  if Result = 0 then
    Result := 1;
end;

procedure Tfrm_Bilder.ClearBilderList;
var
  i1: Integer;
  Bild: Tfrm_Bild;
begin
  sc.OnResize := nil;
  try
    log.d('Tfrm_Bilder.ClearBilderList -> Start');
    for i1 := fBilderList.Count -1 downto 0 do
    begin
      log.d('Zeiger = ' + IntToStr(i1));
      Bild := Tfrm_Bild(fBilderList.Items[i1]);
      FreeAndNil(Bild);
    end;
    fBilderList.Clear;
  finally
    sc.OnResize := scResize;
  end;
  log.d('Tfrm_Bilder.ClearBilderList -> Ende');
end;

procedure Tfrm_Bilder.ErzeugeBildImages;
var
  BilderInRow: Integer;
  iLeft: Integer;
  iTop: Integer;
  i1: Integer;
  BildInRow: Integer;
  AnzahlBilder: Integer;
  Bild: Tfrm_Bild;
  Cur: TCursor;
begin //
  Cur := Screen.Cursor;
  try
    Screen.Cursor := crHourglass;
    ClearBilderList;
    AnzahlBilder := fVWPhotoUndBaumList.Count -1;
    BilderInRow  := AnzahlBilderInRow(fBildWidth);
    iLeft := 0;
    iTop := 0;
    BildInRow := 0;
    for i1 := 0 to AnzahlBilder do
    begin
      if BildInRow >= BilderInRow then
      begin
        BildInRow := 0;
        iLeft := 0;
        iTop  := iTop + fBildHeight;
      end
      else
        inc(BildInRow);

      Bild := Tfrm_Bild.Create(sc);
      Bild.Parent := sc;
      Bild.show;
      fBilderList.Add(Bild);
      Bild.Left := iLeft;
      Bild.Top  := iTop;

      iLeft := iLeft + fBildWidth;

    end;
    fLastAnzahlBilderInRow := BilderInRow;
  finally
    Screen.Cursor := Cur;
  end;
end;


procedure Tfrm_Bilder.ShowBildOri(Sender: TObject);
var
  VWPhotoUndBaum: TVWPhotoUndBaum;
  Pfad: String;
  FullDateiname: string;
begin
  VWPhotoUndBaum := TVWPhotoUndBaum(Sender);
  //Pfad := PhotoOrga.Ini.Einstellung.Bilderpfad + VWPhotoUndBaum.Pfad;
  Pfad := VWPhotoUndBaum.Pfad;
  FullDateiname := IncludeTrailingPathDelimiter(Pfad) + VWPhotoUndBaum.Dateiname;
  if not FileExists(FullDateiname) then
  begin
    ShowMessage('Bild exisitiert nicht.');
    exit;
  end;
  fFormBildOri.LadeBild(FullDateiname);
  fFormBildOri.ShowModal;
end;


end.
