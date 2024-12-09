unit PMD56.ILogFactory;

interface
uses
  PMD56.ILog
;

type
  TOnLogCreated = reference to procedure(var aLog : ILog);

  ILogFactory = Interface
    ['{9482BD1C-AAF4-4E18-A39B-85A1A5DA6994}']
    procedure LT_Normal(const aMessage : String);
    procedure LT_Debug(const aMessage : String);
    procedure LT_Error(const aMessage : String);
  End;

  ILogFactory_WithSetup = interface(ILogFactory)
    ['{C0CEC4DF-3688-45E2-9B9B-4D93C5C363FE}']
    function Get_OnLogCreated : TOnLogCreated;
    procedure Set_OnLogCreated(aTOnLogCreated : TOnLogCreated);

    property OnLogCreated : TOnLogCreated read Get_OnLogCreated write Set_OnLogCreated;
  end;

implementation

end.
