unit SqlUtils.SqlCntParams;

interface

type

  TSqlCntParamSchema = (SqlCntParamSchemaNone,SqlCntParamSchemaFirebird,
    SqlCntParamSchemaPostgreSql, SqlCntParamSchemaMySql);

  TSqlCntParams = record
  private
    FHost: String;
    FPort: Integer;
    FUser: String;
    FPass: String;
    FDbName: String;
    FSchema: TSqlCntParamSchema;
  public
    property Schema: TSqlCntParamSchema read FSchema write FSchema;
    property Host: String read FHost write FHost;
    property Port: Integer read FPort write FPort;
    property User: String read FUser write FUser;
    property Pass: String read FPass write FPass;
    property DbName: String read FDbName write FDbName;
  end;

implementation

{ TSqlCntParams }

end.
