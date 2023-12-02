unit PrConstVars;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;


var
  ProgPath, ExeName: String;
  ThumbMass, NormMass, BigMass: Integer;
  InPath, FName,
  ThumbPath, ThumbPrefix,
  NormPath, NormPrefix,
  BigPath, BigPrefix,
  UrPath: string;

implementation

/////////////////////////////////////////////////////////////
var mHandle: THandle;

initialization

ExeName:=ExtractFilename(Application.ExeName);
mHandle:=CreateMutex(nil,True,PChar(ExeName));
if GetLastError = ERROR_ALREADY_EXISTS then Halt;

finalization

if mHandle<>0 then CloseHandle(mHandle);

end.

