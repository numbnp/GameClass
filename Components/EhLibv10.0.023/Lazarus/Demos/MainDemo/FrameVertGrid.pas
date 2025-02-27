unit FrameVertGrid;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, GridsEh,
  DBGridsEh, MemTableDataEh, Db, DataDriverEh,
  MemTableEh, StdCtrls, ExtCtrls, DBCtrls, DBAxisGridsEh, DBVertGridsEh,
  DynVarsEh, ImgList, ComCtrls, ToolWin;

type
  TfrVertGrid = class(TFrame)
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    SQLDataDriverEh1: TSQLDataDriverEh;
    MemTableEh1Category: TStringField;
    MemTableEh1Common_name: TStringField;
    MemTableEh1Graphic: TBlobField;
    MemTableEh1Length: TFloatField;
    MemTableEh1Notes: TMemoField;
    MemTableEh1Species_Name: TStringField;
    MemTableEh1SpeciesId: TAutoIncField;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Panel2: TPanel;
    gridFish: TDBGridEh;
    Splitter1: TSplitter;
    Panel3: TPanel;
    DBVertGridEh1: TDBVertGridEh;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    tbVerGridSorted: TToolButton;
    ToolButton6: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ImageList1: TImageList;
    procedure PaintBox1Paint(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure tbVerGridSortedClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure DBVertGridEh1RowEnter(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure RegroupData;
    procedure UpdateUpDown;
  end;

implementation

uses Unit1;

{$R *.lfm}

{ TfrVertGrid }

constructor TfrVertGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.DoubleBuffered := True;
  MemTableEh1.Open;

  Label1.Font := Form1.FrameTitleFont;
  Label1.Left := Form1.FrameTitlePos.X;
  Label1.Top := Form1.FrameTitlePos.Y;
end;

procedure TfrVertGrid.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrVertGrid.RegroupData;
begin
  DBVertGridEh1.Options := DBVertGridEh1.Options - [dgvhRowMove];
  if ToolButton1.Down then
  begin
    DBVertGridEh1.RowCategories.CategoryGroupingType := cgtFieldRowCategoryNameEh;
    DBVertGridEh1.RowCategories.Active := True;
    DBVertGridEh1.Options := DBVertGridEh1.Options + [dgvhRowMove];
  end else if ToolButton2.Down then
  begin
    DBVertGridEh1.RowCategories.CategoryGroupingType := cgtEmptyNotEmptyValueEh;
    DBVertGridEh1.RowCategories.Active := True;
  end else if ToolButton3.Down then
  begin
    DBVertGridEh1.RowCategories.CategoryGroupingType := cgtFieldDataTypeEh;
    DBVertGridEh1.RowCategories.Active := True;
  end else
    DBVertGridEh1.RowCategories.Active := False;

  if tbVerGridSorted.Down
    then DBVertGridEh1.RowsSortOrder := vgsoByFieldRowCaptionAscEh
    else DBVertGridEh1.RowsSortOrder := vgsoByFieldRowIndexEh;

  UpdateUpDown;
end;

procedure TfrVertGrid.UpdateUpDown;
var
  CatNode: TDBVertGridCategoryTreeNodeEh;
begin
  CatNode := DBVertGridEh1.RowCategories.Node;
  ToolButton5.Enabled := (CatNode <> nil) and (CatNode.RowType = vgctCategoryRowEh);
  ToolButton7.Enabled := (CatNode <> nil) and (CatNode.RowType = vgctCategoryRowEh);
end;

procedure TfrVertGrid.ToolButton1Click(Sender: TObject);
begin
  RegroupData;
end;

procedure TfrVertGrid.ToolButton2Click(Sender: TObject);
begin
  RegroupData;
end;

procedure TfrVertGrid.ToolButton3Click(Sender: TObject);
begin
  RegroupData;
end;

procedure TfrVertGrid.tbVerGridSortedClick(Sender: TObject);
begin
  RegroupData;
end;

procedure TfrVertGrid.ToolButton5Click(Sender: TObject);
var
  CurNode: TDBVertGridCategoryTreeNodeEh;
begin
  if DBVertGridEh1.RowCategories.Active then
  begin
    if DBVertGridEh1.RowCategories.Node.RowType = vgctCategoryRowEh then
    begin
      CurNode := DBVertGridEh1.RowCategories.Node;
      if DBVertGridEh1.RowCategories.Node.Index < DBVertGridEh1.RowCategories.Node.Parent.Count-1 then
        DBVertGridEh1.RowCategories.Node.Index := DBVertGridEh1.RowCategories.Node.Index + 1;
      DBVertGridEh1.RowCategories.Node := CurNode;
    end;
  end;
end;

procedure TfrVertGrid.ToolButton7Click(Sender: TObject);
var
  CurNode: TDBVertGridCategoryTreeNodeEh;
begin
  if DBVertGridEh1.RowCategories.Active then
  begin
    if DBVertGridEh1.RowCategories.Node.RowType = vgctCategoryRowEh then
    begin
      CurNode := DBVertGridEh1.RowCategories.Node;
      if DBVertGridEh1.RowCategories.Node.Index > 0 then
        DBVertGridEh1.RowCategories.Node.Index := DBVertGridEh1.RowCategories.Node.Index - 1;
      DBVertGridEh1.RowCategories.Node := CurNode;
    end;
  end;
end;

procedure TfrVertGrid.DBVertGridEh1RowEnter(Sender: TObject);
begin
  UpdateUpDown;
end;

end.
