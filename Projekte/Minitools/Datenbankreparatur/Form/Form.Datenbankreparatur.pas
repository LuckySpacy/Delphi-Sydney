unit Form.Datenbankreparatur;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBDatabase, Vcl.StdCtrls, IBX.IBCustomDataSet, IBX.IBQuery, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    IBD: TIBDatabase;
    Button1: TButton;
    IBD_Alt: TIBDatabase;
    btn_Vorgangpos: TButton;
    Trans: TIBTransaction;
    Trans_Alt: TIBTransaction;
    qry: TIBQuery;
    qry_Alt: TIBQuery;
    pg: TProgressBar;
    Memo1: TMemo;
    btn_Abbruch: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_VorgangposClick(Sender: TObject);
    procedure btn_AbbruchClick(Sender: TObject);
  private
    fCancel: Boolean;
    procedure RestoreVorganpos(aStart, aEnde: TDateTime);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
  IBD.Connected;
  IBD_ALT.Connected;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  IBD.DatabaseName := 'localhost:c:\datenbank\rehatec.fdb';
  IBD_ALT.DatabaseName := 'localhost:c:\datenbank\REHATEC_vorUpdate.fdb';
end;


procedure TForm1.btn_AbbruchClick(Sender: TObject);
begin
  fCancel := true;
end;

procedure TForm1.btn_VorgangposClick(Sender: TObject);
var
  i1: Integer;
begin
  Button1Click(nil);
  IBD.Open;
  IBD_Alt.Open;
  Memo1.Clear;

  {
  qry.SQL.Text := 'update vorgangpos set vp_langbez = :langbez, vp_produktionstextrtf = :prodtextrtf, vp_langbezrtf = :langbezrtf, ' +
                      'vp_bezrtf = :bezrtf, vp_richtscheintext = :richtscheintext where vp_id = :vpid';
  //qry_Alt.SQL.Text := 'select * from vorgangpos where vp_au_id =624441';
  qry_Alt.SQL.Text := 'select vp_id, vp_langbez, vp_produktionstextrtf, vp_langbezrtf, vp_bezrtf, vp_richtscheintext ' +
                      ' from vorgangpos ' +
                      ' where vp_delete != "T"' +
                      ' and vp_id >= 2986160';
//                      ' and vp_au_id =624441';
  trans.StartTransaction;
  trans_Alt.StartTransaction;
  qry.Prepare;
  qry_Alt.Close;
  qry_Alt.Open;
  qry_alt.FetchAll;
  pg.Max := qry_alt.RecordCount;
  qry_alt.First;
  while not qry_Alt.Eof do
  begin
    pg.StepIt;
    qry.ParamByName('langbez').AsString := qry_Alt.FieldByName('vp_langbez').AsString;
    qry.ParamByName('prodtextrtf').AsString := qry_Alt.FieldByName('vp_produktionstextrtf').AsString;
    qry.ParamByName('langbezrtf').AsString := qry_Alt.FieldByName('vp_langbezrtf').AsString;
    qry.ParamByName('bezrtf').AsString := qry_Alt.FieldByName('vp_bezrtf').AsString;
    qry.ParamByName('richtscheintext').AsString := qry_Alt.FieldByName('vp_richtscheintext').AsString;
    qry.ParamByName('vpid').AsInteger := qry_Alt.FieldByName('vp_id').AsInteger;
    qry.ExecSQL;

    qry_Alt.Next;
  end;

  qry_Alt.Close;
  trans.commit;
  trans_alt.Rollback;
  qry.Unprepare;
       }


  fCancel := false;
  for i1 := 2020 downto 2011 do
  begin
    if fCancel then
      exit;
    Memo1.Lines.Add('Jahr ' + IntToStr(i1));
    memo1.Update;
    memo1.Refresh;
    memo1.Invalidate;
    Application.ProcessMessages;
    RestoreVorganpos(StrToDate('01.01.' + IntToStr(i1)), StrToDate('31.12.' + IntToStr(i1)));
    //RestoreVorganpos(StrToDate('01.01.' + IntToStr(i1)), StrToDate('01.02.' + IntToStr(i1)));
  end;

