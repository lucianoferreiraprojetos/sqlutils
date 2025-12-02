unit SqlPoolConnectionInstance;

interface

uses
  SqlUtils.SqlPoolConnection, SqlUtils.SqlCntParams;

var
  SqlPoolCntInstance: TSqlPoolConnection;

implementation

initialization
  var Params: TSqlCntParams;
  Params.Host := 'localhost';
  Params.Port := 3056;
  Params.Schema := TSqlCntParamSchema.SqlCntParamSchemaFirebird;
  Params.User := 'SYSDBA';
  Params.Pass := 'masterkey';
  Params.DbName := '/var/lib/firebird/data/MCNDFEAPI_BANCO_TEST.FDB';
  SqlPoolCntInstance := TSqlPoolConnection.Create(Params,3,10);

finalization
  SqlPoolCntInstance.Free;


end.
