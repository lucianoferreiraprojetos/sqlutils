unit SqlUtils.SqlResultSet;

interface

uses
  Data.Db, System.Generics.Collections, SqlUtils.SqlRtti;

type

  ISqlResultSet = interface
    ['{572D630B-F8F2-48E2-82EE-1EF75EF3B128}']
    function GetDataSet: TDataSet;
    function GetObject(AClassType: TClass): TObject;
    function GetFirstObject(AClassType: TClass): TObject;
  end;

  TSqlResultSet = class(TInterfacedObject,ISqlResultSet)
  private
    FDataSet: TDataSet;
    constructor Create(ADataSet: TDataSet);
  public
    function GetDataSet: TDataSet;
    function GetObject(AClassType: TClass): TObject;
    function GetFirstObject(AClassType: TClass): TObject;
  public
    class function New(ADataSet: TDataSet): ISqlResultSet;
  end;

  ISqlResultSet<T: class> = interface
    ['{BB83CA0E-CE04-4D3E-AD82-061DF8F4DB28}']
    function GetObject: T;
    function GetFirstObject: T;
    function GetList: TObjectList<T>;
  end;

  TSqlResultSet<T: class> = class(TInterfacedObject,ISqlResultSet<T>)
  private
    FDataSet: TDataSet;
    constructor Create(ADataSet: TDataSet); overload;
    constructor Create(ASqlResultSet: ISqlResultSet); overload;
  public
    function GetObject: T;
    function GetFirstObject: T;
    function GetList: TObjectList<T>;
  public
    class function New(ADataSet: TDataSet): ISqlResultSet<T>; overload;
    class function New(ASqlResultSet: ISqlResultSet): ISqlResultSet<T>; overload;
  end;

implementation

uses
  System.SysUtils;

{ TSqlResultSet }

constructor TSqlResultSet.Create(ADataSet: TDataSet);
begin
  FDataSet := ADataSet;
end;

function TSqlResultSet.GetDataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TSqlResultSet.GetFirstObject(AClassType: TClass): TObject;
begin
  var Dts := GetDataSet;
  if Dts.IsEmpty then
    Result := nil
  else
  begin
    Dts.First;
    Result := TSqlRtti.GetObject(Dts.Fields, AClassType);
  end;
end;

function TSqlResultSet.GetObject(AClassType: TClass): TObject;
begin
  var Dts := GetDataSet;
  if Dts.IsEmpty then
    Result := nil
  else if Dts.RecordCount > 1 then
    raise Exception.Create('Error, multiples rows')
  else
    Result := TSqlRtti.GetObject(Dts.Fields, AClassType);
end;

class function TSqlResultSet.New(ADataSet: TDataSet): ISqlResultSet;
begin
  Result := Self.Create(ADataSet);
end;

{ TSqlResultSet<T> }

function TSqlResultSet<T>.GetObject: T;
begin
  Result := TSqlResultSet.New(FDataSet).GetObject(T) as T;
end;

class function TSqlResultSet<T>.New(
  ASqlResultSet: ISqlResultSet): ISqlResultSet<T>;
begin
  Result := Self.Create(ASqlResultSet);
end;

constructor TSqlResultSet<T>.Create(ADataSet: TDataSet);
begin
  FDataSet := ADataSet;
end;

constructor TSqlResultSet<T>.Create(ASqlResultSet: ISqlResultSet);
begin
  FDataSet := ASqlResultSet.GetDataSet;
end;

function TSqlResultSet<T>.GetFirstObject: T;
begin
  FDataSet.First;
  Result := TSqlRtti.GetObject(FDataSet.Fields,T) as T;
end;

function TSqlResultSet<T>.GetList: TObjectList<T>;
begin
  Result := TObjectList<T>.Create;
  FDataSet.First;
  while not FDataSet.Eof do
  begin
    Result.Add(TSqlRtti.GetObject(FDataSet.Fields,T));
    FDataSet.Next;
  end;
end;

class function TSqlResultSet<T>.New(ADataSet: TDataSet): ISqlResultSet<T>;
begin
  Result := Self.Create(ADataSet);
end;

end.
