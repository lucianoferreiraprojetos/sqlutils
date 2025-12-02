unit SqlUtils.SqlRtti;

interface

uses
  System.Rtti, System.TypInfo, Data.DB, SqlUtils.SqlRttiHelper;

type

  TSqlRtti = class
  public
    class function GetObject(AFields: TFields; ATargetClass: TClass): TObject;
  end;

implementation

uses
  System.SysUtils, System.StrUtils;

{ TSqlRtti }

class function TSqlRtti.GetObject(AFields: TFields;
  ATargetClass: TClass): TObject;
var
  rCtx: TRttiContext;
  rTyp: TRttiType;
  rPrp: TRttiProperty;
begin
  Result := TClass(ATargetClass).Create;
  rCtx := TRttiContext.Create;
  try
    rTyp := rCtx.GetType(ATargetClass);
    for var LField in AFields do
    begin
      if LField.IsNull then
        Continue;
      for rPrp in rTyp.GetProperties do
      begin
        var FieldName := StringReplace(LField.FieldName,'_','',[rfReplaceAll]);
        if SameText(rPrp.Name,FieldName) then
        begin
          if rPrp.IsDateTime then
            rPrp.SetValue(Pointer(Result),TValue.From<TDateTime>(LField.AsDateTime))
          else if rPrp.IsBoolean then
            rPrp.SetValue(Pointer(Result),TValue.FromVariant(LField.AsBoolean))
          else if rPrp.IsBytes then
            rPrp.SetValue(Pointer(Result),TValue.From<TBytes>(LField.AsBytes))
          else
            rPrp.SetValue(Pointer(Result),TValue.FromVariant(LField.Value));
        end;
      end;
    end;
  finally
    rCtx.Free;
  end;
end;

end.
