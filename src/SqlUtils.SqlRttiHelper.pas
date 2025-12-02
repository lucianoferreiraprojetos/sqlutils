unit SqlUtils.SqlRttiHelper;

interface

uses
  System.Rtti, System.TypInfo;

type

  TRttiPropertyHelper = class Helper for TRttiProperty
  public
    function IsDateTime: Boolean;
    function IsBytes: Boolean;
    function IsBoolean: Boolean;
    function IsString: Boolean;
    function IsLargeInt: Boolean;
    function IsNullableBytes: Boolean;
  end;

implementation

uses
  System.SysUtils, System.StrUtils;

function TRttiPropertyHelper.IsBoolean: Boolean;
begin
  Result := (PropertyType.TypeKind = tkEnumeration) and (PropertyType.Name = 'Boolean');
end;

function TRttiPropertyHelper.IsBytes: Boolean;
begin
  Result := (PropertyType.TypeKind = tkDynArray) and (PropertyType.Name = 'TArray<System.Byte>');
end;

function TRttiPropertyHelper.IsDateTime: Boolean;
begin
  Result := (PropertyType.TypeKind = tkFloat) and (PropertyType.Name = 'TDateTime');
end;

function TRttiPropertyHelper.IsLargeInt: Boolean;
begin
  Result := (PropertyType.TypeKind in [tkInt64]);
end;

function TRttiPropertyHelper.IsNullableBytes: Boolean;
begin
  Result := Self.PropertyType.ToString.StartsWith('Nullable<System.TArray<System.Byte>>');
end;

function TRttiPropertyHelper.IsString: Boolean;
begin
  Result := (PropertyType.TypeKind in [tkString,tkUString,tkChar,tkLString]);
end;


end.
