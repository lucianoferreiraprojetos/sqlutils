unit SqlUtils.SqlQuery;

interface

uses
  Data.DB, SqlUtils.SqlConnection, System.Generics.Collections,
  SqlUtils.SqlBuilder, SqlUtils.SqlResultSet, SqlUtils.SqlQueryBuilder,
  SqlUtils.SqlCriteriaQuery;

type

  ISqlResultSet = SqlUtils.SqlResultSet.ISqlResultSet;
  TSqlResultSet = SqlUtils.SqlResultSet.TSqlResultSet;

  ISqlBuilder = SqlUtils.SqlBuilder.ISqlBuilder;
  TSqlBuilder = SqlUtils.SqlBuilder.TSqlBuilder;

  ISqlQueryBuilder = SqlUtils.SqlQueryBuilder.ISqlQueryBuilder;


  ISqlQuery = interface
    ['{E5F6C7A8-D008-4C64-96F4-4D5C07F2516B}']
    function AddSql(ASql: String): ISqlBuilder;
    procedure ExecSql(ASql: String);
    function From(ATableName: String; ATableAlias: String = ''): ISqlQueryBuilder; overload;
    function From(ASqlCriteriaQuery: ISqlCriteriaQuery): ISqlCriteriaQuery; overload;
    function GetResultSet: ISqlResultSet;
  end;

  TSqlQuery = class(TInterfacedObject,ISqlQuery)
  private
    FSqlConnection: TSqlConnection;
    constructor Create(ASqlConnection: TSqlConnection);
  public
    function AddSql(ASql: String): ISqlBuilder;
    procedure ExecSql(ASql: String);
    function From(ATableName: String; ATableAlias: String = ''): ISqlQueryBuilder; overload;
    function From(ASqlCriteriaQuery: ISqlCriteriaQuery): ISqlCriteriaQuery; overload;
    function GetResultSet: ISqlResultSet;
  public
    class function New(ASqlConnection: TSqlConnection): ISqlQuery;
  end;

implementation

{ TSqlQuery }

function TSqlQuery.AddSql(ASql: String): ISqlBuilder;
begin
  Result := TSqlBuilder.New(FSqlConnection).AddSql(ASql);
end;

function TSqlQuery.From(ATableName, ATableAlias: String): ISqlQueryBuilder;
begin

end;

constructor TSqlQuery.Create(ASqlConnection: TSqlConnection);
begin
  FSqlConnection := ASqlConnection;
end;

procedure TSqlQuery.ExecSql(ASql: String);
begin
//
end;

function TSqlQuery.From(
  ASqlCriteriaQuery: ISqlCriteriaQuery): ISqlCriteriaQuery;
begin
//
end;

function TSqlQuery.GetResultSet: ISqlResultSet;
begin

end;

class function TSqlQuery.New(ASqlConnection: TSqlConnection): ISqlQuery;
begin
  Result := Self.Create(ASqlConnection);
end;

end.
