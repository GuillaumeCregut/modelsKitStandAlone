unit UScale;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus;

type
    TScaleRec= record
    id: Integer;
    name: String;
  end;
  { TFScales }

  TFScales = class(TForm)
    BAddScale: TButton;
    BUpdateScale: TButton;
    DSScale: TDataSource;
    EScale: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    LBScale: TListBox;
    PopupMenu1: TPopupMenu;
    PUMDeleteCountry: TMenuItem;
    PUMUpdateScale: TMenuItem;
    QueryScale: TSQLQuery;
    procedure BAddScaleClick(Sender: TObject);
    procedure BUpdateScaleClick(Sender: TObject);
    procedure EScaleChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LBScaleDblClick(Sender: TObject);
    procedure PUMDeleteCountryClick(Sender: TObject);
    procedure PUMUpdateScaleClick(Sender: TObject);
  private
    ListScales : array of TScaleRec;
    IndexSelect : Integer;
    procedure LoadTable();
  public

  end;

var
  FScales: TFScales;

implementation
uses
  Ppale;
{$R *.lfm}

{ TFScales }


procedure TFScales.LoadTable;
var
  sql, nameItem :string;
  i,count, id: Integer;
  scaleRecord: TScaleRec;
begin
  IndexSelect:=-1;
  EScale.Text:='';
  QueryScale.Close;
  QueryScale.SQL.Clear;
  LBScale.Items.Clear;
  sql:='SELECT id, name from scale ORDER BY name';
  QueryScale.SQL.Text:=sql;
  QueryScale.Open;
  count:=DSScale.DataSet.RecordCount;
  setLength(ListScales,count);
  for i:=0 to count-1 do
  begin
    nameItem:=DSScale.DataSet.FieldByName('name').value;
    id:= DSScale.DataSet.FieldByName('id').value;
    scaleRecord.id:=id;
    scaleRecord.name:=nameItem;
    ListScales[i]:=scaleRecord;
    LBScale.Items.Add(nameItem);
    DSScale.DataSet.Next;
  end;
  QueryScale.Close;
  QueryScale.SQL.Clear;
end;

procedure TFScales.PUMDeleteCountryClick(Sender: TObject);
var
  scaleRec:TScaleRec;
begin
  if(LBScale.ItemIndex>-1) then
  begin
    IndexSelect:=LBScale.ItemIndex;
    scaleRec:=ListScales[IndexSelect];
    if(MessageDlg('Suppression','Voulez-vous supprimer '+ scaleRec.name+' ?',mtWarning,[mboK,mbCancel],0,mbCancel)=mrOK)then
    begin
      QueryScale.SQL.Text:='DELETE FROM scale WHERE id='+IntToStr(scaleRec.id);
      QueryScale.ExecSQL;
      FPpale.SQLTansac.Commit;
      LoadTable();
    end;
  end;
end;

procedure TFScales.LBScaleDblClick(Sender: TObject);
var
  scaleRec : TScaleRec;
begin
  IndexSelect:=LBScale.ItemIndex;
  scaleRec:=ListScales[IndexSelect];
  EScale.Text:=scaleRec.name;
end;

procedure TFScales.BAddScaleClick(Sender: TObject);
begin
  if(EScale.Text<>'') then
  begin
     QueryScale.SQL.Text:='INSERT INTO scale (name) VALUES (:name)';
     QueryScale.Prepare;
     QueryScale.ParamByName('name').AsString:=EScale.Text;
     QueryScale.ExecSQL;
     FPpale.SQLTansac.Commit;
     LoadTable();
  end;
end;

procedure TFScales.BUpdateScaleClick(Sender: TObject);
var
  scaleRec: TScaleRec;
begin
  if((EScale.Text<>'') and (IndexSelect>=0)) then
  begin
    scaleRec:=ListScales[IndexSelect];
    if(MessageDlg('Modificaion','Voulez-vous modifier '+ scaleRec.name+' par : '+EScale.Text+' ?',mtWarning,[mboK,mbCancel],0,mbCancel)=mrOK)then
    begin
      QueryScale.SQL.Text:='UPDATE scale SET name=:name WHERE id='+IntToStr(scaleRec.id);
      QueryScale.Prepare;
      QueryScale.ParamByName('name').AsString:=EScale.Text;
      QueryScale.ExecSQL;
      FPpale.SQLTansac.Commit;
      LoadTable();
    end;
  end;
end;

procedure TFScales.EScaleChange(Sender: TObject);
begin
  if(EScale.Text<>'') then
  begin
    BAddScale.Enabled:=true;
  end
  else
  begin
    BAddScale.Enabled:=false;
  end;
  if((IndexSelect>=0) and (EScale.Text<>'')) then
  begin
    BUpdateScale.Enabled:=true;
  end
  else
  begin
    BUpdateScale.Enabled:=false;
  end;
end;

procedure TFScales.FormShow(Sender: TObject);
begin
   EScale.Text:='';
   IndexSelect:=-1;
  BUpdateScale.Enabled:=false;
  BAddScale.Enabled:=false;
  LoadTable();
end;

procedure TFScales.PUMUpdateScaleClick(Sender: TObject);
var
  scaleRec: TScaleRec;
begin
  IndexSelect:=LBScale.ItemIndex;
  scaleRec:=ListScales[IndexSelect];
  EScale.Text:=scaleRec.name;
end;
end.

