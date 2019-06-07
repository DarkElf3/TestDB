program TestDBProject;

uses
  Vcl.Forms,
  TestDB in 'TestDB.pas' {TestDBForm},
  RecordAdd in 'RecordAdd.pas' {RecordAddForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestDBForm, TestDBForm);
  Application.Run;
end.
