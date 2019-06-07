object TestDBForm: TTestDBForm
  Left = 0
  Top = 0
  Caption = 'TestDBForm'
  ClientHeight = 340
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object OpenBtn: TSpeedButton
    Left = 8
    Top = 8
    Width = 97
    Height = 22
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1082
    OnClick = OpenBtnClick
  end
  object ReadBtn: TSpeedButton
    Left = 224
    Top = 36
    Width = 65
    Height = 22
    Caption = #1057#1095#1080#1090#1072#1090#1100
    Enabled = False
    OnClick = ReadBtnClick
  end
  object WriteBtn: TSpeedButton
    Left = 224
    Top = 8
    Width = 65
    Height = 22
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    OnClick = WriteBtnClick
  end
  object OpenFileBtn: TSpeedButton
    Left = 111
    Top = 8
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = OpenFileBtnClick
  end
  object StringGrid: TStringGrid
    Left = 8
    Top = 72
    Width = 442
    Height = 257
    DefaultRowHeight = 16
    DefaultDrawing = False
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 0
    OnDrawCell = StringGridDrawCell
  end
  object SexGroupBox: TGroupBox
    Left = 306
    Top = 8
    Width = 145
    Height = 57
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1076#1083#1103
    TabOrder = 1
    object SortBtn: TSpeedButton
      Left = 72
      Top = 19
      Width = 70
      Height = 25
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Enabled = False
      OnClick = SortBtnClick
    end
    object MaleRadioButton: TRadioButton
      Tag = 1
      Left = 12
      Top = 24
      Width = 41
      Height = 17
      Caption = #1052
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object FemaleRadioButton: TRadioButton
      Tag = 1
      Left = 41
      Top = 24
      Width = 32
      Height = 17
      Caption = #1046
      TabOrder = 1
    end
  end
  object FileEdt: TEdit
    Left = 8
    Top = 36
    Width = 201
    Height = 21
    TabOrder = 2
    Text = 'TESTDB.FDB'
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=D:\Mike\Delphi\DataBase\TESTDB.FDB'
      'User_Name=SYSDBA'
      'Password=sysdba'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 240
    Top = 176
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 320
    Top = 176
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    SQL.Strings = (
      'SELECT'
      ' LASTNAME'
      'FROM'
      ' EMPLOYEES'
      'ORDER BY name')
    Left = 240
    Top = 240
  end
  object CmdAddLine: TFDCommand
    Connection = FDConnection
    CommandText.Strings = (
      'EXECUTE PROCEDURE EMPLOYEES_INS('
      '  :LASTNAME, '
      '  :FIRSTNAME, '
      '  :MIDDLENAME,'
      '  :SEX'
      ')')
    ParamData = <
      item
        Name = 'LASTNAME'
        ParamType = ptInput
      end
      item
        Name = 'FIRSTNAME'
        ParamType = ptInput
      end
      item
        Name = 'MIDDLENAME'
        ParamType = ptInput
      end
      item
        Name = 'SEX'
        ParamType = ptInput
      end>
    Left = 320
    Top = 240
  end
  object OpenDialog: TOpenDialog
    FileName = '*.fdb'
    Left = 144
    Top = 8
  end
end
