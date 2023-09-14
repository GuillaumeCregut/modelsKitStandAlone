unit uCountries;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFCountries }

  TFCountries = class(TForm)
    DSCountry: TDataSource;
    LBCountry: TListBox;
    QueryCountry: TSQLQuery;
  private

  public

  end;

var
  FCountries: TFCountries;

implementation

{$R *.lfm}

end.

