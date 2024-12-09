unit PMD56.TLogBuffer;

interface
uses
  PMD56.ILogBuffer,
  PMD56.ILog,
  Generics.Collections
, PMD56.ILogBufferExporter
, System.SyncObjs
  ;

type
  TLogBuffer = class(TInterfacedObject, ILogBuffer, ILogBuffer_WithExporter, ILogBuffer_WithExporter_SetupInfo)
  private
    fLogs : TThreadList<ILog>;
    fILogBufferExporter : ILogBufferExporter;
    fListLock : TCriticalSection;
  protected
    procedure AddLog(aILog : ILog);
    procedure LoopLogs(aTOnLoopList : TOnLoopLogs);
    function Count : integer;
    procedure ExportLogs;
    function Get_ILogBufferExporter : ILogBufferExporter;

  public
    constructor Create( aILogBufferExporter  : ILogBufferExporter);
    destructor Destroy; override;
  end;


implementation

{ TLogger }

procedure TLogBuffer.AddLog(aILog: ILog);
var
  vLockedList : TList<ILog>;
begin
  vLockedList := fLogs.LockList;
  try
    vLockedList.Add( aILog );
  finally
    fLogs.UnlockList;
  end;
end;

function TLogBuffer.Count: integer;
var
  vLockedList : TList<ILog>;
begin
  vLockedList := fLogs.LockList;
  try
    result := vLockedList.Count;
  finally
    fLogs.UnlockList;
  end;
end;

constructor TLogBuffer.Create(aILogBufferExporter  : ILogBufferExporter);
begin
  inherited create;
  fLogs := TThreadList<ILog>.create;
  fILogBufferExporter := aILogBufferExporter;
  fListLock := TCriticalSection.Create;
end;

destructor TLogBuffer.Destroy;
begin
  fLogs.Free;
  fListLock.Free;
  inherited;
end;

procedure TLogBuffer.ExportLogs;
var
  OldList: TThreadList<ILog>;
begin
  // Create a new list and safely replace the shared reference
  fListLock.Enter;
  try
    OldList := fLogs;
    fLogs := TThreadList<ILog>.Create;
  finally
    fListLock.Leave;
  end;
  fILogBufferExporter.DoExport( OldList );
end;

function TLogBuffer.Get_ILogBufferExporter: ILogBufferExporter;
begin
  result := fILogBufferExporter;
end;

procedure TLogBuffer.LoopLogs(aTOnLoopList: TOnLoopLogs);
begin
  if not Assigned(aTOnLoopList) then
    exit;

  var vLog : ILog;
  var vLockedList: TList<ILog>;

  vLockedList := fLogs.LockList;
  try
    for vLog in vLockedList do begin
      aTOnLoopList( vLog );
    end;
  finally
    fLogs.UnlockList;
  end;
end;

end.
