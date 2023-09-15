unit UCategory;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFCategories }

  TFCategories = class(TForm)
    DBCategory: TDataSource;
    LBCategory: TListBox;
    QueryCategory: TSQLQuery;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FCategories: TFCategories;

implementation

{$R *.lfm}

{ TFCategories }

procedure TFCategories.FormShow(Sender: TObject);
var
    sql, nameItem :string;
    i,count: Integer;
begin
    QueryCategory.close;
    QueryCategory.SQL.Clear;
    QueryCategory.SQL.Add('SELECT id, name FROM category ORDER BY name');
    QueryCategory.ExecSQL;
    QueryCategory.Open;
    count:=DBCategory.DataSet.RecordCount;
    for i:=0 to count-1 do
    begin
      nameItem:=DBCategory.DataSet.FieldByName('name').value;
      LBCategory.Items.add(nameItem);
      DBCategory.DataSet.Next;
    end;
  QueryCategory.close;
  QueryCategory.SQL.Clear;
end;

end.

