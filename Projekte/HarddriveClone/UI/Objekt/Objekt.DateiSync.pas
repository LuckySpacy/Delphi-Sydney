unit Objekt.DateiSync;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Form.JobView, Vcl.Controls,
  Objekt.Datei, Objekt.DateiList;


type
  TDateiSync = class
  private
    fZiel: TDateiList;
    fQuell: TDateiList;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Quell: TDateiList read fQuell write fQuell;
    property Ziel: TDateiList read fZiel write fZiel;
  end;

implementation

{ TDateiSyncList }

constructor TDateiSync.Create;
begin
  fZiel   := TDateiList.Create;
  fQuell  := TDateiList.Create;
end;

destructor TDateiSync.Destroy;
begin
  FreeAndNil(fZiel);
  FreeAndNil(fQuell);
  inherited;
end;

end.
