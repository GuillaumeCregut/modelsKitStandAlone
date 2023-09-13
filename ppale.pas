unit Ppale;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, SQLite3DS, SQLite3Conn, SQLDB, Forms,
  Controls, Graphics, Dialogs, DBGrids, DBCtrls, ComCtrls;

type

  { TFPpale }

  TFPpale = class(TForm)
    DataSource1: TDataSource;
    DBComboBox1: TDBComboBox;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    StatusBar1: TStatusBar;
    TSChooseKit: TTabSheet;
    TSStock: TTabSheet;
    TSModel: TTabSheet;
    TSCountry: TTabSheet;
    TSScale: TTabSheet;
    TSCategory: TTabSheet;
    TSBrand: TTabSheet;
    TSBuilder: TTabSheet;
    TSPeriod: TTabSheet;
    TSKit: TTabSheet;
    TSTemp: TTabSheet;
    TSParams: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure SQLite3Connection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  FPpale: TFPpale;

implementation

{$R *.lfm}

{ TFPpale }

procedure TFPpale.SQLite3Connection1AfterConnect(Sender: TObject);
begin

end;

procedure TFPpale.FormCreate(Sender: TObject);
begin
  SQLite3Connection1.DatabaseName:='c:\users\wart\projects\lazarus\modelsKit\modelskit.db';
end;

end.

