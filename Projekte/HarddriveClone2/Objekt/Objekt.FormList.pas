unit Objekt.FormList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFormList = class
  private
    fAllForms: TList;
    fFormHistoryList: TList;
    fParentForm: TForm;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddToAllForms(aForm: TForm);
    procedure ShowForm(aFormname: string);
    property ParentForm: TForm read fParentForm write fParentForm;
    procedure CloseForm;
  end;

implementation

{ TFormList }

uses
  Form.Base;



constructor TFormList.Create;
begin
  fAllForms := TList.Create;
  fFormHistoryList := TList.Create;
  fParentForm := nil;
end;

destructor TFormList.Destroy;
begin
  FreeAndNil(fAllForms);
  FreeAndNil(fFormHistoryList);
  inherited;
end;

procedure TFormList.ShowForm(aFormname: string);
var
  i1: Integer;
begin
  for i1 := 0 to fFormHistoryList.Count -1 do
    TForm(fFormHistoryList.Items[i1]).Visible := false;
  for i1 := 0 to fAllForms.Count -1 do
  begin
    if SameText(aFormname, TForm(fAllForms.Items[i1]).Name) then
    begin
      fFormHistoryList.Add(fAllForms.Items[i1]);
      TForm(fAllForms.Items[i1]).Visible := true;
    end;
  end;
end;

procedure TFormList.AddToAllForms(aForm: TForm);
begin
  fAllForms.Add(aForm);
  aForm.Parent := fParentForm;
  aForm.Visible := false;
  aForm.Align := alClient;
end;

procedure TFormList.CloseForm;
begin
  if fFormHistoryList.Count = 0 then
    exit;
  TForm(fFormHistoryList.Items[fFormHistoryList.Count-1]).Visible := false;
  fFormHistoryList.Delete(fFormHistoryList.Count-1);
  if fFormHistoryList.Count = 0 then
    exit;
  TForm(fFormHistoryList.Items[fFormHistoryList.Count-1]).Visible := true;
  Tfrm_base(fFormHistoryList.Items[fFormHistoryList.Count-1]).AktualForm;
end;



end.
