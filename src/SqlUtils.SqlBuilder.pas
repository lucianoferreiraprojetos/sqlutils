unit SqlUtils.SqlBuilder;

interface

uses
  SqlUtils.SqlResultSet;

type

  ISqlBuilder = interface
    ['{00E8B28B-313D-4D58-8E9C-A61F1FBBD23C}']
    function AddSql(ASql: String): ISqlBuilder;
    function GetResultSet: ISqlResultSet;
    procedure Exec;
  end;

implementation

end.
