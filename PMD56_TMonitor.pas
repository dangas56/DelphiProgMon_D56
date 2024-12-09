unit PMD56_TMonitor;

interface
uses
  PMD56_IMonitor
, PMD56.ILogBuffer
, PMD56.ILogFactory
, PMD56.ILog
;

type
  TMonitor = class(TInterfacedObject, IMonitor)
  private
    fILogger : ILogBuffer_WithExporter;
    fILogFactory_WithSetup : ILogFactory_WithSetup;
  protected
    function Get_ILogBuffer : ILogBuffer_WithExporter;
    function AddLog : ILogFactory;
  public
    constructor Create(aILogger : ILogBuffer_WithExporter; afILogFactory_WithSetup : ILogFactory_WithSetup);
    destructor Destroy; override;

  end;

implementation

{ TMonitor }

function TMonitor.AddLog: ILogFactory;
begin
  result := fILogFactory_WithSetup;
end;

constructor TMonitor.Create(aILogger: ILogBuffer_WithExporter; afILogFactory_WithSetup : ILogFactory_WithSetup);
begin
  inherited create;
  fILogger := aILogger;
  fILogFactory_WithSetup := afILogFactory_WithSetup;

  fILogFactory_WithSetup.OnLogCreated :=
    procedure(var aLog : ILog)
    begin
      fILogger.AddLog( aLog );
    end;
end;

destructor TMonitor.Destroy;
begin
  fILogFactory_WithSetup.OnLogCreated := nil;
  inherited;
end;

function TMonitor.Get_ILogBuffer: ILogBuffer_WithExporter;
begin
  result := fILogger;
end;

end.
