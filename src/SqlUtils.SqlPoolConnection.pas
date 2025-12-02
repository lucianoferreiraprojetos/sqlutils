unit SqlUtils.SqlPoolConnection;

interface

uses
  System.Classes, System.Generics.Collections, SqlUtils.SqlCntParams,
  SqlUtils.SqlConnection;

type

  TItemSqlConnection = class
  strict private
    FSqlConnection: TSqlConnection;
    FThreadCurrent: TThread;
    FLastUse: TDateTime;
  public
    property SqlConnection: TSqlConnection read FSqlConnection write FSqlConnection;
    property ThreadCurrent: TThread read FThreadCurrent write FThreadCurrent;
    property LastUse: TDateTime read FLastUse write FLastUse;
  end;

  TSqlPoolConnection = class
  private
    FSqlCntParams: TSqlCntParams;
    FThreadListConnections: TThreadList<TItemSqlConnection>;
    FMinConnections: Integer;
    FMaxConnections: Integer;
    function CreateNewItemSqlConnection(AThreadCurrent: TThread): TItemSqlConnection;
    function CreateNewSqlConnection(): TSqlConnection;
    procedure CreateMinConnections();
    procedure ReleaseConnections(AList: TList<TItemSqlConnection>); overload;
    function GetCurrentSqlConnection(AList: TList<TItemSqlConnection>): TSqlConnection;
    function TryGetSqlConnection: TSqlConnection;
  public
    constructor Create(ASqlCntParams: TSqlCntParams;
      AMinConnections, AMaxConnections: Integer);
    destructor Destroy; override;
  public
    function GetSqlConnection: TSqlConnection;
    procedure ReleaseConennections(); overload;
  end;

implementation

uses
  System.SysUtils, System.DateUtils;

{ TSqlPoolConnection }

constructor TSqlPoolConnection.Create(ASqlCntParams: TSqlCntParams;
  AMinConnections, AMaxConnections: Integer);
begin
  FSqlCntParams := ASqlCntParams;
  FMinConnections := AMinConnections;
  FMaxConnections := AMaxConnections;
  FThreadListConnections := TThreadList<TItemSqlConnection>.Create;
  CreateMinConnections();
end;

procedure TSqlPoolConnection.CreateMinConnections;
begin
  var List := FThreadListConnections.LockList;
  try
    for var I := 1 to FMinConnections do
      List.Add(CreateNewItemSqlConnection(nil));
  finally
    FThreadListConnections.UnlockList;
  end;
end;

function TSqlPoolConnection.CreateNewItemSqlConnection(
  AThreadCurrent: TThread): TItemSqlConnection;
begin
  Result := TItemSqlConnection.Create;
  Result.SqlConnection := CreateNewSqlConnection();
  Result.ThreadCurrent := AThreadCurrent;
  Result.LastUse := Now();
end;

function TSqlPoolConnection.CreateNewSqlConnection: TSqlConnection;
begin
  Result := TSqlConnection.Create(FSqlCntParams);
end;

destructor TSqlPoolConnection.Destroy;
begin
  FThreadListConnections.Free;
  inherited;
end;

function TSqlPoolConnection.GetCurrentSqlConnection(
  AList: TList<TItemSqlConnection>): TSqlConnection;
begin
  Result := nil;
  for var Item in AList do
  begin
    if Item.ThreadCurrent = TThread.Current then
    begin
      Item.LastUse := Now();
      Exit(Item.SqlConnection);
    end;
  end;
end;

function TSqlPoolConnection.GetSqlConnection: TSqlConnection;
begin
  Result := nil;
  for var I := 1 to 3 do
  begin
    Result := TryGetSqlConnection();
    if Result <> nil then
      Break
    else
      Sleep(1000);
  end;
end;

procedure TSqlPoolConnection.ReleaseConennections;
var
  Item: TItemSqlConnection;
begin
  var List := FThreadListConnections.LockList;
  try
    ReleaseConnections(List);
  finally
    FThreadListConnections.UnlockList;
  end;
end;

procedure TSqlPoolConnection.ReleaseConnections(
  AList: TList<TItemSqlConnection>);
var
  TimeOutConnection: Boolean;
begin
  for var Item in AList do
  begin
    TimeOutConnection := ((SecondsBetween(Item.LastUse,Now()) > 60) and (Item.ThreadCurrent <> nil));
    if (TimeOutConnection) or ((Item.ThreadCurrent <> nil) and (not Assigned(Item.ThreadCurrent)))  then
    begin
      if AList.Count > FMinConnections then
        AList.Remove(Item)
      else
        Item.ThreadCurrent := nil;
   end;
  end;
end;

function TSqlPoolConnection.TryGetSqlConnection: TSqlConnection;
var
  Item: TItemSqlConnection;
begin
  Result := nil;
  var List := FThreadListConnections.LockList;
  try
    ReleaseConnections(List);
    Result := GetCurrentSqlConnection(List);
    if (Result = nil) and (List.Count < FMaxConnections) then
    begin
      Item := CreateNewItemSqlConnection(TThread.Current);
      List.Add(Item);
      Result := Item.SqlConnection;
    end;
  finally
    FThreadListConnections.UnlockList;
  end;
end;

end.
