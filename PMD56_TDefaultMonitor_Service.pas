unit PMD56_TDefaultMonitor_Service;

interface
uses
  PMD56_IMonitor,
  PMD56.ILogBuffer,
  PMD56.ILogFactory,
  PMD56.ILog,
  PMD56.ILogBufferExporter
;

type
  IMonitor = PMD56_IMonitor.IMonitor;
  ILogBuffer = PMD56.ILogBuffer.ILogBuffer;
//  TOnLogCreated = PMD56.ILogFactory.TOnLogCreated;
  ILogFactory = PMD56.ILogFactory.ILogFactory;
  ILog = PMD56.ILog.ILog;

  TDefaultMonitorService = class
    class function Create_IMonitor(const aILogger : ILogBuffer_WithExporter;
      const aILogFactory_WithSetup : ILogFactory_WithSetup) : IMonitor;
    class function Create_ILogBuffer(aILogBufferExporter : ILogBufferExporter) : ILogBuffer_WithExporter;
    class function Create_ILogFactory_WithSetup() : ILogFactory_WithSetup;
    class function Create_ILogBufferExporter_TNoExport_DeleteBuffer : ILogBufferExporter;
  end;

implementation
uses
  PMD56_TMonitor,
  PMD56.TLogBuffer,
  PMD56.TLogFactory,
  PMD56.LogBuffer.Exporter_TNoExport_DeleteBuffer
;

{ TDefaultMonitorService }

class function TDefaultMonitorService.Create_ILogBufferExporter_TNoExport_DeleteBuffer: ILogBufferExporter;
begin
  result := TNoExport_DeleteBuffer.Create;
end;

class function TDefaultMonitorService.Create_ILogFactory_WithSetup(): ILogFactory_WithSetup;
begin
  result := TLogFactory.Create();
end;

class function TDefaultMonitorService.Create_ILogBuffer(aILogBufferExporter : ILogBufferExporter): ILogBuffer_WithExporter;
begin
  result := TLogBuffer.Create( aILogBufferExporter );
end;

class function TDefaultMonitorService.Create_IMonitor(const aILogger : ILogBuffer_WithExporter;const aILogFactory_WithSetup : ILogFactory_WithSetup): IMonitor;
begin
  result := TMonitor.Create(aILogger, aILogFactory_WithSetup);
end;

end.