end;

procedure TForm1.RestoreVorganpos(aStart, aEnde: TDateTime);
var
  i1: Integer;
begin
  qry.SQL.Text := 'update vorgangpos set vp_langbez = :langbez, vp_produktionstextrtf = :prodtextrtf, vp_langbezrtf = :langbezrtf, ' +
                      'vp_bezrtf = :bezrtf, vp_richtscheintext = :richtscheintext, ' +
                      ' vp_kommentar = :kommentar, vp_produktionstext = :prodtext' +
                      ' where vp_id = :vpid';
  qry_Alt.SQL.Text := 'select vp_id, vp_langbez, vp_produktionstextrtf, vp_langbezrtf, vp_bezrtf, vp_richtscheintext, ' +
                      ' vp_kommentar, vp_produktionstext ' +
                      ' from vorgangpos ' +
                      ' join vorgang on vo_id = vp_au_id and vo_delete != "T" ' +
                      ' where vp_delete != "T"' +
                      ' and vo_datum >= :start' +
                      ' and vo_datum <= :ende';
  qry_Alt.ParamByName('start').AsDatetime := aStart;
  qry_Alt.ParamByName('ende').AsDatetime := aEnde;

  trans.StartTransaction;
  trans_Alt.StartTransaction;
  qry.Prepare;
  qry_Alt.Close;
  qry_Alt.Open;
  qry_alt.FetchAll;
  pg.Position := 0;
  pg.Max := qry_alt.RecordCount;
  qry_alt.First;
  i1 := 0;
  while not qry_Alt.Eof do
  begin
    pg.Position := pg.Position + 1;
    qry.ParamByName('langbez').AsString := qry_Alt.FieldByName('vp_langbez').AsString;
    qry.ParamByName('prodtextrtf').AsString := qry_Alt.FieldByName('vp_produktionstextrtf').AsString;
    qry.ParamByName('langbezrtf').AsString := qry_Alt.FieldByName('vp_langbezrtf').AsString;
    qry.ParamByName('bezrtf').AsString := qry_Alt.FieldByName('vp_bezrtf').AsString;
    qry.ParamByName('richtscheintext').AsString := qry_Alt.FieldByName('vp_richtscheintext').AsString;
    qry.ParamByName('kommentar').AsString := qry_Alt.FieldByName('vp_kommentar').AsString;
    qry.ParamByName('prodtext').AsString := qry_Alt.FieldByName('vp_produktionstext').AsString;
    qry.ParamByName('vpid').AsInteger := qry_Alt.FieldByName('vp_id').AsInteger;
    qry.ExecSQL;
    inc(i1);
    if i1 > 10 then
    begin
      i1 := 0;
      trans.commit;
      trans.StartTransaction;
      Application.ProcessMessages;
    end;
    if fCancel then
      break;
    qry_Alt.Next;
  end;

    Memo1.Lines.Add('trans.commit;');
    memo1.Update;
    memo1.Refresh;
    memo1.Invalidate;
    Application.ProcessMessages;

  trans.commit;


    Memo1.Lines.Add('trans_alt.Rollback;');
    memo1.Update;
    memo1.Refresh;
    memo1.Invalidate;
    Application.ProcessMessages;

  trans_alt.Rollback;
    Memo1.Lines.Add('qry.Unprepare;');
    memo1.Update;
    memo1.Refresh;
    memo1.Invalidate;
    Application.ProcessMessages;
  qry.Unprepare;

    Memo1.Lines.Add('qry_Alt.Close');
    memo1.Update;
    memo1.Refresh;
    memo1.Invalidate;
    Application.ProcessMessages;

  qry_Alt.Close;

end;


end.
