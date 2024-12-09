unit PMD56.ILog;

interface

type
  TLogType = (ltNormal, ltDebug, ltError);

  ILog = interface
    ['{27EBAAEB-423F-4955-9750-2684742C120E}']
    function Get_LogMessage: String;
    function Get_LogType : TLogType;
    function Get_CreatedDateTime : TDateTime;
    function Get_ThreadID : TThreadID;

    property LogMessage: String read Get_LogMessage;
    property LogType : TLogType read Get_LogType;
    property CreatedDateTime : TDateTime read Get_CreatedDateTime;
    property ThreadID : TThreadID read Get_ThreadID;
  end;

implementation

end.
