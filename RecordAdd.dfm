object RecordAddForm: TRecordAddForm
  Left = 0
  Top = 0
  Caption = 'RecordAddForm'
  ClientHeight = 268
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object OkBtn: TBitBtn
    Left = 16
    Top = 224
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
  end
  object CancelBtn: TBitBtn
    Left = 112
    Top = 224
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object LastNameEdt: TLabeledEdit
    Left = 16
    Top = 24
    Width = 171
    Height = 21
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = #1060#1072#1084#1080#1083#1080#1103
    TabOrder = 2
    Text = #1048#1074#1072#1085#1086#1074
  end
  object FirstNameEdt: TLabeledEdit
    Left = 16
    Top = 64
    Width = 171
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = #1048#1084#1103
    TabOrder = 3
    Text = #1048#1074#1072#1085
  end
  object MiddleNameEdt: TLabeledEdit
    Left = 16
    Top = 104
    Width = 171
    Height = 21
    EditLabel.Width = 49
    EditLabel.Height = 13
    EditLabel.Caption = #1054#1090#1095#1077#1089#1090#1074#1086
    TabOrder = 4
    Text = #1048#1074#1072#1085#1086#1074#1080#1095
  end
  object SexGroupBox: TGroupBox
    Left = 16
    Top = 131
    Width = 113
    Height = 57
    Caption = #1055#1086#1083
    TabOrder = 5
    object MaleRadioButton: TRadioButton
      Tag = 1
      Left = 16
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
      Left = 63
      Top = 23
      Width = 41
      Height = 17
      Caption = #1046
      TabOrder = 1
    end
  end
end
