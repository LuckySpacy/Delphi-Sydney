unit Objekt.AudioFileList;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Objekt.Basislist,
  Objekt.AudioFile;

type
  TAudioFileList = class(TBasisList)
  private
    function getItem(aIndex: Integer): TAudioFile;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Item[aIndex: Integer]: TAudioFile read getItem;
    function Add: TAudioFile;
  end;

implementation

{ TAudioFileList }


constructor TAudioFileList.Create;
begin
  inherited;

end;

destructor TAudioFileList.Destroy;
begin

  inherited;
end;

function TAudioFileList.getItem(aIndex: Integer): TAudioFile;
begin
  Result := nil;
  if aIndex > fList.Count then
    exit;
  Result := TAudioFile(fList.Items[aIndex]);
end;

function TAudioFileList.Add: TAudioFile;
begin
  Result := TAudioFile.Create;
  fList.Add(Result);
end;



end.
