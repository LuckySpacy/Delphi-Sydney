{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit Form.Zutaten;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  Form.Zutat, Rest.Rezept, FMX.Controls.Presentation, FMX.StdCtrls,
  Rest.ZutatenlistennameList, Rest.RezeptZutatenList, FMX.Edit, FMX.EditBox,
  FMX.SpinBox, FMX.Layouts;

type
  Tfrm_Zutaten = class(TForm)
    tbc_Zutaten: TTabControl;
    tbs_Zutat: TTabItem;
    Layout1: TLayout;
    edt_Basismenge: TSpinBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edt_BasismengeChange(Sender: TObject);
  private
    fFormZutatenList: TList;
    fFormZutat: Tfrm_Zutat;
    fRestRezept: TRestRezept;
    fRestZutatenlistennameList: TRestZutatenlistennameList;
    fRezeptZutatenList: TRestRezeptZutatenList;
    procedure CreateTabItem(aText: string; aZlId: Integer);
    procedure ClearAllTabs;
  public
    procedure setRezept(aRezept: TRestRezept);
  end;

var
  frm_Zutaten: Tfrm_Zutaten;

implementation

{$R *.fmx}

uses
  Objekt.RestSchnittstelle;


procedure Tfrm_Zutaten.FormCreate(Sender: TObject);
begin
  fFormZutatenList := TList.Create;
  //fFormZutat := Tfrm_Zutat.Create(Self);
  //CreateTabItem('Test 1');
  //CreateTabItem('Test 2');
//  tbc_Zutaten.a
  //while fFormZutat.ChildrenCount>0 do
  //  fFormZutat.Children[0].Parent := tbs_Zutat;
  //fFormZutatenList.Add(fFormZutat);

  fRestZutatenlistennameList := TRestZutatenlistennameList.Create;
  fRezeptZutatenList := TRestRezeptZutatenList.Create;


//  tbc_Zutaten.TabCount
end;

procedure Tfrm_Zutaten.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fFormZutatenList);
  FreeAndNil(fRestZutatenlistennameList);
  FreeAndNil(fRezeptZutatenList);
end;

procedure Tfrm_Zutaten.ClearAllTabs;
var
  i1: Integer;
  FormZutat: Tfrm_Zutat;
begin
  for i1 := tbc_Zutaten.TabCount downto 0 do
    FreeAndNil(tbc_Zutaten.Tabs[i1]);
  for i1 := fFormZutatenList.Count -1 downto 0 do
  begin
    FormZutat := Tfrm_Zutat(fFormZutatenList.Items[i1]);
    FreeAndNil(FormZutat);
  end;
  fFormZutatenList.Clear;
end;

procedure Tfrm_Zutaten.CreateTabItem(aText: string; aZlId: Integer);
var
  TabItem: TTabItem;
  i1: Integer;
begin
  TabItem := TTabItem.Create(tbc_Zutaten);
  TabItem.Parent := tbc_Zutaten;
  TabItem.Text := aText;
  fFormZutat := Tfrm_Zutat.Create(Self);
  while fFormZutat.ChildrenCount>0 do
    fFormZutat.Children[0].Parent := TabItem;
  fFormZutatenList.Add(fFormZutat);

  RestSchnittstelle.HoleZutatenlist(fRezeptZutatenList, fRestRezept.FieldByName('Id').AsInteger, aZlId);
  fFormZutat.setRezept(fRestRezept, aZlId);

end;



procedure Tfrm_Zutaten.setRezept(aRezept: TRestRezept);
var
  i1: Integer;
begin
  fRestRezept := aRezept;
  edt_Basismenge.Value := fRestRezept.FieldByName('Basismenge').AsInteger;
  //fFormZutat.setRezept(aRezept);
  ClearAllTabs;
  RestSchnittstelle.HoleZutatenlistenname(fRestZutatenlistennameList, aRezept.FieldByName('Id').AsInteger);
  for i1 := 0 to fRestZutatenlistennameList.Count -1 do
    CreateTabItem(fRestZutatenlistennameList.Item[i1].FieldByName('Listenname').AsString, fRestZutatenlistennameList.Item[i1].FieldByName('ZL_ID').AsInteger);
  if fRestZutatenlistennameList.Count <= 1 then
    tbc_Zutaten.TabPosition := TTabPosition.None;
end;

procedure Tfrm_Zutaten.edt_BasismengeChange(Sender: TObject);
var
  i1: Integer;
begin
  for i1 := 0 to fFormZutatenList.Count -1 do
  begin
    fFormZutat := Tfrm_Zutat(fFormZutatenList.Items[i1]);
    fFormZutat.AnsichtMenge := edt_Basismenge.Value;
  end;
  //fFormZutat.
end;


end.
