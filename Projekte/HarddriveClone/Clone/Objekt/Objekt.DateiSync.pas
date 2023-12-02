unit Objekt.DateiSync;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Vcl.Controls,
  Objekt.Datei, Objekt.DateiList;


type
  TDateiSync = class
  private
    fZiel: TDateiList;
    fQuell: TDateiList;
    fQuellpfad: string;
    fZielpfad: string;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property Quell: TDateiList read fQuell write fQuell;
    property Ziel: TDateiList read fZiel write fZiel;
    property Zielpfad: string read fZielpfad write fZielpfad;
    property Quellpfad: string read fQuellpfad write fQuellpfad;
  end;

implementation

{ TDateiSyncList }

constructor TDateiSync.Create;
begin
  fZiel   := TDateiList.Create;
  fQuell  := TDateiList.Create;
  fZielpfad  := '';
  fQuellpfad := '';
end;

destructor TDateiSync.Destroy;
begin
  FreeAndNil(fZiel);
  FreeAndNil(fQuell);
  inherited;
end;

end.
