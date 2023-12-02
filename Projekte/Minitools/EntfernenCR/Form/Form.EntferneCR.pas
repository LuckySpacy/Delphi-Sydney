unit Form.EntferneCR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvEdit, AdvEdBtn, AdvFileNameEdit, Vcl.ExtCtrls;

type
  Tfrm_EntferneCR = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    edt_File: TAdvFileNameEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frm_EntferneCR: Tfrm_EntferneCR;

implementation

{$R *.dfm}

procedure Tfrm_EntferneCR.Button1Click(Sender: TObject);
var
  Pfad: string;
  Dateiname: string;
  DateinameOhneExt: string;
  fText: TStringList;
  s: string;
  SaveFilename: string;
begin
  if not FileExists(edt_File.Text) then
  begin
    ShowMessage('Datei existiert nicht');
    exit;
  end;
  fText := TStringList.Create;
  try
    Pfad := IncludeTrailingPathDelimiter(ExtractFilePath(edt_File.Text));
    Dateiname := ExtractFileName(edt_File.Text);
    DateinameOhneExt := copy(Dateiname, 1, Length(Dateiname)-4);
    SaveFilename := Pfad + DateinameOhneExt + '_copy.txt';
    fText.LoadFromFile(edt_File.Text);
    s := fText.Text;
    s := StringReplace(s, #$D, '', [rfReplaceAll]);
    s := StringReplace(s, #$A, '', [rfReplaceAll]);
    fText.Text := s;
    fText.SaveToFile(SaveFilename);
    //s := StringReplace(s, )
  finally
    FreeAndNil(fText);
  end;

end;

end.
