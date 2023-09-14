unit UScale;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFScales }

  TFScales = class(TForm)
    DSScale: TDataSource;
    LBScale: TListBox;
    QureyScale: TSQLQuery;
  private

  public

  end;

var
  FScales: TFScales;

implementation

{$R *.lfm}

end.

