program SimpleTest;

uses
  Forms,
  Judge_PZ_Main in 'Judge_PZ_Main.pas' {F},
  SysUtils,
  Windows,
  JudgeExec in 'JudgeExec.pas',
  TestSysUtil in 'TestSysUtil.pas',
  MemoryLimit in 'MemoryLimit.pas',
  runlog in 'runlog.pas',
  TestSysTime in 'TestSysTime.pas',
  myUtils in 'myUtils.pas',
  XML_Config in 'XML_Config.pas';

{$R *.res}

begin
  { »щем путь запуска программы и запоминаем его }
  Path:=ParamStr(0);
  while Path[Length(Path)]<>'\' do Delete(Path,Length(Path),1);
  {}
  Application.Initialize;
  Application.CreateForm(TF, F);
  Application.Run;
end.
