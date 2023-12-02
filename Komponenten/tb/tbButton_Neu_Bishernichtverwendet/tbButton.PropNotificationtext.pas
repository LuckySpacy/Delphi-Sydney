unit tbButton.PropNotificationtext;

interface

uses
  Classes, SysUtils, Contnrs, Controls, StdCtrls, ExtCtrls, Graphics;

type
  TtbButtonPropNotificationtext = class(TPersistent)
  private
    fOnChanged: TNotifyEvent;
  protected
  public
    constructor Create;
    destructor Destroy; override;
  published
    property OnChanged: TNotifyEvent read fOnChanged write fOnChanged;
  end;

implementation

{ TtbButtonPropNotificationtext }

constructor TtbButtonPropNotificationtext.Create;
begin

end;

destructor TtbButtonPropNotificationtext.Destroy;
begin

  inherited;
end;

end.
