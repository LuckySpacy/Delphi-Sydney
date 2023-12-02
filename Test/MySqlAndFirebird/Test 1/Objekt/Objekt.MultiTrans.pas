unit Objekt.MultiTrans;

interface

uses
  SysUtils, Classes, IBX.IBDatabase, Objekt.DBFeldList, Data.db, IBX.IBQuery,
  vcl.Dialogs, Objekt.Allg, FireDAC.Comp.Client;

type
  TMultiQuery = class(TComponent)
  private
    {
    fIBQuery: TIBQuery;
    fFDQuery: TFDQuery;
    fUseFirebird: Boolean;
    fUseMySql: Boolean;
    fIBTransaction: TIBTransaction;
    fFDTransaction: TFDTransaction;
    fSqlText: string;
    procedure setUseFirebird(const Value: Boolean);
    procedure setUseMySql(const Value: Boolean);
    procedure setIBTransaction(const Value: TIBTransaction);
    procedure setFDTransaction(const Value: TFDTransaction);
    procedure setSqlText(const Value: string);
    }
  protected
  public
    {
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property UseMySql: Boolean read fUseMySql write setUseMySql;
    property UseFirebird: Boolean read fUseFirebird write setUseFirebird;
    property IBTransaction: TIBTransaction read fIBTransaction write setIBTransaction;
    property FDTransaction: TFDTransaction read fFDTransaction write setFDTransaction;
    property SqlText: string read fSqlText write setSqlText;
    procedure close;
    }
  end;

implementation

end.
