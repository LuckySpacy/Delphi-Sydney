unit Objekt.JobViewList;

interface

uses
  SysUtils, Classes, Contnrs, Objekt.BasisList, Form.JobView, Vcl.Controls,
  Objekt.Job;


type
  TJobViewList = class(TBasisList)
  private
    fParentForm: TWinControl;
    fJob: TJob;
    function getJobView(Index: Integer): Tfrm_JobView;
    procedure deSelectAll;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add: Tfrm_JobView;
    property Item[Index: Integer]: Tfrm_JobView read getJobView;
    property ParentJobView: TWinControl read fParentForm write fParentForm;
    procedure setSelect(aJobView: Tfrm_JobView);
    function getSelected: Tfrm_JobView;
    function DeleteSelected: Boolean;
    procedure setJob(aJob: TJob);
  end;

implementation

{ TJobViewList }


constructor TJobViewList.Create;
begin
  inherited;
  fParentForm := nil;
end;



destructor TJobViewList.Destroy;
begin

  inherited;
end;


function TJobViewList.Add: Tfrm_JobView;
begin
  Result := Tfrm_JobView.Create(nil);
  Result.Parent := ParentJobView;
  fList.Add(Result);
  Result.Align := alTop;
  Result.AlignWithMargins := true;
  Result.Show;
end;


function TJobViewList.getJobView(Index: Integer): Tfrm_JobView;
begin
  Result := nil;
  if Index > fList.Count -1 then
    exit;
  Result := Tfrm_JobView(fList[Index]);
end;



function TJobViewList.getSelected: Tfrm_JobView;
var
  i1: Integer;
  JobView: Tfrm_JobView;
begin
  Result := nil;
  for i1 := 0 to fList.Count -1 do
  begin
    JobView := Tfrm_JobView(fList[i1]);
    if JobView.Shape1.Visible then
    begin
      Result := JobView;
      exit;
    end;
  end;
end;


function TJobViewList.DeleteSelected: Boolean;
var
  i1: Integer;
  JobView: Tfrm_JobView;
begin
  Result := false;
  for i1 := 0 to fList.Count -1 do
  begin
    JobView := Tfrm_JobView(fList[i1]);
    if JobView.Shape1.Visible then
    begin
      Delete(i1);
      Result := true;
      exit;
    end;
  end;
end;


procedure TJobViewList.deSelectAll;
var
  i1: Integer;
  JobView: Tfrm_JobView;
begin
  for i1 := 0 to fList.Count -1 do
  begin
    JobView := Tfrm_JobView(fList[i1]);
    JobView.setSelect(false);
  end;
end;

procedure TJobViewList.setJob(aJob: TJob);
begin
  fJob := aJob;
end;

procedure TJobViewList.setSelect(aJobView: Tfrm_JobView);
begin
  deSelectAll;
  aJobView.setSelect(true);
end;

end.
