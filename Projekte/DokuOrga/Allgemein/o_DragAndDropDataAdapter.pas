unit o_DragAndDropDataAdapter;

interface

uses
  System.SysUtils, Classes, DragDropFile, Winapi.ActiveX, Dialogs; //, o_ObjOutlookDrop;

type
  TDragAndDropDataAdapter = class
  private
  public
    procedure SaveVirtualFileStream(aVirtualFileStreamDataFormat: TVirtualFileStreamDataFormat; aPfad: string; const aCopiedList: TStrings = nil);
   // procedure SaveOutlook(aOutlookDrop: TObjOutlookDrop; aPfad: string);
  end;

implementation

{ TDragAndDropDataAdapter }


procedure TDragAndDropDataAdapter.SaveVirtualFileStream(
  aVirtualFileStreamDataFormat: TVirtualFileStreamDataFormat; aPfad: string; const aCopiedList: TStrings = nil);
type
  PLargeint = ^Largeint;

var
  i1: Integer;
  FileName: string;
  StatStg: TStatStg;
  Stream: IStream;
  MyFile: TFileStream;
  Dateiname: string;
  Total, BufferSize, Chunk, Size: longInt;
  Buffer: AnsiString;
  p: PAnsiChar;
  Dummy: UInt64;
const
  MaxBufferSize = 32 * 1024; // 32Kb

begin
  if aCopiedList <> nil then
    aCopiedList.Clear;
  aPfad := IncludeTrailingPathDelimiter(aPfad);
  for i1 := 0 to aVirtualFileStreamDataFormat.FileNames.Count - 1 do
  begin
    FileName := aVirtualFileStreamDataFormat.FileNames[i1];
    Stream   := aVirtualFileStreamDataFormat.FileContentsClipboardFormat.GetStream(i1);
    if Stream = nil then
    begin
      //ShowMsg(aOwner, 'Der Dateiinhalt von "' + FileName + '" konnte nicht gelesen werden.', mtError, [mbOk]);
      continue;
    end;

    Dateiname := aPfad + Filename;
    try
      MyFile := TFileStream.Create(Dateiname, fmCreate);
    except
      on E: Exception do
      begin
        MessageDlg(E.Message, mtError, [mbOk],0);
        continue;
      end;
    end;
    try
      Stream.Stat(StatStg, STATFLAG_NONAME);
      Total := StatStg.cbSize;
      Stream.Seek(0, STREAM_SEEK_SET, Dummy);
      //Stream.Seek(0, STREAM_SEEK_SET, PLargeint(nil)^);
      BufferSize := Total;
      if (BufferSize > MaxBufferSize) then
        BufferSize := MaxBufferSize;

      SetLength(Buffer, BufferSize);
      p := PAnsiChar(Buffer);
      Chunk := BufferSize;
      while (Total > 0) do
      begin
        Stream.Read(p, Chunk, @Size);
        if (Size = 0) then
          break;

        inc(p, Size);
        dec(Total, Size);
        dec(Chunk, Size);

        if (Chunk = 0) or (Total = 0) then
        begin
          p := PAnsiChar(Buffer);
          MyFile.WriteBuffer(p^, BufferSize - Chunk);
          Chunk := BufferSize;
        end;
      end;

      aCopiedList.Add(Dateiname);

    finally
      FreeAndNil(MyFile);
    end;



  end;
end;


{
procedure TDragAndDropDataAdapter.SaveOutlook(aOutlookDrop: TObjOutlookDrop; aPfad: string);
var
  TextList: TStringList;
  Titel: string;
  i1: Integer;
  Dateiname: string;
begin
  aPfad := IncludeTrailingPathDelimiter(aPfad);
  aOutlookDrop.Dropped;
  if aOutlookDrop.OutlookDropMessages.Count > 0 then
  begin
    TextList := TStringList.Create;
    try
      for i1 := 0 to aOutlookDrop.OutlookDropMessages.Count - 1 do
      begin
        TextList.Add('Von : ' + aOutlookDrop.OutlookDropMessages.Item[i1].Von + ' <' + aOutlookDrop.OutlookDropMessages.Item[i1].Von_eMail + '>');
        TextList.Add('An : ' + aOutlookDrop.OutlookDropMessages.Item[i1].An);
        TextList.Add('Betreff : ' + aOutlookDrop.OutlookDropMessages.Item[i1].Betreff);
        TextList.Add('');
        TextList.Add('');
        TextList.Add(aOutlookDrop.OutlookDropMessages.Item[i1].BodyText);
      end;
      Titel := Copy(Trim(aOutlookDrop.OutlookDropMessages.Item[0].Betreff), 1, 125);


      Dateiname := Titel + '_' + FormatDateTime('yymmdd', now) + '.mail';

      TextList.SaveToFile(Dateiname);
      TextList.Clear;
    finally
      FreeAndNil(TextList);
    end;
  end;
end;
}

end.
