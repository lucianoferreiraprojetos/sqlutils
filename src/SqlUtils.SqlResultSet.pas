unit SqlUtils.SqlResultSet;

interface

uses
  Data.Db, System.Generics.Collections, SqlUtils.SqlRtti;

type

  ISqlResultSet = interface
    ['{572D630B-F8F2-48E2-82EE-1EF75EF3B128}']
    function GetDataSet: TDataSet;
  end;

  TSqlResultSet = class(TInterfacedObject,ISqlResultSet)
  private
    FDataSet: TDataSet;
    constructor Create(ADataSet: TDataSet);
  public
    function GetDataSet: TDataSet;
  public
    class function New(ADataSet: TDataSet): ISqlResultSet;
  end;

  ISqlResultSet<T: class> = interface
    ['{BB83CA0E-CE04-4D3E-AD82-061DF8F4DB28}']
    function GetUniqueResult: T;
    function GetResultList: TObjectList<T>;
  end;

  TSqlResultSet<T: class> = class(TInterfacedObject,ISqlResultSet<T>)
  private
  public
    function GetUniqueResult: T;
    function GetResultList: TObjectList<T>;
  public
    class function New(ADataSet: TDataSet): ISqlResultSet<T>; overload;
    class function New(ASqlResultSet: ISqlResultSet): ISqlResultSet<T>; overload;
  end;

implementation

{ TSqlResultSet }

constructor TSqlResultSet.Create(ADataSet: TDataSet);
begin
  FDataSet := ADataSet;
end;

function TSqlResultSet.GetDataSet: TDataSet;
begin
  Result := FDataSet;
end;

class function TSqlResultSet.New(ADataSet: TDataSet): ISqlResultSet;
begin
  Result := Self.Create(ADataSet);
end;

{ TSqlResultSet<T> }

function TSqlResultSet<T>.GetResultList: TObjectList<T>;
begin

end;

function TSqlResultSet<T>.GetUniqueResult: T;
begin

end;

class function TSqlResultSet<T>.New(
  ASqlResultSet: ISqlResultSet): ISqlResultSet<T>;
begin
//
end;

class function TSqlResultSet<T>.New(ADataSet: TDataSet): ISqlResultSet<T>;
begin
//
end;

end.
