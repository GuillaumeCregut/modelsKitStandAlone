unit uModels;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFModels }

  TFModels = class(TForm)
    DSModel: TDataSource;
    LBModel: TListBox;
    QueryModel: TSQLQuery;
  private

  public

  end;

var
  FModels: TFModels;

implementation

{$R *.lfm}

end.

