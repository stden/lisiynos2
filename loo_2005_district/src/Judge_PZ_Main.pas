unit Judge_PZ_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
  TestSysUtil, RunLog,
  JudgeExec, ComCtrls, RXSpin, Grids, xmldom, XMLIntf, msxmldom, XMLDoc,
  myUtils, Mask, ToolEdit, XPMan, XML_Config;

var
  Path : String;
  BallsFactor : Integer;

type
  TF = class(TForm)
    SelectTask: TComboBox;
    Run: TBitBtn;
    PageControl: TPageControl;
    Main: TTabSheet;
    Log: TTabSheet;
    InputFile: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    OutputFile: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    _MemoryLimit: TRxSpinEdit;
    _TimeLimit: TRxSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    CheckerFile: TEdit;
    SourceExtension: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    CompilerCommand: TEdit;
    LogList: TMemo;
    CompileAlways: TCheckBox;
    CompileSolution: TCheckBox;
    CopyTestFiles: TCheckBox;
    CheckResult: TCheckBox;
    Label9: TLabel;
    ResultExtension: TEdit;
    AnswerExtension: TEdit;
    Label10: TLabel;
    Label12: TLabel;
    TaskDirectory: TEdit;
    Label13: TLabel;
    TestName: TEdit;
    ExitOnTestFail: TCheckBox;
    WaitOnExit: TCheckBox;
    Compile: TGroupBox;
    TestResults: TStringGrid;
    Summary_result: TEdit;
    Label11: TLabel;
    _MemoryLimit_Mesure: TLabel;
    _TimeLimit_Mesure: TLabel;
    ProgramName: TFilenameEdit;
    XPManifest1: TXPManifest;
    TabSheet1: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    Memo1: TMemo;
    _BallsFactor: TLabel;
    procedure RunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure _MemoryLimitChange(Sender: TObject);
    procedure _TimeLimitChange(Sender: TObject);
    procedure ProgramNameChange(Sender: TObject);
    procedure SelectTaskChange(Sender: TObject);
  private
  public
    XML : IXMLConfigType;
    function TryTest (const UsedInputFile:string; var TimeUsed, MaxMemoryUsed:int64):boolean;
    procedure CalcSummaryResult;
  end;

var
  F: TF;

implementation

{$R *.dfm}

function testescape:boolean;
var current:INPUT_RECORD;
    q:cardinal;
