unit SqlUtils.SqlCntParams;

interface

type

  TSqlCntParamSchema = (SqlCntParamSchemaNone,SqlCntParamSchemaFirebird,
    SqlCntParamSchemaPostgreSql, SqlCntParamSchemaMySql);

  TSqlCntParams = class
  private
    FHost: String;
    FPort: Integer;
    FUser: String;
    FPass: String;
    FDbName: String;
    FFbClientPath: String;
    FSchema: TSqlCntParamSchema;
  public
    constructor Create; overload;
    constructor Create(AHost: String; APort: Integer;
      AUser, APass, ADbName: String;
      ASchema: TSqlCntParamSchema); overload;
  public
    property Schema: TSqlCntParamSchema read FSchema write FSchema;
    property Host: String read FHost write FHost;
    property Port: Integer read FPort write FPort;
    property User: String read FUser write FUser;
    property Pass: String read FPass write FPass;
    property DbName: String read FDbName write FDbName;
    property FbClientPath: String read FFbClientPath write FFbClientPath;
  end;

implementation

{ TSqlCntParams }

constructor TSqlCntParams.Create(AHost: String; APort: Integer; AUser, APass,
  ADbName: String; ASchema: TSqlCntParamSchema);
begin
  inherited Create;
  FHost := AHost;
  FPort := APort;
  FUser := AUser;
  FPass := APass;
  FDbName := ADbName;
  FSchema := ASchema;
end;

constructor TSqlCntParams.Create;
begin
  inherited Create;
end;

end.
