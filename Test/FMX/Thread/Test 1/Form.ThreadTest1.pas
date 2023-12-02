unit Form.ThreadTest1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Layouts, Objekt.Hauptverarbeitung;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    lbl_Status: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fHauptverarbeitung: THauptverarbeitung;
    procedure EndeHauptverarbeitung(Sender: TObject);
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
begin
  fHauptverarbeitung.Start;
{
  Tthread.CreateAnonymousThread(
    procedure
    begin
      Sleep(5000);
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        Memo1.Lines.Add('Hurra');
      end
      )
    end
  ).Start;
}
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Add('Test');
end;

procedure TForm2.EndeHauptverarbeitung(Sender: TObject);
begin
  lbl_Status.Text := 'Fertig';
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  fHauptverarbeitung := THauptverarbeitung.Create;
  fHauptverarbeitung.setStatusLabel(lbl_Status);
  fHauptverarbeitung.OnEnde := EndeHauptverarbeitung;

end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fHauptverarbeitung);
end;

end.
