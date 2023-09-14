unit UPeriod;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, SQLite3DS, Forms, Controls,
  Graphics, Dialogs, StdCtrls;

type

  { TFPeriod }

  TFPeriod = class(TForm)
    DSPeriod: TDataSource;
    ListBox1: TListBox;
    SQLPeriodList: TSQLQuery;
    procedure FormShow(Sender: TObject);
  private

  public
     AccessDatabase : String;
  end;

var
  FPeriod: TFPeriod;

implementation

{$R *.lfm}

{ TFPeriod }



procedure TFPeriod.FormShow(Sender: TObject);
var
    sql, nameItem :string;
    i,count: Integer;

begin
  SQLPeriodList.Close;
  SQLPeriodList.sql.Clear;
  //Load good query of period
  sql:='SELECT name from period';
  SQLPeriodList.SQL.Add(sql);
  SQLPeriodList.ExecSQL;
  SQLPeriodList.Open;
  count:=DSPeriod.DataSet.RecordCount;
  for i:=0 to count-1 do
  begin
    nameItem:=DSPeriod.DataSet.FieldByName('name').value;
    ListBox1.Items.add(nameItem);
    DSPeriod.DataSet.Next;
  end;
  SQLPeriodList.Close;
  SQLPeriodList.sql.Clear;
end;

end.

