program FileSaverBat;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Winapi.Windows,
  Objekt.Allgemein,
  Objekt.OptionList,
  Objekt.Option,
  Objekt.Dateisystem,
  Objekt.DateiList,
  Objekt.FileSaver in 'Objekt\Objekt.FileSaver.pas',
  Objekt.Zip in '..\..\Allgemein\Objekt\Objekt.Zip.pas',
  Objekt.Datei in '..\..\Allgemein\Objekt\Objekt.Datei.pas',
  Log4D in '..\..\..\Log4d\Log4D.pas';

var
  AllgemeinObj : TAllgemeinObj;
  FileSaver  : TFileSaver;
begin

  try
    AllgemeinObj := TAllgemeinObj.create;
    FileSaver    := TFileSaver.Create(AllgemeinObj);
    try
      AllgemeinObj.Log.DienstInfo('ServiceCreate');
      AllgemeinObj.Log.DienstInfo('Version 1.0.0 vom 21.02.2021 10:30');
      FileSaver.CopyStart;
      AllgemeinObj.Log.DienstInfo('ServiceEnde');
    finally
      FreeAndNil(AllgemeinObj);
      FreeAndNil(FileSaver);
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
