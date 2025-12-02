program Project3;

uses
  Vcl.Forms,
  Unit3 in 'Unit3.pas' {Form3},
  SqlUtils.SqlConnection in '..\src\SqlUtils.SqlConnection.pas',
  SqlUtils.SqlCntParams in '..\src\SqlUtils.SqlCntParams.pas',
  SqlUtils.SqlBuilder in '..\src\SqlUtils.SqlBuilder.pas',
  SqlUtils.SqlQueryBuilder in '..\src\SqlUtils.SqlQueryBuilder.pas',
  SqlUtils.SqlInsert in '..\src\SqlUtils.SqlInsert.pas',
  SqlUtils.SqlUpdate in '..\src\SqlUtils.SqlUpdate.pas',
  SqlUtils.SqlDelete in '..\src\SqlUtils.SqlDelete.pas',
  SqlUtils.SqlRtti in '..\src\SqlUtils.SqlRtti.pas',
  SqlUtils.SqlCustomAttributes in '..\src\SqlUtils.SqlCustomAttributes.pas',
  SqlUtils.SqlRttiHelper in '..\src\SqlUtils.SqlRttiHelper.pas',
  SqlUtils.SqlTypes in '..\src\SqlUtils.SqlTypes.pas',
  SqlUtils.SqlConsts in '..\src\SqlUtils.SqlConsts.pas',
  SqlUtils.SqlQuery in '..\src\SqlUtils.SqlQuery.pas',
  SqlUtils.SqlFactory in '..\src\SqlUtils.SqlFactory.pas',
  SqlUtils.SqlResultSet in '..\src\SqlUtils.SqlResultSet.pas',
  SqlUtils.SqlPoolConnection in '..\src\SqlUtils.SqlPoolConnection.pas',
  SqlUtils.SqlLogger in '..\src\SqlUtils.SqlLogger.pas',
  SqlUtils.SqlPoolConnectionHorse in '..\src\SqlUtils.SqlPoolConnectionHorse.pas',
  SqlUtils.SqlCriteriaBuilder in '..\src\SqlUtils.SqlCriteriaBuilder.pas',
  SqlUtils.SqlCriteriaQuery in '..\src\SqlUtils.SqlCriteriaQuery.pas',
  SqlPoolConnectionInstance in 'SqlPoolConnectionInstance.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
