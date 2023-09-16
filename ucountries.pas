unit uCountries;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus;

type
  TCountryRec= record
    id: Integer;
    name: String;
  end;

  { TFCountries }

  TFCountries = class(TForm)
    BAddCountry: TButton;
    BUpdateCountry: TButton;
    DSCountry: TDataSource;
    Ecountry: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    LBCountry: TListBox;
    PUMDeleteCountry: TMenuItem;
    PUMUpdateCountry: TMenuItem;
    PopupMenu1: TPopupMenu;
    QueryCountry: TSQLQuery;
    procedure BAddCountryClick(Sender: TObject);
    procedure BUpdateCountryClick(Sender: TObject);
    procedure EcountryChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LBCountryDblClick(Sender: TObject);
    procedure PUMDeleteCountryClick(Sender: TObject);
    procedure PUMUpdateCountryClick(Sender: TObject);
  private
    ListCountries : array of TCountryRec;
    IndexSelect : Integer;
    procedure LoadTable();
  public

  end;

var
  FCountries: TFCountries;

implementation
uses
  Ppale;
{$R *.lfm}

{ TFCountries }

procedure TFCountries.LoadTable();
var
  sql, nameItem :string;
  i,count, id: Integer;
  countryRecord: TCountryRec;
begin
  IndexSelect:=-1;
  Ecountry.Text:='';
  QueryCountry.Close;
  QueryCountry.SQL.Clear;
  LBCountry.Items.Clear;
  QueryCountry.SQL.Text:='SELECT count(*) as nbr FROM country';
  QueryCountry.Open;
  count:=DSCountry.DataSet.FieldByName('nbr').value;
  QueryCountry.Close;
  QueryCountry.SQL.Clear;
  sql:='SELECT id, name from country ORDER BY name';
  QueryCountry.SQL.Text:=sql;
  QueryCountry.Open;
  setLength(ListCountries,count);
  for i:=0 to count-1 do
  begin
    nameItem:=DSCountry.DataSet.FieldByName('name').value;
    id:= DSCountry.DataSet.FieldByName('id').value;
    countryRecord.id:=id;
    countryRecord.name:=nameItem;
    ListCountries[i]:=countryRecord;
    LBCountry.Items.Add(nameItem);
    DSCountry.DataSet.Next;
  end;
  QueryCountry.Close;
  QueryCountry.SQL.Clear;
end;

procedure TFCountries.PUMDeleteCountryClick(Sender: TObject);
var
  countryRec:TCountryRec;
begin
  if(LBCountry.ItemIndex>-1) then
  begin
    IndexSelect:=LBCountry.ItemIndex;
    countryRec:=ListCountries[IndexSelect];
    if(MessageDlg('Suppression','Voulez-vous supprimer '+ countryRec.name+' ?',mtWarning,[mboK,mbCancel],0,mbCancel)=mrOK)then
    begin
      QueryCountry.SQL.Text:='DELETE FROM country WHERE id='+IntToStr(countryRec.id);
      QueryCountry.ExecSQL;
      FPpale.SQLTansac.Commit;
      LoadTable();
    end;
  end;
end;

procedure TFCountries.FormShow(Sender: TObject);
begin
  IndexSelect:=-1;
  Ecountry.Text:='';
  BAddCountry.Enabled:=false;
  BUpdateCountry.Enabled:=false;
  LoadTable();
end;

procedure TFCountries.LBCountryDblClick(Sender: TObject);
var
  countryRec:TCountryRec;
begin
  IndexSelect:=LBCountry.ItemIndex;
  countryRec:=ListCountries[IndexSelect];
  Ecountry.Text:=countryRec.name;
end;

procedure TFCountries.EcountryChange(Sender: TObject);
begin
  if((IndexSelect>=0) and (Ecountry.Text<>'')) then
  begin
    BUpdateCountry.Enabled:=true;
  end
  else
  begin
    BUpdateCountry.Enabled:=false;
  end;
  if(Ecountry.Text<>'') then
  begin
    BAddCountry.Enabled:=true;
  end
  else
  begin
    BAddCountry.Enabled:=false;
  end;
end;

procedure TFCountries.BAddCountryClick(Sender: TObject);
begin
  if(Ecountry.Text<>'') then
  begin
    QueryCountry.SQL.Text:='INSERT INTO country (name) VALUES (:name)';
    QueryCountry.Prepare;
    QueryCountry.ParamByName('name').AsString:=ECountry.text;
    QueryCountry.ExecSQL;
    FPpale.SQLTansac.Commit;
    Ecountry.Text:='';
    LoadTable();
  end;
end;

procedure TFCountries.BUpdateCountryClick(Sender: TObject);
var
  countryRec: TCountryRec;
begin
  countryRec:=ListCountries[IndexSelect];
  if(MessageDlg('Modificaion','Voulez-vous modifier '+ countryRec.name+' par : '+Ecountry.Text+' ?',mtWarning,[mboK,mbCancel],0,mbCancel)=mrOK)then
   begin
      QueryCountry.SQL.Text:='UPDATE country SET name=:name WHERE id='+IntToStr(countryRec.id);
      QueryCountry.Prepare;
      QueryCountry.ParamByName('name').AsString:=Ecountry.text;
      QueryCountry.ExecSQL;
      FPpale.SQLTansac.Commit;
      Ecountry.Text:='';
      LoadTable();
   end;
end;

procedure TFCountries.PUMUpdateCountryClick(Sender: TObject);
var
  countryRec:TCountryRec;
begin
  IndexSelect:=LBCountry.ItemIndex;
  countryRec:=ListCountries[IndexSelect];
  Ecountry.Text:=countryRec.name;
end;

end.

