unit Ppale;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, SQLite3Conn, SQLDB, Forms,
  Controls, Graphics, Dialogs, DBGrids, DBCtrls, ComCtrls,
  Menus, UPeriod, UBuilder,UBrand,UCategory,uModels,UScale,uCountries;

type

  { TFPpale }

  TFPpale = class(TForm)
    MainMenu1: TMainMenu;
    MIMyKits: TMenuItem;
    MIModels: TMenuItem;
    MIBrand: TMenuItem;
    MICategories: TMenuItem;
    MIScale: TMenuItem;
    MICountries: TMenuItem;
    MIPeriod: TMenuItem;
    MIBuilder: TMenuItem;
    MIParams: TMenuItem;
    SQLite3Connection1: TSQLite3Connection;
    queryList: TSQLQuery;
    SQLTansac: TSQLTransaction;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure MIBuilderClick(Sender: TObject);
    procedure MIBrandClick(Sender: TObject);
    procedure MICategoriesClick(Sender: TObject);
    procedure MICountriesClick(Sender: TObject);
    procedure MIModelsClick(Sender: TObject);
    procedure MIPeriodClick(Sender: TObject);
    procedure MIScaleClick(Sender: TObject);
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

procedure TFPpale.MIBuilderClick(Sender: TObject);
begin
  FBuilder.ShowModal;
end;

procedure TFPpale.MIBrandClick(Sender: TObject);
begin
  FBrand.ShowModal;
end;

procedure TFPpale.MICategoriesClick(Sender: TObject);
begin
  FCategories.ShowModal;
end;

procedure TFPpale.MICountriesClick(Sender: TObject);
begin
  FCountries.ShowModal;
end;

procedure TFPpale.MIModelsClick(Sender: TObject);
begin
  FModels.ShowModal;
end;

procedure TFPpale.MIPeriodClick(Sender: TObject);
begin
  FPeriod.ShowModal;
end;

procedure TFPpale.MIScaleClick(Sender: TObject);
begin
  FScales.ShowModal;
end;





end.

