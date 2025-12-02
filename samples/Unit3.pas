unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, SqlUtils.SqlCntParams, SqlUtils.SqlConnection,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI, SqlPoolConnectionInstance;

type
  TPerfilUsuarioDto = class
  private
    FId: Int64;
    FNome: String;
  public
    property Id: Int64 read FId write FId;
    property Nome: String read FNome write FNome;
  end;

  TForm3 = class(TForm)
    Memo1: TMemo;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses SqlUtils.SqlQuery, SqlUtils.SqlResultSet, SqlUtils.SqlBuilder,
  SqlUtils.SqlPoolConnection;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin

  var Lista := TSqlBuilder<TPerfilUsuarioDto>.New(SqlPoolConnectionInstance.SqlPoolCntInstance.GetSqlConnection)
    .AddSql('SELECT * FROM PERFIL_USUARIO ORDER BY NOME').GetList;

  Memo1.Clear;

  for var Item in Lista do
    Memo1.Lines.Add(Item.Nome);




end;

end.