begin
  while WaitForSingleObject (GetStdHandle (STD_INPUT_HANDLE), 0)=WAIT_OBJECT_0 do begin
    if not ReadConsoleInput (GetStdHandle (STD_INPUT_HANDLE), current, 1, q) then begin
      result:=false; exit;
    end;
    if (q=1) and (current.eventtype=KEY_EVENT) and
       (current.Event.KeyEvent.bKeyDown) and
       (current.Event.KeyEvent.wRepeatCount>0) and
       (current.Event.KeyEvent.AsciiChar=#27) then begin result:=true; exit end;
  end;
  result:=false;
end;

procedure myhalt (code:integer);
var current:INPUT_RECORD;
    q:cardinal;
begin
  while WaitForSingleObject (GetStdHandle (STD_INPUT_HANDLE), 0)=WAIT_OBJECT_0 do
    ReadConsoleInput (GetStdHandle (STD_INPUT_HANDLE), current, 1, q);
  if F.WaitOnExit.Checked then begin
    repeat
      WaitForSingleObject (GetStdHandle (STD_INPUT_HANDLE), INFINITE);
      if not ReadConsoleInput (GetStdHandle (STD_INPUT_HANDLE), current, 1, q) then break;
      if (q<>0) and (current.eventtype=KEY_EVENT) then break;
    until false;
  end;
  case code of
   0: MessageDlg( F.Summary_result.Text, mtInformation, [mbOk], 0 );
   1: MessageDlg( F.Summary_result.Text, mtError, [mbOk], 0 );
  else
    MessageDlg( 'Unknown code: '+IntToStr(Code), mtError, [mbOk], 0 );
  end;
end;

var CheckerOutputPreviouslyDisplayed:boolean=false;

function TF.TryTest (const UsedInputFile:string; var TimeUsed, MaxMemoryUsed:int64):boolean;
var CurrentPath, CurrentInputFile, CurrentOutputFile:string;
    ResultCode:cardinal;
    res:cardinal;
    outhdl:cardinal;
    UtilityOutput:string;
    tstr,myResult:string;
begin
  CheckerOutputPreviouslyDisplayed:=false;
  Result:=false; TimeUsed:=0; MaxMemoryUsed:=0;
  if InputFile.Text='con' then CurrentInputFile:='~input~.tmp'
                            else CurrentInputFile:=InputFile.Text;
  if CopyTestFiles.Checked and (CurrentInputFile<>TaskDirectory.Text+UsedInputFile) then begin
    { Удаление предыдущего входного файла }
    if FileExists(CurrentInputFile) then DeleteFile (CurrentInputFile);
    sleep(1); { Для олимпиады по правилам ЛОО }
    if not FCopy (TaskDirectory.Text+UsedInputFile, CurrentInputFile, true) then begin
      logstring ('Unable to copy input file %s for test %s', [InputFile.Text, UsedInputFile]);
      exit;
    end;
  end;
  GetDir (0, CurrentPath);
  Res:=ExecuteContestantProgram (ProgramName.Text, CurrentPath, InputFile.Text, OutputFile.Text,
             EXEC_FLAG_NEW_CONSOLE, _TimeLimit.AsInteger, _MemoryLimit.AsInteger,
             TimeUsed, MaxMemoryUsed, ResultCode);
  case Res of
    EXEC_FAIL:tstr:='Failed To Execute';
    EXEC_ABORT:tstr:='Execution Aborted???';
    EXEC_SV:tstr:='Security Violation???';
    EXEC_RT:tstr:=format ('Runtime Error (%d)', [ResultCode]);
    EXEC_ML:tstr:='Memory Limit';
    EXEC_TL:tstr:='Time Limit';
    EXEC_OK:tstr:='Successful termination';
    else tstr:='Unknown Judge Response';
  end;
  writelog ( tstr + ' (' + IntToStr(round (timeused/10000)) + ' ms)');
  myResult := tstr;
  TestResults.Cells[1,TestResults.RowCount-1] := myResult;

  if Res<>EXEC_OK then exit;
  if OutputFile.Text='con' then CurrentOutputFile:='~output~.tmp' else CurrentOutputFile:=OutputFile.Text;
  if Res=EXEC_OK then begin
    if (ResultExtension.Text<>'') and CopyTestFiles.Checked then
      if not FCopy (CurrentOutputFile, UsedInputFile+'.'+ResultExtension.Text, true) then
        logstring ('Unable to copy output file %s for test %s', [OutputFile.Text, UsedInputFile]);
    if CheckResult.Checked then begin
      Res:=ExecuteChecker (TaskDirectory.Text+CheckerFile.Text, CurrentPath,
                           TaskDirectory.Text+UsedInputFile, CurrentOutputFile,
                           TaskDirectory.Text+UsedInputFile+'.'+AnswerExtension.Text,
                           '~check~.tmp',
                           EXEC_FLAG_UTILITY or EXEC_FLAG_NEW_PROCESS_GROUP,
                           outhdl);
      CloseHandle (outhdl);
      if not FileToString ('~check~.tmp',
                           1048576, false, UtilityOutput) then
        UtilityOutput:='';
      case Res of
        EXEC_OK:begin writelog ('Checker result: Accepted'); myResult:='Accepted'; end;
        EXEC_WA:begin writelog ('Checker result: Wrong Answer'); myResult:='Wrong Answer'; end;
        EXEC_JE:begin writelog ('Checker result: JURY''S ERROR'); myResult:='JURY''S ERROR'; end;
        EXEC_PE:begin writelog ('Checker result: Presentation Error'); myResult:='Presentation Error'; end;
        EXEC_ABORT:begin writelog ('Checker aborted???'); myResult:='Checker aborted???'; end;
        else writelog ('ERROR: Unable to invoke checking program');
      end;
      TestResults.Cells[1,TestResults.RowCount-1] := myResult;
      {}
      writelog ('Checker comments:'#13#10+UtilityOutput);
      CheckerOutputPreviouslyDisplayed:=true;
      Extended_Delete ('~check~.tmp');
      Result:=Res=EXEC_OK;
    end else Result:=true;
  end;
end;

procedure TF.RunClick(Sender: TObject);
var count, i:integer;
    s, ModuleName, CurrentPath, UtilityOutput:string;
    CurTimeUsed, CurMemoryUsed, MaxTimeUsed, MaxMemoryUsed:int64;
    tmp:boolean;
    CompRes, ResCode:cardinal;
    sourcemod, modulemod:int64;
    OutputHandle:THandle;
begin
  ChDir( Path );

  TestResults.RowCount := 1;
  LogList.Clear;

  JudgeExecExternalLog:=OnlyLogString;

  if TaskDirectory.Text<>'' then TaskDirectory.Text:=IncludeTrailingPathDelimiter (TaskDirectory.Text);

  if _TimeLimit.AsInteger<=60 then _TimeLimit.AsInteger:=_TimeLimit.AsInteger*1000;
  if _MemoryLimit.AsInteger<=512 then _MemoryLimit.AsInteger:=_MemoryLimit.AsInteger*1024;

  if _TimeLimit.AsInteger<=0 then _TimeLimit.AsInteger:=100000000;
  if _MemoryLimit.AsInteger<=0 then _MemoryLimit.AsInteger:=100000000;

  SetThreadPriority (GetCurrentThread, THREAD_PRIORITY_HIGHEST);

(*  if CompileSolution.Checked then begin
    ModuleName:=copy (ProgramName.Text, 1, length (ProgramName.Text)-length (ExtractFileExt (ProgramName.Text)));
    sourcemod:=FTime (ModuleName+'.'+SourceExtension.Text);
    modulemod:=FTime (ModuleName+'.exe');
    if sourcemod=0 then begin
      if modulemod=0 then begin logstring ('Unable to find source file %s - terminating',
                                           [ModuleName+'.'+SourceExtension.Text]);
        Summary_result.Text := Format( 'Unable to find source file %s - terminating', [ModuleName+'.'+SourceExtension.Text] );
        myhalt (1); exit;
      end;
    end else begin
      if CompileAlways.Checked or (modulemod=0) or (sourcemod>modulemod) then begin
        Extended_Delete (ModuleName+'.exe');
        GetDir (0, CurrentPath);
        CompRes:=ExecuteCompiler (CompilerCommand.Text, CurrentPath, '',
                                  ModuleName+'.'+SourceExtension.Text,
                                  EXEC_FLAG_UTILITY or EXEC_FLAG_NEW_CONSOLE,
                                  ResCode, OutputHandle);

        case CompRes of
          EXEC_ABORT:begin writelog ('Compilation aborted???'); Summary_result.Text:='Compilation aborted???'; myhalt (1); exit; end;
          EXEC_FAIL:begin writelog ('Unable to invoke compiler'); Summary_result.Text:='Unable to invoke compiler'; myhalt (1); exit; end;
          EXEC_OK: begin
            modulemod:=FTime (ModuleName+'.exe');
            if (not FileExists (ModuleName+'.exe')) or (modulemod<sourcemod) then begin
              writelog ('Compilation Error');
              UtilityOutput:=ProcessUtilityOutput (OutputHandle);
              writelog (UtilityOutput);
              writeonlylog('Compiler output:'+#13#10+UtilityOutput);
              Summary_result.Text := 'Compilation Error'; myhalt (1); exit;
            end else begin
              writelog ('Executable file successfully recompiled');
              UtilityOutput:=ProcessUtilityOutput (OutputHandle);
              writeonlylog('Compiler output:'+#13#10+UtilityOutput);
            end;
          end;
          else begin
            writelog ('Unknown result code returned during compilation');
            Summary_result.Text := 'Unknown result code returned during compilation';
            myhalt (1); exit;
          end;
        end;

      end;
    end;
  end; *)

  if not copytestfiles.Checked then TestName.Text:=InputFile.Text;

  if TestName.Text='' then begin
    MaxTimeUsed:=0;
    MaxMemoryUsed:=0;
    LogString ('Testing %s, in=%s, out=%s, ext=%s, tl=%d, ml=%d',
               [programname.Text, inputfile.Text, outputfile.Text,
                resultextension.Text, _timelimit.AsInteger, _memorylimit.AsInteger]);
    count:=0;
    for i:=0 to 99 do begin
      str (i, s); if i<10 then s:='0'+s;
      if FileExists (TaskDirectory.Text+s) then begin
        if testescape then begin
          WriteLog ('*** ESCAPE PRESSED ON KEYBOARD - EXECUTION ABORTED ***');
          break;
        end;
        if not CheckerOutputPreviouslyDisplayed then WriteLogEmpty;
        OnlyLogString ('Running on test %s', [s]);
        { Добавляем строку в таблицу результатов }
        TestResults.RowCount := TestResults.RowCount + 1;
        TestResults.FixedRows := 1;
        TestResults.Cells[0,TestResults.RowCount-1] := s;
        {}
        tmp:=TryTest (s, CurTimeUsed, CurMemoryUsed);
        if CurTimeUsed>MaxTimeUsed then MaxTimeUsed:=CurTimeUsed;
        if CurMemoryUsed>MaxMemoryUsed then MaxMemoryUsed:=CurMemoryUsed;
        TestResults.Cells[2,TestResults.RowCount-1] :=
          Format ('%.0f мс', [MaxTimeUsed/10000]);
        inc (count);
        if not tmp and ExitOnTestFail.Checked then break;
      end;
    end;
    if count=0 then Writelog ('No tests found') else begin
      if not CheckerOutputPreviouslyDisplayed then WriteLogEmpty;
      LogString ('Максимальное время работы: %.5f ms', [MaxTimeUsed/10000]);
      LogString ('Максимальное использование памяти: %u Kb', [MaxMemoryUsed div 1024]);
    end;
  end else begin
    LogString ('Testing %s, in=%s, out=%s, ext=%s, tl=%d, ml=%d on %s',
               [programname.Text, inputfile.Text, outputfile.Text, resultextension.Text,
                _timelimit.AsInteger, _memorylimit.AsInteger, TestName]);
    TryTest (TestName.Text, MaxTimeUsed, MaxMemoryUsed);
    LogString ('Work time: %.5f ms', [MaxTimeUsed/10000]);
    LogString ('Maximal memory usage: %u Kb', [MaxMemoryUsed div 1024]);
  end;
  WriteLogEmpty;
  CalcSummaryResult;
  Memo1.Lines.Add( Format ('Максимальное время работы: %.0f мс (миллисекунд)', [MaxTimeUsed/10000]) );
  Memo1.Lines.Add( Format ('Максимальное использование памяти: %u Кб', [MaxMemoryUsed div 1024]) );
  // myhalt (0); exit;
  for i:=0 to 99 do begin
    str (i, s); if i<10 then s:='0'+s;
    if FileExists(Path+s+'.u') then begin
      DeleteFile (Path+s+'.u');
      LogString('Delete '+Path+s+'.u',[]);
    end;
  end;
  if FileExists(Path+InputFile.Text) then DeleteFile (Path+InputFile.Text);
  if FileExists(Path+OutputFile.Text) then DeleteFile (Path+OutputFile.Text);
end;

procedure TF.FormCreate(Sender: TObject);
var i : Integer;
begin
  InputFile.Text := 'Выберите задачу';
  OutputFile.Text := 'Выберите задачу';
  CheckResult.Checked := true;
  TestResults.Cells[0,0] := 'Тест';
  TestResults.Cells[1,0] := 'Результат';
  TestResults.Cells[2,0] := 'Время';
  XML := Loadconfig('config.xml');
  SelectTask.Clear;
  for i := 0 to XML.Count-1 do begin
    SelectTask.Items.Add(XML.Task[i].Name);
  end;
end;

procedure TF.CalcSummaryResult;
var
  i,Balls:integer;
begin
  Balls := 0;
  Summary_Result.Text := 'Accepted';
  for i:=1 to TestResults.RowCount-1 do
    if TestResults.Cells[1,i]='Accepted' then begin
      Inc(Balls);
    end;
  Summary_Result.Text := IntToStr(Balls*BallsFactor);
  Memo1.Lines.Add(SelectTask.Text);
  Memo1.Lines.Add(ProgramName.Text);
  Memo1.Lines.Add('Сумма баллов: '+Summary_Result.Text );
end;

procedure TF._MemoryLimitChange(Sender: TObject);
begin
  try
    if _MemoryLimit.AsInteger<=512 then
      _MemoryLimit_Mesure.Caption := 'Mб'
    else
      _MemoryLimit_Mesure.Caption := 'Kб';
  except
  end;
end;

procedure TF._TimeLimitChange(Sender: TObject);
begin
  try
    if _TimeLimit.AsInteger<=60 then
      _TimeLimit_Mesure.Caption := 'сек'
    else
      _TimeLimit_Mesure.Caption := 'мс';
  except
  end;
end;

procedure TF.ProgramNameChange(Sender: TObject);
var S:String;
begin
  S := ProgramName.Text;
  if S[1] = '"' then Delete(S,1,1);
  if S[Length(S)] = '"' then Delete(S,Length(S),1);
  ProgramName.Text := S;
  Run.Enabled := FileExists(ProgramName.FileName)
    and (SelectTask.ItemIndex >= 0);
end;

procedure TF.SelectTaskChange(Sender: TObject);
var
  Task:IXMLTaskType;
begin
  Run.Enabled := FileExists(ProgramName.FileName)
    and (SelectTask.ItemIndex >= 0);
  Task := XML.Task[SelectTask.ItemIndex];
  BallsFactor := Task.BallsFactor;
  _BallsFactor.Caption := 'Цена одного теста (баллов): '+IntToStr(BallsFactor);
  TaskDirectory.Text := Task.Filename+'\';
  InputFile.Text := Task.Task_id+'.in';
  OutputFile.Text := Task.Task_id+'.out';
end;

end.
