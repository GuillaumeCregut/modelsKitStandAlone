unit UPeriod;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, Forms, Controls,
  Graphics, Dialogs, StdCtrls, Menus;

type
  TPeriodRec= record
    id: Integer;
    name: String;
  end;

  { TFPeriod }

  TFPeriod = class(TForm)
    BAddPeriod: TButton;
    BUpdatePeriod: TButton;
    DSPeriod: TDataSource;
    EPeriodName: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    LBPeriod: TListBox;
    PUMUpdate: TMenuItem;
    PUMIDelete: TMenuItem;
    PopupMenu1: TPopupMenu;
    SQLPeriodList: TSQLQuery;
    procedure BAddPeriodClick(Sender: TObject);
    procedure BUpdatePeriodClick(Sender: TObject);
    procedure EPeriodNameChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LBPeriodDblClick(Sender: TObject);
    procedure PUMIDeleteClick(Sender: TObject);
    procedure PUMUpdateClick(Sender: TObject);
  private
    Listperiod : array of TPeriodRec;
    IndexSelect : Integer;
    procedure LoadTable();
  public
     AccessDatabase : String;
  end;

var
  FPeriod: TFPeriod;

implementation

uses
  Ppale;
{$R *.lfm}

{ TFPeriod }

procedure TFPeriod.LoadTable();
var
  sql, nameItem :string;
  i,count, id: Integer;
  periodRecord: TPeriodRec;
begin
  IndexSelect:=-1;
  EPeriodName.Text:='';
  SQLPeriodList.Close;
  SQLPeriodList.sql.Clear;
  LBPeriod.Items.Clear;
  SQLPeriodList.SQL.Text:='SELECT count(*) as nbr FROM period' ;
  SQLPeriodList.Open;
  count:=DSPeriod.DataSet.FieldByName('nbr').value;
  SQLPeriodList.Close;
  SQLPeriodList.sql.Clear;
  sql:='SELECT id,name from period';
  SQLPeriodList.SQL.Add(sql);
  SQLPeriodList.Open;
  //count:=DSPeriod.DataSet.RecordCount;
  SetLength(Listperiod,count);
  for i:=0 to count-1 do
  begin
    nameItem:=DSPeriod.DataSet.FieldByName('name').value;
    id:=DSPeriod.DataSet.FieldByName('id').Value;
    periodRecord.id:=id;
    periodRecord.name:=nameItem;
    Listperiod[i]:=periodRecord;
    LBPeriod.Items.add(nameItem);
    DSPeriod.DataSet.Next;
  end;
  SQLPeriodList.Close;
  SQLPeriodList.sql.Clear;
end;

procedure TFPeriod.FormShow(Sender: TObject);

begin
  EPeriodName.Text:='';
  BUpdatePeriod.Enabled:=false;
  BAddPeriod.Enabled:=false;
  LoadTable();
end;

procedure TFPeriod.EPeriodNameChange(Sender: TObject);
begin
  if((IndexSelect>=0) and (EPeriodName.Text<>'')) then
  begin
    BUpdatePeriod.Enabled:=true;
  end
  else
  begin
    BUpdatePeriod.Enabled:=false;
  end;
  if(EPeriodName.Text<>'') then
  begin
    BAddPeriod.Enabled:=true;
  end
  else
  begin
    BAddPeriod.Enabled:=false;
  end;
end;

procedure TFPeriod.BAddPeriodClick(Sender: TObject);
begin
  if(EPeriodName.text<>'') then
  begin
    SQLPeriodList.SQL.Text:='INSERT INTO period (name) VALUES(:name)';
    SQLPeriodList.Prepare;
    SQLPeriodList.ParamByName('name').AsString:=EPeriodName.text;
    SQLPeriodList.ExecSQL;
    FPpale.SQLTansac.Commit;
    LoadTable();
  end;
end;

procedure TFPeriod.BUpdatePeriodClick(Sender: TObject);
var
  periodRecord: TPeriodRec;
begin
  periodRecord:=Listperiod[IndexSelect];
   if(MessageDlg('Modificaion','Voulez-vous modifier '+ periodRecord.name+' par : '+EPeriodName.Text+' ?',mtWarning,[mboK,mbCancel],0,mbCancel)=mrOK)then
   begin
      SQLPeriodList.SQL.Text:='UPDATE period SET name=:name WHERE id='+IntToStr(periodRecord.id);
      SQLPeriodList.Prepare;
      SQLPeriodList.ParamByName('name').AsString:=EPeriodName.text;
      SQLPeriodList.ExecSQL;
      FPpale.SQLTansac.Commit;
      LoadTable();
   end;
end;

procedure TFPeriod.LBPeriodDblClick(Sender: TObject);
var
  periodRecord: TPeriodRec;
begin
  IndexSelect:=LBPeriod.ItemIndex;
  periodRecord:=Listperiod[IndexSelect];
  EPeriodName.Text:=periodRecord.name;
end;

procedure TFPeriod.PUMIDeleteClick(Sender: TObject);
var
  periodRecord: TPeriodRec;
begin
  if(LBPeriod.ItemIndex>-1)then
  begin
    IndexSelect:=LBPeriod.ItemIndex;
    periodRecord:=Listperiod[IndexSelect];
    if(MessageDlg('Suppression','Voulez-vous supprimer '+ periodRecord.name+' ?',mtWarning,[mboK,mbCancel],0,mbCancel)=mrOK)then
    begin
      SQLPeriodList.SQL.Text:='DELETE FROM period WHERE id='+IntToStr(periodRecord.id);
      SQLPeriodList.ExecSQL;
      FPpale.SQLTansac.Commit;
      LoadTable();
    end;
  end;
end;

procedure TFPeriod.PUMUpdateClick(Sender: TObject);
var
  periodRecord: TPeriodRec;
begin
   if(LBPeriod.ItemIndex>-1)then
  begin
    IndexSelect:=LBPeriod.ItemIndex;
    periodRecord:=Listperiod[IndexSelect];
    EPeriodName.Text:=periodRecord.name;
  end;
end;

end.

