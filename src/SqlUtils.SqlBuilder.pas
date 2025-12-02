unit SqlUtils.SqlBuilder;

interface

uses
  System.Classes, System.Generics.Collections, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.ConsoleUI.Wait,
  SqlUtils.SqlResultSet, SqlUtils.SqlConnection;

type

  ISqlBuilder = interface
    ['{00E8B28B-313D-4D58-8E9C-A61F1FBBD23C}']
    function AddSql(ASql: String): ISqlBuilder;
    function SetParam(AParamName: String; AParamValue: Variant): ISqlBuilder;
    function GetResultSet: ISqlResultSet;
    procedure Exec;
  end;

  TSqlBuilder = class(TInterfacedObject,ISqlBuilder)
  private
    FSqlConnection: TSqlConnection;
    FSlSql: TStringList;
    FFDQuery: TFDQuery;
    FMapParams: TDictionary<String,Variant>;
    procedure PrepareQueryOrSqlExec();
    function CreateFDQuery: TFDQuery;
    constructor Create(ASqlConnection: TSqlConnection);
    destructor Destroy; override;
  public
    function AddSql(ASql: String): ISqlBuilder;
    function SetParam(AParamName: String; AParamValue: Variant): ISqlBuilder;
    function GetResultSet: ISqlResultSet;
    procedure Exec;
  public
    class function New(ASqlConnection: TSqlConnection): ISqlBuilder;
  end;

  ISqlBuilder<T: class> = interface
    ['{00E8B28B-313D-4D58-8E9C-A61F1FBBD23C}']
    function AddSql(ASql: String): ISqlBuilder<T>;
    function SetParam(AParamName: String; AParamValue: Variant): ISqlBuilder<T>;
    function GetResultSet: ISqlResultSet<T>;
    function GetObject: T;
    function GetFirstObject: T;
    function GetList: TObjectList<T>;
  end;

  TSqlBuilder<T: class> = class(TInterfacedObject,ISqlBuilder<T>)
  private
    FSqlBuilderWrapper: ISqlBuilder;
    constructor Create(ASqlConnection: TSqlConnection);
  public
    function AddSql(ASql: String): ISqlBuilder<T>;
    function SetParam(AParamName: String; AParamValue: Variant): ISqlBuilder<T>;
    function GetResultSet: ISqlResultSet<T>;
    function GetObject: T;
    function GetFirstObject: T;
    function GetList: TObjectList<T>;
  public
    class function New(ASqlConnection: TSqlConnection): ISqlBuilder<T>;
  end;


implementation

uses
  System.SysUtils;

{ TSqlBuilder }

function TSqlBuilder.AddSql(ASql: String): ISqlBuilder;
begin
  Result := Self;
  FSlSql.Add(ASql);
end;

constructor TSqlBuilder.Create(ASqlConnection: TSqlConnection);
begin
  FSqlConnection := ASqlConnection;
  FSlSql := TStringList.Create;
  FMapParams := TDictionary<String,Variant>.Create;
  FFDQuery := CreateFDQuery();
end;

function TSqlBuilder.CreateFDQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FSqlConnection.GetFDConnection;
end;

destructor TSqlBuilder.Destroy;
begin
  FreeAndNil(FSlSql);
  FreeAndNil(FMapParams);
  inherited;
end;

procedure TSqlBuilder.Exec;
begin
  PrepareQueryOrSqlExec();
  FFDQuery.ExecSQL;
end;

function TSqlBuilder.GetResultSet: ISqlResultSet;
begin
  PrepareQueryOrSqlExec();
  FFDQuery.Open();
  Result := TSqlResultSet.New(FFDQuery);
end;

class function TSqlBuilder.New(ASqlConnection: TSqlConnection): ISqlBuilder;
begin
  Result := Self.Create(ASqlConnection);
end;

procedure TSqlBuilder.PrepareQueryOrSqlExec;
begin
  FFDQuery.SQL.Text := FSlSql.Text;
  for var Param in FMapParams do
    FFDQuery.ParamByName(Param.Key).Value := Param.Value;
end;

function TSqlBuilder.SetParam(AParamName: String;
  AParamValue: Variant): ISqlBuilder;
begin
  Result := Self;
  FMapParams.Add(AParamName,AParamValue);
end;

{ TSqlBuilder<T> }

function TSqlBuilder<T>.AddSql(ASql: String): ISqlBuilder<T>;
begin
  Result := Self;
  FSqlBuilderWrapper.AddSql(ASql);
end;

constructor TSqlBuilder<T>.Create(ASqlConnection: TSqlConnection);
begin
  FSqlBuilderWrapper := TSqlBuilder.New(ASqlConnection);
end;

function TSqlBuilder<T>.GetFirstObject: T;
begin
  Result := FSqlBuilderWrapper.GetResultSet.GetFirstObject(T) as T;
end;

function TSqlBuilder<T>.GetList: TObjectList<T>;
begin
  Result := TSqlResultSet<T>.New(FSqlBuilderWrapper.GetResultSet).GetList();
end;

function TSqlBuilder<T>.GetObject: T;
begin
  Result := FSqlBuilderWrapper.GetResultSet.GetObject(T) as T;
end;

function TSqlBuilder<T>.GetResultSet: ISqlResultSet<T>;
begin
  Result := TSqlResultSet<T>.New(FSqlBuilderWrapper.GetResultSet);
end;

class function TSqlBuilder<T>.New(
  ASqlConnection: TSqlConnection): ISqlBuilder<T>;
begin
  Result := Self.Create(ASqlConnection);
end;

function TSqlBuilder<T>.SetParam(AParamName: String;
  AParamValue: Variant): ISqlBuilder<T>;
begin
  Result := Self;
  FSqlBuilderWrapper.SetParam(AParamName,AParamValue);
end;

end.
