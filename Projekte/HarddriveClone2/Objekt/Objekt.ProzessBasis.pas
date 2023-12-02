unit Objekt.ProzessBasis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.Base, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TInfoEvent = procedure(aCaption, aProzessInfo: string; var aCancel: Boolean) of object;
  TInfoProzessEvent = procedure(aProzessInfo: string; var aCancel: Boolean) of object;
  TProgressStartEvent = procedure(aCount: Integer; var aCancel: Boolean) of object;
  TProgressInfoEvent = procedure(aProgress: Integer; var aCancel: Boolean) of object;
  TProzessBasis = class
  private
    fOnFinished: TNotifyEvent;
  protected
    fOnInfoProzess: TInfoProzessEvent;
    fOnProgressStart: TProgressStartEvent;
    fOnProgressInfo: TProgressInfoEvent;
    fOnInfo: TInfoEvent;
    procedure Finished(Sender: TObject);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property OnInfo: TInfoEvent read fOnInfo write fOnInfo;
    property OnInfoProzess: TInfoProzessEvent read fOnInfoProzess write fOnInfoProzess;
    property OnProgressInfo: TProgressInfoEvent read fOnProgressInfo write fOnProgressInfo;
    property OnProgressStart: TProgressStartEvent read fOnProgressStart write fOnProgressStart;
    property OnFinished: TNotifyEvent read fOnFinished write fOnFinished;
  end;

implementation

{ TProzessBasis }

constructor TProzessBasis.Create;
begin

end;

destructor TProzessBasis.Destroy;
begin

  inherited;
end;

procedure TProzessBasis.Finished(Sender: TObject);
begin
  if Assigned(fOnFinished) then
    fOnFinished(Self);
end;

end.
