unit Objekt.AudioFilePictureList;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Objekt.Basislist,
  Objekt.AudioFilePicture;

type
  TAudioFilePictureList = class(TBasisList)
  private
    function getItem(Index: Integer): TAudioFilePicture;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[Index:Integer]: TAudioFilePicture read getItem;
    function Add: TAudioFilePicture;
  end;

implementation

{ TAudioFilePictureList }


constructor TAudioFilePictureList.Create;
begin
  inherited;
end;

destructor TAudioFilePictureList.Destroy;
begin

  inherited;
end;

function TAudioFilePictureList.getItem(Index: Integer): TAudioFilePicture;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := TAudioFilePicture(fList.Items[Index]);
end;

function TAudioFilePictureList.Add: TAudioFilePicture;
begin
  Result := TAudioFilePicture.Create;
  fList.Add(Result);
end;


end.
