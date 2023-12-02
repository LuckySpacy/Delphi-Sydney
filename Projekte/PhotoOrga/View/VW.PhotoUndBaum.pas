unit VW.PhotoUndBaum;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, IBX.IBQuery, VW.Base, Data.db, DB.TBQuery;

type
  TVWPhotoUndBaum = class(TVWBasis)
 private
    fDateiname: string;
    fPHUId: string;
    fPBUId: string;
    fDatum: TDateTime;
    fBild: TMemoryStream;
    fPfad: string;
    fBildname: string;
    fPosNr: Integer;
 protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property PHUId: string read fPHUId write fPHUId;
    property PBUId: string read fPBUId write fPBUId;
    property Bildname: string read fBildname write fBildname;
    property Dateiname: string read fDateiname write fDateiname;
    property Pfad: string read fPfad write fPfad;
    property Bild: TMemoryStream read fBild write fBild;
    property Datum: TDateTime read fDatum write fDatum;
    property PosNr: Integer read fPosNr write fPosNr;
    procedure Init;
    procedure LoadByQuery(aQuery: TTBQuery); override;
  end;


implementation

{ TVWPhotoUndBaum }

constructor TVWPhotoUndBaum.Create(AOwner: TComponent);
begin
  inherited;
  fBild := TMemoryStream.Create;
end;

destructor TVWPhotoUndBaum.Destroy;
begin
  FreeAndNil(fBild);
  inherited;
end;


procedure TVWPhotoUndBaum.Init;
begin
  fDateiname := '';
  fPHUId     := '';
  fPBUId     := '';
  fDatum     := 0;
  fPfad      := '';
  fBildname  := '';
  fPosNr     := 0;
  fBild.Clear;
end;

procedure TVWPhotoUndBaum.LoadByQuery(aQuery: TTBQuery);
begin
  inherited;
  fDateiname := aQuery.FieldByName('PH_DATEINAME').AsString;
  fDatum     := aQuery.FieldByName('PH_DATUM').AsDateTime;
  //fBild      := aQuery.FieldByName('PH_BILD').AsString;
  fPfad      := aQuery.FieldByName('PH_PFAD').AsString;
  fBildname  := aQuery.FieldByName('PH_NAME').AsString;
  fPHUId     := aQuery.FieldByName('PH_UID').AsString;
  fPBUId     := aQuery.FieldByName('PU_PBUID').AsString;
  fPosNr     := aQuery.FieldByName('PU_POSNR').AsInteger;
  aQuery.LoadFromStream(fBild, TBlobField(aQuery.FieldByName('PH_BILD')));
end;

end.
