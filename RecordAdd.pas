unit RecordAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TRecordAddForm = class(TForm)
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    LastNameEdt: TLabeledEdit;
    FirstNameEdt: TLabeledEdit;
    MiddleNameEdt: TLabeledEdit;
    SexGroupBox: TGroupBox;
    MaleRadioButton: TRadioButton;
    FemaleRadioButton: TRadioButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
