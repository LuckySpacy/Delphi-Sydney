unit Form.QuellZiel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.FileCtrl, Objekt.Job;

type
  Tfrm_QuellZiel = class(TForm)
    pnl_Quell: TPanel;
    pnl_Ziel: TPanel;
    Splitter1: TSplitter;
    pnl_Button: TPanel;
    btn_Ok: TButton;
    btn_Cancel: TButton;
    QuellDir: TDirectoryListBox;
    ZielDir: TDirectoryListBox;
    Label1: TLabel;
    Label2: TLabel;
    QuellDrive: TDriveComboBox;
    ZielDrive: TDriveComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  private
    fCancel: Boolean;
    fQuellPfad: string;
    fZielPfad: string;
    fFullFilename: string;
    fJob: TJob;
    { Private-Deklarationen }
  public
    property Cancel: Boolean read fCancel;
    property Quellpfad: string read fQuellPfad write fQuellPfad;
    property Zielpfad: string read fZielPfad write fZielPfad;
    property FullFilename: string read fFullFilename write fFullFilename;
    property Job: TJob read fJob;
  end;

var
  frm_QuellZiel: Tfrm_QuellZiel;

implementation

{$R *.dfm}

uses
  Objekt.HarddriveClone;


procedure Tfrm_QuellZiel.FormCreate(Sender: TObject);
begin
  fCancel := true;
  fQuellPfad := '';
  fZielPfad  := '';
  fFullFilename := '';
  fJob := nil;
end;

procedure Tfrm_QuellZiel.FormDestroy(Sender: TObject);
begin //

end;


procedure Tfrm_QuellZiel.btn_CancelClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_QuellZiel.btn_OkClick(Sender: TObject);
begin
  fCancel := false;
  fQuellpfad := QuellDir.GetItemPath(QuellDir.ItemIndex);// + QuellDir.Items[QuellDir.ItemIndex];
  fZielPfad  := ZielDir.GetItemPath(ZielDir.ItemIndex);// + ZielDir.Items[ZielDir.ItemIndex];
  fJob := HarddriveClone.JobList.Add;
  fJob.Quell := fQuellPfad;
  fJob.Ziel  := fZielPfad;
  fJob.SaveToFile;
  fFullFilename := fJob.FullFilename;
  close;
end;

procedure Tfrm_QuellZiel.FormClose(Sender: TObject; var Action: TCloseAction);
begin //
end;


end.
