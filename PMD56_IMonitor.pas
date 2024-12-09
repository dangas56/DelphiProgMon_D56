unit PMD56_IMonitor;

interface
uses
  PMD56.ILogBuffer
, PMD56.ILogFactory
;

type
  IMonitor = interface
    ['{E51ED401-C104-44DF-BE03-8A5F6525944C}']
    function Get_ILogBuffer : ILogBuffer_WithExporter;
    property LogBuffer : ILogBuffer_WithExporter read Get_ILogBuffer;
    function AddLog : ILogFactory;
  end;

implementation

end.
