unit UScale;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus;

type

  { TFScales }

  TFScales = class(TForm)
    BAddCountry: TButton;
    BUpdateCountry: TButton;
    DSScale: TDataSource;
    Ecountry: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    LBScale: TListBox;
    PopupMenu1: TPopupMenu;
    PUMDeleteCountry: TMenuItem;
    PUMUpdateCountry: TMenuItem;
    QureyScale: TSQLQuery;
  private

  public

  end;

var
  FScales: TFScales;

implementation

{$R *.lfm}

end.

