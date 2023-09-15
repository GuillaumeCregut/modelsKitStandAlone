unit UBrand;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFBrand }

  TFBrand = class(TForm)
    DSBrand: TDataSource;
    LBBrand: TListBox;
    QueryBrand: TSQLQuery;
  private

  public

  end;

var
  FBrand: TFBrand;

implementation

{$R *.lfm}

end.

