unit PMD56.ILogBufferExporter;

interface
uses
  PMD56.ILog,
  Generics.Collections
,  System.Classes, System.SyncObjs, System.Generics.Collections
;

type

  TLogExportThread = class(TThread)
  private
    FLogList: TThreadList<ILog>;
  protected
    procedure Execute; override;
    procedure ProcessList( var aList : TList<ILog> ); virtual; abstract;
  public
    constructor Create(ALogList: TThreadList<ILog>);
    destructor Destroy; override;
  end;

  ILogBufferExporter = interface
    ['{9394D9B2-80A6-4D27-94FC-BAF6BECCD2F9}']
    procedure DoExport( aLogList : TThreadList<ILog> );
  end;

implementation
uses
  sysutils
;

{ TLogExportThread }

constructor TLogExportThread.Create(ALogList: TThreadList<ILog>);
begin
  inherited Create(True); // Create suspended
  FLogList := ALogList;
  FreeOnTerminate := True; // Free the thread after it terminates
end;

destructor TLogExportThread.Destroy;
begin
  FLogList.Free; // Free the TThreadList<ILog> instance
  inherited;
end;

procedure TLogExportThread.Execute;
var
  LogItems: TList<ILog>;
begin
  try
    // Perform thread operations
    LogItems := FLogList.LockList;
    try
      ProcessList( LogItems );
    finally
      FLogList.UnlockList;
    end;
  except
    on E: Exception do
    begin
      // Handle exceptions
      TThread.Synchronize(nil,
        procedure
        begin
          // Log or handle the exception safely in the main thread if needed
        end);
    end;
  end;
end;

end.
