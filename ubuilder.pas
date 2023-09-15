unit UBuilder;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFBuilder }

  TFBuilder = class(TForm)
    DSBuilder: TDataSource;
    LBBuilder: TListBox;
    QueryBuilder: TSQLQuery;
  private

  public

  end;

var
  FBuilder: TFBuilder;

implementation

{$R *.lfm}

end.

