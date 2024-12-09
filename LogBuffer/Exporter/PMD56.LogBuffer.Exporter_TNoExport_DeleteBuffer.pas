unit PMD56.LogBuffer.Exporter_TNoExport_DeleteBuffer;

interface
uses
  PMD56.ILogBufferExporter
, PMD56.ILog
,  Generics.Collections
,  System.Classes, System.Generics.Collections

;

type
  TNoExport_DeleteBuffer = class(TInterfacedObject, ILogBufferExporter)
  private

  protected
    procedure DoExport( aLogList : TThreadList<ILog> );

  public

  end;

implementation

{ TNoExport_DeleteBuffer }

procedure TNoExport_DeleteBuffer.DoExport(aLogList: TThreadList<ILog>);
begin
  aLogList.Free;
end;

end.
