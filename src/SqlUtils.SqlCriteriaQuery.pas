unit SqlUtils.SqlCriteriaQuery;

interface

type

  ISqlCriteriaQueryRoot = interface
    ['{C1C4D09D-47BE-4CFE-8C1F-6DA7E84124AC}']
    function CreateJoin(ATableJoinName: String; AFieldNameTarget: String; AFieldNameOrigin: String): ISqlCriteriaQueryRoot;
    function GetName(AFieldName: String): String;
  end;

  ISqlCriteriaQuery = interface
    ['{99754DBC-9879-4161-9C44-8B358A8DA170}']
    function CreateRoot(ATableName: String): ISqlCriteriaQueryRoot;
  end;

implementation

end.
