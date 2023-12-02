unit Form.Protokoll;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls;

type
  Tfrm_Protokoll = class(TForm)
    mem_Protokoll: TMemo;
    btn_ClearProtokoll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ClearProtokollClick(Sender: TObject);
  private
    //fFilename: string;
    procedure AfterWriteProtokoll(aValue: string);
  public
  end;

var
  frm_Protokoll: Tfrm_Protokoll;

implementation

{$R *.fmx}

uses
  Objekt.TSIServer2, System.IOUtils;


procedure Tfrm_Protokoll.FormCreate(Sender: TObject);
begin  //
  //fFilename := TSIServer2.IniPfad + 'Protokoll.txt';
  mem_Protokoll.Lines.Clear;
  TSIServer2.Protokoll.Load;
  TSIServer2.Protokoll.onAfterWrite := AfterWriteProtokoll;
  mem_Protokoll.Lines.Text := TSIServer2.Protokoll.List.Text;
//  if FileExists(fFilename) then
//    mem_Protokoll.Lines.LoadFromFile(fFilename);
end;

procedure Tfrm_Protokoll.FormDestroy(Sender: TObject);
begin //

end;

procedure Tfrm_Protokoll.FormShow(Sender: TObject);
begin //
end;

procedure Tfrm_Protokoll.AfterWriteProtokoll(aValue: string);
begin
  mem_Protokoll.Lines.Add(aValue);
end;

procedure Tfrm_Protokoll.btn_ClearProtokollClick(Sender: TObject);
begin
  //DeleteFile(fFilename);
  mem_Protokoll.Lines.Clear;
  TSIServer2.Protokoll.Clear;
end;



end.
