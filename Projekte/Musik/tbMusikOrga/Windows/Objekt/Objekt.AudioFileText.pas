unit Objekt.AudioFileText;

interface

uses
  System.SysUtils, System.Variants, System.Classes;

type
  TAudioFileText = class
  private
    fLanguageId: string;
    fDescription: string;
    fText: string;
  public
    constructor Create;
    destructor Destroy; override;
    property LanguageId: string read fLanguageId write fLanguageId;
    property Description: string read fDescription write fDescription;
    property Text: string read fText write fText;
    procedure Init;
  end;

implementation

{ TAudioFileText }

constructor TAudioFileText.Create;
begin
  Init;
end;

destructor TAudioFileText.Destroy;
begin

  inherited;
end;

procedure TAudioFileText.Init;
begin
  fLanguageId  := '';
  fDescription := '';
  fText   := '';
end;

end.
