unit PMD56.TLogFactory;

interface
uses
  PMD56.ILog
, PMD56.ILogFactory
;

type
  TLogFactory = class(TInterfacedObject, ILogFactory, ILogFactory_WithSetup)
  private
    OnLogCreated : TOnLogCreated;
  protected
    function Get_OnLogCreated : TOnLogCreated;
    procedure Set_OnLogCreated(aTOnLogCreated : TOnLogCreated);
  public

    procedure LT_Normal(const aMessage : String);
    procedure LT_Debug(const aMessage : String);
    procedure LT_Error(const aMessage : String);

    constructor Create();
    destructor Destroy; override;

  end;

implementation
uses
  PMD56.Tlog
;

{ TLogFactory }

constructor TLogFactory.Create();
begin
  inherited create();
  OnLogCreated := nil;
end;

destructor TLogFactory.Destroy;
begin
  OnLogCreated := nil;
  inherited;
end;

function TLogFactory.Get_OnLogCreated: TOnLogCreated;
begin
  result := OnLogCreated;
end;

procedure TLogFactory.LT_Debug(const aMessage: String);
var
  vLog : ILog;
begin
  if not assigned(OnLogCreated) then
    exit;

  vLog := TLog.Create(aMessage, ltDebug);
  OnLogCreated( vLog );

end;

procedure TLogFactory.LT_Error(const aMessage: String);
var
  vLog : ILog;
begin
  if not assigned(OnLogCreated) then
    exit;

  vLog := TLog.Create(aMessage, ltError);
  OnLogCreated( vLog );

end;

procedure TLogFactory.LT_Normal(const aMessage: String);
var
  vLog : ILog;
begin
  if not assigned(OnLogCreated) then
    exit;

  vLog := TLog.Create(aMessage, ltNormal);
  OnLogCreated( vLog );
end;

procedure TLogFactory.Set_OnLogCreated(aTOnLogCreated: TOnLogCreated);
begin
  OnLogCreated := aTOnLogCreated;
end;

end.
