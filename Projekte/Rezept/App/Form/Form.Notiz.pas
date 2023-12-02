unit Form.Notiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  Rest.Rezept, FMX.Forms, FMX.Types, FMX.Controls, FMX.TMSBaseControl,
  FMX.TMSScrollControl, FMX.TMSRichEditorBase, FMX.TMSRichEditor,
  FMX.TMSToolBar, FMX.TMSRichEditorToolBar;

type
  Tfrm_Notiz = class(TForm)
    TMSFMXRichEditor1: TTMSFMXRichEditor;
    TMSFMXRichEditorFormatToolBar1: TTMSFMXRichEditorFormatToolBar;
  private
    fRezept: TRestRezept;
  public
    procedure setRezept(aRezept: TRestRezept);
  end;

var
  frm_Notiz: Tfrm_Notiz;

implementation

{$R *.fmx}

{ Tfrm_Notiz }

procedure Tfrm_Notiz.setRezept(aRezept: TRestRezept);
var
  List: TStringList;
  m: TMemoryStream;
begin
  fRezept := aRezept;
  List := TStringList.Create;
  m := TMemoryStream.Create;
  List.Text := fRezept.FieldByName('Notiz').AsString;
  List.SaveToStream(m);
  m.Position := 0;
  //re.InsertAsRTF(fRezept.FieldByName('PLAINBESCHREIBUNG').AsString);
  //re.InsertAsRTF(fRezept.FieldByName('Notiz').AsString);
  //reRTFIO.Load()
  //re.LoadFromStream(m);
  FreeAndNil(List);
  FreeAndNil(m);
end;

end.
