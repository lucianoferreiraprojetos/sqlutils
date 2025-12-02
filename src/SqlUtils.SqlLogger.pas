unit SqlUtils.SqlLogger;

interface

type

  TSqlLogger = class
  public
    procedure LogError(AMsg: String; ASelfClass: TClass);
  end;

var
  SqlLogger: TSqlLogger;

implementation

{ TSqlLogger }

procedure TSqlLogger.LogError(AMsg: String; ASelfClass: TClass);
begin
  WriteLn(AMsg);
end;

initialization
  SqlLogger := TSqlLogger.Create;

finalization
  SqlLogger.Free;

end.
