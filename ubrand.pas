unit UBrand;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, DBCtrls, DBGrids;

type
    TBrandRec= record
    id: Integer;
    name: String;
  end;
  { TFBrand }

  TFBrand = class(TForm)
    BAddCountry: TButton;
    BUpdateCountry: TButton;
    DSBrand: TDataSource;
    EBrand: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    LBBrand: TListBox;
    PopupMenu1: TPopupMenu;
    PUMDeleteBrand: TMenuItem;
    PUMUpdateBrand: TMenuItem;
    QueryBrand: TSQLQuery;
    procedure BAddCountryClick(Sender: TObject);
    procedure BUpdateCountryClick(Sender: TObject);
    procedure EBrandChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LBBrandDblClick(Sender: TObject);
    procedure PUMDeleteBrandClick(Sender: TObject);
    procedure PUMUpdateBrandClick(Sender: TObject);
  private
    ListBrands : array of TBrandRec;
    IndexSelect : Integer;
    procedure LoadTable;
  public

  end;

var
  FBrand: TFBrand;

implementation
uses
  Ppale;
{$R *.lfm}

{ TFBrand }


procedure TFBrand.PUMUpdateBrandClick(Sender: TObject);
var
  brandRec : TBrandRec;
begin
  IndexSelect:=LBBrand.ItemIndex;
  brandRec:=ListBrands[IndexSelect];
  EBrand.Text:=brandRec.name;
end;

procedure TFBrand.LoadTable;
var
  brandRec : TBrandRec;
  nameItem : string;
  i,count, id: Integer;
begin
   IndexSelect:=-1;
   QueryBrand.Close;
   QueryBrand.SQL.Clear;
   LBBrand.Items.Clear;
   QueryBrand.SQL.Text:='SELECT COUNT(*) AS nbr FROM brand';
   QueryBrand.Open;
   count:= DSBrand.DataSet.FieldByName('nbr').value;
   QueryBrand.Close;
   QueryBrand.SQL.Clear;
   QueryBrand.SQL.Text:='SELECT id, name from brand ORDER BY name';
   QueryBrand.Open;
   SetLength(ListBrands,count);
   for i:=0 to count-1 do
   begin
     nameItem:=DSBrand.DataSet.FieldByName('name').value;
     id:=DSBrand.DataSet.FieldByName('id').value;
     brandRec.id:=id;
     brandRec.name:=nameItem;
     ListBrands[i]:=brandRec;
     LBBrand.Items.Add(nameItem);
     DSBrand.DataSet.Next;
   end;
   QueryBrand.Close;
   QueryBrand.SQL.Clear;
end;

procedure TFBrand.PUMDeleteBrandClick(Sender: TObject);
var
  brandRec:TBrandRec;
begin
  if(LBBrand.ItemIndex>-1) then
  begin
    IndexSelect:=LBBrand.ItemIndex;
    brandRec:=ListBrands[IndexSelect];
    if(MessageDlg('Suppression','Voulez-vous supprimer '+ brandRec.name+' ?',mtWarning,[mboK,mbCancel],0,mbCancel)=mrOK)then
    begin
      QueryBrand.SQL.Text:='DELETE FROM brand WHERE id='+IntToStr(brandRec.id);
      QueryBrand.ExecSQL;
      FPpale.SQLTansac.Commit;
      LoadTable();
    end;
  end;
end;

procedure TFBrand.EBrandChange(Sender: TObject);
begin
   if(EBrand.Text<>'') then
  begin
    BAddCountry.Enabled:=true;
  end
  else
  begin
    BAddCountry.Enabled:=false;
  end;
  if((EBrand.Text<>'')and (IndexSelect>=0)) then
  begin
    BUpdateCountry.Enabled:=true;
  end
  else
  begin
    BUpdateCountry.Enabled:=false;
  end;

end;

procedure TFBrand.FormShow(Sender: TObject);
begin
  IndexSelect:=-1;
  EBrand.Text:='';
  BAddCountry.Enabled:=false;
  BUpdateCountry.Enabled:=false;
  LoadTable;
end;

procedure TFBrand.BAddCountryClick(Sender: TObject);
begin
  if(EBrand.Text<>'') then
  begin
     QueryBrand.SQL.Text:='INSERT INTO brand (name) VALUES (:name)';
     QueryBrand.Prepare;
     QueryBrand.ParamByName('name').AsString:=EBrand.Text;
     QueryBrand.ExecSQL;
     FPpale.SQLTansac.Commit;
     EBrand.Text:='';
     LoadTable;
  end;
end;

procedure TFBrand.BUpdateCountryClick(Sender: TObject);
var
  brandRec : TBrandRec;
begin
  if((EBrand.Text<>'')and (IndexSelect>=0)) then
  begin
     brandRec:=ListBrands[IndexSelect];
     if(MessageDlg('Modificaion','Voulez-vous modifier '+ brandRec.name+' par : '+EBrand.Text+' ?',mtWarning,[mboK,mbCancel],0,mbCancel)=mrOK)then
     begin
       QueryBrand.SQL.Text:='UPDATE brand SET name= :name WHERE id='+IntToStr(brandRec.id);
       QueryBrand.Prepare;
       QueryBrand.ParamByName('name').AsString:=EBrand.Text;
       QueryBrand.ExecSQL;
       FPpale.SQLTansac.Commit;
       EBrand.Text:='';
       LoadTable;
     end;
  end;
end;

procedure TFBrand.LBBrandDblClick(Sender: TObject);
var
  brandRec : TBrandRec;
begin
  IndexSelect:=LBBrand.ItemIndex;
  brandRec:=ListBrands[IndexSelect];
  EBrand.Text:=brandRec.name;
end;

end.

