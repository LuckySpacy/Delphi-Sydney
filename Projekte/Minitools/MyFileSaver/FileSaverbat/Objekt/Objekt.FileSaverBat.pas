unit Objekt.FileSaverBat;

interface

uses
  SysUtils, Classes, Objekt.OptionList, Objekt.Option, Objekt.Dateisystem,
  Objekt.DateiList, Vcl.ExtCtrls;

type
  TFileSaverBat = class
  private
    fOptionList: TOptionList;
    fDateiSystem: TDateisystem;
    fDateiList: TDateiList;
    procedure Check(Sender: TObject);
    procedure DeleteFileEvent(aDeleteFile: string);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    function Pfad: string;
    function DataFilename: string;
    procedure CopyStart;
  end;


implementation

{ TFileSaverBat }

constructor TFileSaverBat.Create;
begin

end;


destructor TFileSaverBat.Destroy;
begin

  inherited;
end;

procedure TFileSaverBat.Init;
begin

end;


procedure TFileSaverBat.Check(Sender: TObject);
begin

end;

procedure TFileSaverBat.CopyStart;
begin

end;


function TFileSaverBat.DataFilename: string;
begin

end;

procedure TFileSaverBat.DeleteFileEvent(aDeleteFile: string);
begin

end;


function TFileSaverBat.Pfad: string;
begin

end;

end.
