unit UT_BasicLogs;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TBasicLog = class
  public
    // Sample Methods
    // Simple single Test
    [Test]
    procedure AddSomeLogs_CheckCount;
    [Test]
    procedure AddSomeLogs_Run_DeleteLogExport_CheckCount;
  end;

implementation
uses
  PMD56_TDefaultMonitor_Service
, sysutils
;

procedure TBasicLog.AddSomeLogs_CheckCount;
const
  LOGT_NORMAL = 'Normal';
  LOGT_DEBUG  = 'Debug';
  LOGT_ERROR  = 'Error';
var
  vIMonitor : IMonitor;
begin
  vIMonitor := TDefaultMonitorService.Create_IMonitor(
    TDefaultMonitorService.Create_ILogBuffer(
      TDefaultMonitorService.Create_ILogBufferExporter_TNoExport_DeleteBuffer),
    TDefaultMonitorService.Create_ILogFactory_WithSetup()

  );

  Assert.AreEqual( 0, vIMonitor.LogBuffer.Count, 'Initial Logger Count' );
  vIMonitor.AddLog.LT_Normal(LOGT_NORMAL);
  Assert.AreEqual( 1, vIMonitor.LogBuffer.Count, 'After Log Count' );
  vIMonitor.AddLog.LT_Debug(LOGT_DEBUG);
  Assert.AreEqual( 2, vIMonitor.LogBuffer.Count, 'After Log Count 2' );
  vIMonitor.AddLog.LT_Error(LOGT_ERROR);
  Assert.AreEqual( 3, vIMonitor.LogBuffer.Count, 'After Log Count 2' );

  var iCount : integer;
  iCount := 1;
  vIMonitor.LogBuffer.LoopLogs(
    procedure(const aLog : ILog)
    begin
      case iCount of
        1 : assert.AreEqual(LOGT_NORMAL, aLog.LogMessage, 'LOGT_NORMAL');
        2 : assert.AreEqual(LOGT_DEBUG, aLog.LogMessage , 'LOGT_DEBUG');
        3 : assert.AreEqual(LOGT_ERROR, aLog.LogMessage , 'LOGT_ERROR');
      else
        Assert.Fail('Unexpected Log Count('+ iCount.tostring +')');
      end;

      inc(iCount);
    end
  );

end;

procedure TBasicLog.AddSomeLogs_Run_DeleteLogExport_CheckCount;
var
  vIMonitor : IMonitor;
begin
  vIMonitor := TDefaultMonitorService.Create_IMonitor(
    TDefaultMonitorService.Create_ILogBuffer(
      TDefaultMonitorService.Create_ILogBufferExporter_TNoExport_DeleteBuffer),
    TDefaultMonitorService.Create_ILogFactory_WithSetup()
  );

  vIMonitor.AddLog.LT_Normal('Test');
  Assert.AreEqual(1, vIMonitor.LogBuffer.Count, 'After Log Count');
  vIMonitor.LogBuffer.ExportLogs;
  Assert.AreEqual(0, vIMonitor.LogBuffer.Count, 'After Log Export');
end;

initialization
  TDUnitX.RegisterTestFixture(TBasicLog);

end.
