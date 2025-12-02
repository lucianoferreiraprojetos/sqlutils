unit SqlUtils.SqlQueryBuilder;

interface

uses
  SqlUtils.SqlResultSet;

type

  ISqlQueryBuilder = interface
    ['{18A0F0BB-EA2E-483F-8CA4-1C52D4C5A26B}']
    function GetResultSet: TSqlResultSet;
  end;

implementation

end.
