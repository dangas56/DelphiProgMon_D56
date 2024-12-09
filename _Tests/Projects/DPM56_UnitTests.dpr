program DPM56_UnitTests;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  {$ENDIF }
  DUnitX.TestFramework,
  UT_BasicLogs in '..\UnitTest\UT_BasicLogs.pas',
  PMD56_IMonitor in '..\..\PMD56_IMonitor.pas',
  PMD56.ILogBuffer in '..\..\LogBuffer\PMD56.ILogBuffer.pas',
  PMD56.TLogBuffer in '..\..\LogBuffer\PMD56.TLogBuffer.pas',
  PMD56.ILog in '..\..\Log\PMD56.ILog.pas',
  PMD56.Tlog in '..\..\Log\PMD56.Tlog.pas',
  PMD56.TLogFactory in '..\..\Log\PMD56.TLogFactory.pas',
  PMD56_TMonitor in '..\..\PMD56_TMonitor.pas',
  PMD56.ILogFactory in '..\..\Log\PMD56.ILogFactory.pas',
  PMD56_TDefaultMonitor_Service in '..\..\PMD56_TDefaultMonitor_Service.pas',
  PMD56.ILogBufferExporter in '..\..\LogBuffer\PMD56.ILogBufferExporter.pas',
  PMD56.LogBuffer.Exporter_TNoExport_DeleteBuffer in '..\..\LogBuffer\Exporter\PMD56.LogBuffer.Exporter_TNoExport_DeleteBuffer.pas';

{ keep comment here to protect the following conditional from being removed by the IDE when adding a unit }
{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
  ReportMemoryLeaksOnShutdown := true;
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
