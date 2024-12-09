unit PMD56.Tlog;

interface
uses
  PMD56.ILog
;
type
  TLog = class(TinterfacedObject, ILog)
  private
    fLogMessage: String;
    fTLogType : TLogType;
    fCreatedDateTime : TDateTime;
    fTThreadID : TThreadID;
  protected
    function Get_LogMessage: String;
    function Get_LogType : TLogType;
    function Get_CreatedDateTime : TDateTime;
    function Get_ThreadID : TThreadID;
  public
    constructor Create(const aLogMessage : String; const aLogType : TLogType;
      const aCreatedDateTime : TDateTime; const aTThreadID : TThreadID); overload;
    constructor Create(const aLogMessage : String; const aLogType : TLogType); overload;
    destructor Destroy; override;
  end;


implementation
uses
  System.Classes, System.SysUtils;

{ TLog }

constructor TLog.Create(const aLogMessage : String; const aLogType : TLogType;
  const aCreatedDateTime : TDateTime; const aTThreadID : TThreadID);
begin
  inherited Create;
  fLogMessage := aLogMessage;
  fTLogType := aLogType;
  fCreatedDateTime := aCreatedDateTime;
  fTThreadID := aTThreadID;
end;

constructor TLog.Create(const aLogMessage : String; const aLogType : TLogType);
begin
  inherited Create;
  fLogMessage := aLogMessage;
  fTLogType := aLogType;
  fCreatedDateTime := Now;
  fTThreadID := TThread.CurrentThread.ThreadID;
end;

destructor TLog.Destroy;
begin
  inherited;
end;

function TLog.Get_CreatedDateTime: TDateTime;
begin
  result := fCreatedDateTime;
end;

function TLog.Get_LogMessage: String;
begin
  Result := fLogMessage;
end;

function TLog.Get_LogType: TLogType;
begin
  result := fTLogType;
end;

function TLog.Get_ThreadID: TThreadID;
begin
  result := fTThreadID;
end;

end.
