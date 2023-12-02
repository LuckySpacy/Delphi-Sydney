unit Objekt.FormPointer;

interface

uses
  SysUtils, Classes, Variants;

type
  TFormPointer = class
  private
    fMainMenu: Pointer;
    fForm: Pointer;
  public
    constructor Create;
    destructor Destroy; override;
    property Form: Pointer read fForm write fForm;
    property MainMenu: Pointer read fMainMenu write fMainMenu;
  end;

implementation

{ TFormPointer }

constructor TFormPointer.Create;
begin

end;

destructor TFormPointer.Destroy;
begin

  inherited;
end;

end.
