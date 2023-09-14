unit Ppale;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, SQLite3DS, SQLite3Conn, SQLDB, Forms,
  Controls, Graphics, Dialogs, DBGrids, DBCtrls, ComCtrls, StdCtrls, Grids,
  Menus, UPeriod;

type

  { TFPpale }

  TFPpale = class(TForm)
    MainMenu1: TMainMenu;
    MIPeriod: TMenuItem;
    MI2: TMenuItem;
    MIParams: TMenuItem;
    SQLite3Connection1: TSQLite3Connection;
    queryList: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure MIPeriodClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl3Change(Sender: TObject);
    procedure TSTempShow(Sender: TObject);
  private

  public
     dbNameAccess : string;
  end;

var
  FPpale: TFPpale;

implementation

{$R *.lfm}

{ TFPpale }







procedure TFPpale.TSTempShow(Sender: TObject);
begin
  //To be remove
 // MessageDlg('toto','Bonjour',mtConfirmation,[mbOk],0,mbOK);
end;



procedure TFPpale.FormCreate(Sender: TObject);
var
  basePath : string;
begin
  basePath:=ExtractFilePath(Application.exeName);
  dbNameAccess:=basePath+'modelskit.db';
  SQLite3Connection1.DatabaseName:=basePath+'modelskit.db';
end;

procedure TFPpale.MIPeriodClick(Sender: TObject);
begin
  FPeriod.ShowModal;
end;


procedure TFPpale.PageControl1Change(Sender: TObject);
begin
  //queryList.Close;
  //queryList.sql.Clear;
end;

procedure TFPpale.PageControl3Change(Sender: TObject);
begin
  //queryList.Close;
  //queryList.sql.Clear;
end;



end.

