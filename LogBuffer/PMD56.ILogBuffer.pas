unit PMD56.ILogBuffer;

interface
uses
  PMD56.ILog
, PMD56.ILogBufferExporter
;

type
  TOnLoopLogs = reference to procedure(const aLog : ILog);

  ILogBuffer = interface
    ['{F422420B-3E79-45FC-B07B-1BE7B89274A4}']
    procedure AddLog(aILog : ILog);
    procedure LoopLogs(aTOnLoopList : TOnLoopLogs);
    function Count : integer;
  end;

  ILogBuffer_WithExporter = interface(ILogBuffer)
    ['{D29FC12D-EE9F-4ACD-BB77-4919DE0087F6}']
    procedure ExportLogs;
  end;

  ILogBuffer_WithExporter_SetupInfo = interface(ILogBuffer_WithExporter)
    ['{29BABD94-7C06-4AA0-96CA-9BB6EC555DC8}']
    function Get_ILogBufferExporter : ILogBufferExporter;
    property LogBufferExporter : ILogBufferExporter read Get_ILogBufferExporter;
  end;


implementation

end.
