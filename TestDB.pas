unit TestDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Vcl.Buttons, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.StdCtrls, Vcl.Grids;

type
  TTestDBForm = class(TForm)
    FDConnection: TFDConnection;
    OpenBtn: TSpeedButton;
    FDTransaction: TFDTransaction;
    FDQuery: TFDQuery;
    ReadBtn: TSpeedButton;
    WriteBtn: TSpeedButton;
    CmdAddLine: TFDCommand;
    StringGrid: TStringGrid;
    SexGroupBox: TGroupBox;
    MaleRadioButton: TRadioButton;
    FemaleRadioButton: TRadioButton;
    SortBtn: TSpeedButton;
    FileEdt: TEdit;
    OpenFileBtn: TSpeedButton;
    OpenDialog: TOpenDialog;
    procedure OpenBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ReadBtnClick(Sender: TObject);
    procedure WriteBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SortBtnClick(Sender: TObject);
    procedure OpenFileBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestDBForm: TTestDBForm;

implementation

{$R *.dfm}

uses RecordAdd;

procedure TTestDBForm.FormCreate(Sender: TObject);
begin
  StringGrid.ColWidths[0] := 32;
  StringGrid.ColWidths[1] := 160;
  StringGrid.ColWidths[2] := 160;
  StringGrid.ColWidths[3] := 160;
  StringGrid.ColWidths[4] := 32;
  StringGrid.Cells[0, 0] := '№';
  StringGrid.Cells[1, 0] := 'Фамилия';
  StringGrid.Cells[2, 0] := 'Имя';
  StringGrid.Cells[3, 0] := 'Отчество';
  StringGrid.Cells[4, 0] := 'Пол';
end;

procedure TTestDBForm.FormDestroy(Sender: TObject);
begin
  if FDTransaction.Active then
    FDTransaction.Commit;
  FDConnection.Close();
end;

procedure TTestDBForm.OpenBtnClick(Sender: TObject);
begin
  try
    FDConnection.Params.Database := FileEdt.Text;
    FDConnection.Connected := True;
    WriteBtn.Enabled := True;
    ReadBtn.Enabled := True;
    SortBtn.Enabled := True;
  except
    ShowMessage('Не удалось подключиться!')
  end;
end;

procedure TTestDBForm.OpenFileBtnClick(Sender: TObject);
begin
  if OpenDialog.Execute() then
    FileEdt.Text := OpenDialog.FileName;
end;

procedure TTestDBForm.ReadBtnClick(Sender: TObject);
var
  i: Integer;
begin
  FDQuery.Open('select * from EMPLOYEES');
  StringGrid.RowCount := FDQuery.RecordCount + 1;

  for i := 1 to FDQuery.RecordCount do
  begin
    FDQuery.RecNo := i;
    StringGrid.Cells[0, i] := FDQuery.Fields[0].AsString;
    StringGrid.Cells[1, i] := FDQuery.Fields[1].AsString;
    StringGrid.Cells[2, i] := FDQuery.Fields[2].AsString;
    StringGrid.Cells[3, i] := FDQuery.Fields[3].AsString;
    StringGrid.Cells[4, i] := FDQuery.Fields[4].AsString;
  end;
end;

procedure TTestDBForm.SortBtnClick(Sender: TObject);
// Выборка записей по полу с сортировкой
// через хранимую процедуру EMPLOYEES_SEL
var
  i: Integer;
  SexParam: char;
begin
  if MaleRadioButton.Checked then
    SexParam := 'М'
  else
    SexParam := 'Ж';
  FDQuery.Open('select * from EMPLOYEES_SEL ('''+ SexParam +''')');
  StringGrid.RowCount := FDQuery.RecordCount + 1;

  for i := 1 to FDQuery.RecordCount do
  begin
    FDQuery.RecNo := i;
    StringGrid.Cells[0, i] := FDQuery.Fields[0].AsString;
    StringGrid.Cells[1, i] := FDQuery.Fields[1].AsString;
    StringGrid.Cells[2, i] := FDQuery.Fields[2].AsString;
    StringGrid.Cells[3, i] := FDQuery.Fields[3].AsString;
    StringGrid.Cells[4, i] := SexParam;
  end;
end;

procedure TTestDBForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
// Выравнивает текст в ячейках по правому краю
var
  Val: string;
  Align: Integer;
begin
  Val := TStringGrid(Sender).Cells[ACol, ARow];
  Align := (Rect.Right - Rect.Left) - TStringGrid(Sender).Canvas.TextWidth(Val);
  TStringGrid(Sender).Canvas.FillRect(Rect);
  TStringGrid(Sender).Canvas.TextOut(Rect.Left + Align - 1, Rect.Top, Val);
end;

procedure TTestDBForm.WriteBtnClick(Sender: TObject);
// Создает форму редактирования новой записи
// и записывает через хранимую процедуру EMPLOYEES_INS
var
  RecordAddForm: TRecordAddForm;
begin
  RecordAddForm := TRecordAddForm.Create(Self);
  try
    RecordAddForm.Visible := False;
    if RecordAddForm.ShowModal = mrOK then
    begin
      with CmdAddLine, RecordAddForm do
      begin
        ParamByName('LASTNAME').AsString := LastNameEdt.Text;
        ParamByName('FIRSTNAME').AsString := FirstNameEdt.Text;
        ParamByName('MIDDLENAME').AsString := MiddleNameEdt.Text;
        if MaleRadioButton.Checked then
          ParamByName('SEX').AsString := 'М'
        else
          ParamByName('SEX').AsString := 'Ж';
      end;

      FDTransaction.StartTransaction;
      CmdAddLine.Execute();
      FDTransaction.Commit;
      ReadBtnClick(Self);
    end;
  except
    on E: Exception do
    begin
      if FDTransaction.Active then
        FDTransaction.Rollback;
      ShowMessage(E.ToString);
    end;
  end;
  RecordAddForm.Free;
end;
end.
