unit Objekt.Zip;

interface

uses
  SysUtils, Classes, System.Zip;

type
  TZip = class
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure DoZipFile(aZipFullFilename, aFilename: string);
  end;


implementation

{ TZip }

constructor TZip.Create;
begin

end;

destructor TZip.Destroy;
begin

  inherited;
end;

procedure TZip.DoZipFile(aZipFullFilename, aFilename: string);
var
  ZipFile: TZipFile;
begin
  ZipFile := TZipFile.Create;
  try
     ZipFile.Open(aZipFullFilename, zmWrite);
     zipFile.Add(aFilename);
     zipfile.Close;
  finally
    FreeAndNil(ZipFile);
  end;
end;

end.
