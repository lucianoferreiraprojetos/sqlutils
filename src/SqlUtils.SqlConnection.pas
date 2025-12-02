unit SqlUtils.SqlConnection;

interface

uses

  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  SqlUtils.SqlCntParams;

type

  TSqlConnection = class
  private
    FFDConnection: TFDConnection;
    FSqlCntParams: TSqlCntParams;
    function CreateFDConnection(ASqlCntParams: TSqlCntParams): TFDConnection;
    procedure TryConnect();
  public
    constructor Create(ASqlCntParams: TSqlCntParams);
    destructor Destroy; override;
  public
    procedure StartTransaction;
    procedure Commit;
    procedure CommitRetaining;
    procedure Rollback;
    procedure RollbackRetaining;
    procedure ExecSql(const ASql: String);
    function GetFDConnection: TFDConnection;
    function GetSequenceValue(ASequenceName: String): Int64;
    function IsConnected: Boolean;
  end;

implementation

uses
  SqlUtils.SqlLogger;

{ TSqlConnection }

procedure TSqlConnection.Commit;
begin
  FFDConnection.Commit;
end;

procedure TSqlConnection.CommitRetaining;
begin
  FFDConnection.CommitRetaining;
end;

procedure TSqlConnection.TryConnect;
begin
  try
    FFDConnection.Connected := True;
  except on E: Exception do
    begin
      SqlLogger.LogError(E.Message,Self.ClassType);
      raise E;
    end;
  end;
end;

constructor TSqlConnection.Create(ASqlCntParams: TSqlCntParams);
begin
  FSqlCntParams := ASqlCntParams;
  FFDConnection := CreateFDConnection(ASqlCntParams);
  TryConnect();
end;

function TSqlConnection.CreateFDConnection(
  ASqlCntParams: TSqlCntParams): TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  if ASqlCntParams.Schema = SqlCntParamSchemaFirebird then
    Result.DriverName := 'FB'
  else if ASqlCntParams.Schema = SqlCntParamSchemaPostgreSql then
    Result.DriverName := 'PG'
  else if ASqlCntParams.Schema = SqlCntParamSchemaMySql then
    Result.DriverName := 'MySQL'
  else
    raise Exception.Create('Error, no implemented');
  Result.Params.Values['Server'] := ASqlCntParams.Host;
  Result.Params.Values['Port'] := ASqlCntParams.Port.ToString;
  Result.Params.Values['User_Name'] := ASqlCntParams.User;
  Result.Params.Values['Password'] := ASqlCntParams.Pass;
  Result.Params.Values['Database'] := ASqlCntParams.DbName;
end;

destructor TSqlConnection.Destroy;
begin
  FFDConnection.Free;
  inherited;
end;

procedure TSqlConnection.ExecSql(const ASql: String);
begin
  try
    FFDConnection.ExecSQL(ASql);
  except
    on E: Exception do
    begin
      SqlLogger.LogError(E.Message,Self.ClassType);
      raise E;
    end;
  end;
end;

function TSqlConnection.GetFDConnection: TFDConnection;
begin
  Result := FFDConnection;
end;

function TSqlConnection.GetSequenceValue(ASequenceName: String): Int64;
begin
  if FSqlCntParams.Schema = SqlCntParamSchemaFirebird then
  begin
    Result := GetFDConnection
      .ExecSQLScalar('SELECT NEXT VALUE FOR ' + ASequenceName + ' FROM RDB$DATABASE');
  end
  else
    raise Exception.Create('Error, no implemented');
end;

function TSqlConnection.IsConnected: Boolean;
begin
  Result := FFDConnection.Connected;
end;

procedure TSqlConnection.Rollback;
begin
  FFDConnection.Rollback;
end;

procedure TSqlConnection.RollbackRetaining;
begin
  FFDConnection.RollbackRetaining;
end;

procedure TSqlConnection.StartTransaction;
begin
  FFDConnection.StartTransaction;
end;

end.
