{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P-,Q+,R+,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE CONSOLE}
{-$WARN UNSAFE_CAST OFF}
{this module is for windows only!!!}
unit JudgeExec;

interface

uses SysUtils, Windows, TestSysUtil, MemoryLimit;

type TExternalLoggingFacility=procedure (const S : string; P : array of const);

const JudgeExecExternalLog:TExternalLoggingFacility=nil;


{config variables}
const Poll_Interval:cardinal = 10; {milliseconds, interval to poll process for
                                     checking its work time}

const TimeLimitEps:cardinal = 10000;

const EXEC_OK=0;
      EXEC_WA=1;
      EXEC_PE=2;
      EXEC_TL=3;
      EXEC_ML=4;
      EXEC_RT=5;
      EXEC_SV=6;
      EXEC_JE=7;
      EXEC_CE=8;
      EXEC_FAIL=9;
      EXEC_ABORT=10;

      EXEC_FLAG_DOSCALL=1;
      EXEC_FLAG_WINCALL=2;
      EXEC_FLAG_NEW_CONSOLE=4;
      EXEC_FLAG_UTILITY=8;
      EXEC_FLAG_ALLOW_ABORT=16;
      EXEC_FLAG_NEW_PROCESS_GROUP=32;

      INVOKER_OK=0;
      INVOKER_RT=1;
      INVOKER_SV=2;
      INVOKER_FAIL=3;

      CHECKER_OK=0;
      CHECKER_WA=1;
      CHECKER_PE=2;
      CHECKER_JE=3;


{S - program name & parameters [e.g.: dos_invk.com 200.exe input.txt output.txt]
 flags:
   EXEC_FLAG_DOSCALL - It should be set if it is known that the program to
                       be started is a DOS one.
   EXEC_FLAG_WINCALL - It should be set if it is known that the program to
                       be started is a Windows Application. This flag is
                       incompatible with EXEC_FLAG_DOSCALL, combining them
                       together may produce unpredictable results!!!
   EXEC_FLAG_NEW_CONSOLE - means that new window is to be created to run
                           the program
   EXEC_FLAG_UTILITY - Program to be runned is an utility (checker/compiler).
                       In this case the time limit parameter is ignored.
 If the program is not an utility, it is guaranteed that the program will be
 terminated in 2*TimeLimit+eps milliseconds, in this case return codes are:
   EXEC_OK  on success
   EXEC_TL  on time limit
   EXEC_FAIL  if failed to execute
 In the other case, return value is a handle of the temporary file containing
 utility output or invalid_handle_value on error.
 ReturnCode is filled with a program termination code on success.
 (may be contestant's error code or invoker error code)
 }

{returns result code}
function ExecuteContestantProgram (const ExeName, TestBox, InputFile, OutputFile:string;
                                   flags, timelimit, memorylimit:cardinal;
                                   var TimeUsed, MaxMemoryUsed:int64;
                                   var ResultCode:cardinal):cardinal;

{returns result code}
function ExecuteContestantProgramInvoker (const ExeName, TestBox, InvokerName,
                                          InputName, OutputName, LogName:string;
                                          flags, timelimit, memorylimit:cardinal;
                                          var TimeUsed, MaxMemoryUsed:int64):cardinal;

{returns result code as main value; outhandle as var}
function ExecuteChecker (const CheckerExe, TestBox, InputName, OutputName,
                         AnswerPath, CheckerLog:string; flags:cardinal;
                         var OutHandle:THandle):cardinal;

{returns outhandle or invalid_handle_value as main, ResultCode as var}
function ExecuteCompiler (const CompilerExe, CompileBox,
                          CompilerPars, SourceFile:string;
                          flags:cardinal; var ResultCode:cardinal;
                          var OutHandle:THandle):cardinal;
function ExecuteUtility (const CmdStr, StartDirectory:string;
                         flags:cardinal; var ReturnCode:cardinal;
                         var OutHandle:THandle):cardinal;

function ProcessUtilityOutput (handle:THandle): string;
procedure AbortTask;
procedure ResetAbortStatus;


implementation


procedure LogString (const S : string; P : array of const);
begin
  if @JudgeExecExternalLog<>nil then JudgeExecExternalLog (S, P) 
                                else writeln (format (S, P));
end;


var ExecAbortSemaphore:THandle;

const StandardHandlesCount=3;

const HDLTypes:array [1..StandardHandlesCount] of cardinal=
      (STD_INPUT_HANDLE, STD_OUTPUT_HANDLE, STD_ERROR_HANDLE);


function WaitWithAbort (handle:THandle; timeout, flags:cardinal):cardinal;
var tmp:array [0..1] of THandle;
begin
  if (flags and EXEC_FLAG_ALLOW_ABORT)=0 then
    Result:=WaitForSingleObject (handle, timeout)
  else begin
    tmp[0]:=handle; tmp[1]:=ExecAbortSemaphore;
    Result:=WaitForMultipleObjects (2, @tmp, false, timeout);
  end;
end;


var MemoryLimitInited:integer;


function CheckMemoryLimit (ProcessID:DWORD; MemoryLimit:cardinal; var MaxMemoryUsed:int64):cardinal;
var CurMemoryUsed:int64;
begin
  Result:=EXEC_OK;
  //logstring ('poll', []);
  if MemoryLimit>0 then begin
    if MemoryLimitInited=0 then begin
      MemoryLimitInited:=ord (InitMemoryLimit)+1;
      if MemoryLimitInited<2 then
        LogString ('Unable to initalize memory limit monitoring facility!', []);
    end;
    if MemoryLimitInited<2 then exit;
    if not processmemorylimitdata (ProcessID, CurMemoryUsed) then
      LogString ('Unable to determine memory usage properties for PID=%u', [ProcessID])
    else begin
      if CurMemoryUsed>int64(MemoryLimit)*1024 then Result:=EXEC_ML;
      if CurMemoryUsed>MaxMemoryUsed then MaxMemoryUsed:=CurMemoryUsed;
    end;
  end;
end;


function CheckTimeLimit (handle:THandle; TimeLimit:cardinal):cardinal;
var CRTime, EXTime, SYSTime, USRTime:filetime;
begin
  if not GetProcessTimes (handle, CRTime, EXTime, SYSTime, USRTime) then begin
    LogString ('Unable to get process execution time!', []);
    Result:=EXEC_FAIL
  end
  else begin
    {writeln (int64 (SYSTime), ' ', int64 (USRTime));}
    if int64 (SYSTime)+int64 (USRTime)>=
       int64 (TimeLimit)*int64 (10000) then
       Result:=EXEC_TL
    else
       Result:=EXEC_OK;
  end;
end;


function CheckTimeAndMemoryLimit (handle:THandle; ProcessID:DWORD;
                                  TimeLimit, MemoryLimit:cardinal;
                                  var MaxMemoryUsed:int64):cardinal;
begin
  Result:=CheckMemoryLimit (ProcessID, MemoryLimit, MaxMemoryUsed);
  if Result<>EXEC_OK then exit;
  Result:=CheckTimeLimit (handle, TimeLimit);
end;


procedure LogProcessorTime (handle:THandle; var TimeUsed:int64);
var CRTime, EXTime, SYSTime, USRTime:filetime;
begin
  if GetProcessTimes (handle, CRTime, EXTime, SYSTime, USRTime) then begin
    LogString ('Processor time used: system=%.5f ms, user=%.5f ms total=%.5f ms.',
              [int64 (SYSTime)/10000, int64 (USRTime)/10000,
              (int64 (SYSTime)+int64 (USRTime))/10000]);
    TimeUsed:=int64 (SYSTime)+int64 (USRTime)
  end else TimeUsed:=0;
end;


procedure LogFacticalExecution (starttick:cardinal);
begin
  LogString ('Factical execution time: %u ms', [GetTickDist (starttick)]);
end;


procedure LogMemoryUsage (MaxMemoryUsed:int64);
begin
  LogString ('Maximal memory usage: %u Kb', [MaxMemoryUsed div 1024]);
end;


procedure LogAllInformation (handle:THandle; starttick:cardinal; var TimeUsed:int64; MaxMemoryUsed:int64);
begin
  LogProcessorTime (handle, TimeUsed);
  LogFacticalExecution (starttick);
  if MaxMemoryUsed>0 then LogMemoryUsage (MaxMemoryUsed);
end;


function WaitContestantProcess (handle:THandle; TimeLimit, MemoryLimit, PID, flags:cardinal;
                                var TimeUsed, MaxMemoryUsed:int64; var ReturnCode:cardinal):cardinal;
var starttick, waitresult:cardinal;
begin
  Result:=EXEC_FAIL; MaxMemoryUsed:=0; TimeUsed:=0;
  starttick:=GetTickCount ();
  case CheckTimeAndMemoryLimit (handle, PID, TimeLimit, MemoryLimit, MaxMemoryUsed) of
    EXEC_OK:;
    EXEC_TL:begin
              Result:=EXEC_TL;
              LogAllInformation (handle, starttick, TimeUsed, MaxMemoryUsed);
              TerminateProcess (handle, $1000ffff);
              exit;
            end;
    EXEC_ML:begin
              Result:=EXEC_ML;
              LogAllInformation (handle, starttick, TimeUsed, MaxMemoryUsed);
              TerminateProcess (handle, $1000ffff);
              exit;
            end;
    else exit;
  end;
  repeat
    waitresult:=WaitWithAbort (handle, poll_interval, flags);
    case waitresult of
      WAIT_OBJECT_0+1:
        begin
          Result:=EXEC_ABORT;
          TerminateProcess (handle, $1000ffff);
          exit;
        end;
      WAIT_OBJECT_0:
        case CheckTimeAndMemoryLimit (handle, PID, TimeLimit, MemoryLimit, MaxMemoryUsed) of
          EXEC_OK:break;
          EXEC_TL:begin
                    Result:=EXEC_TL;
                    LogAllInformation (handle, starttick, TimeUsed, MaxMemoryUsed);
                    exit;
                  end;
          EXEC_ML:begin
                    Result:=EXEC_ML;
                    LogAllInformation (handle, starttick, TimeUsed, MaxMemoryUsed);
                    exit;
                  end;
          else exit;
        end;
      WAIT_TIMEOUT:
        case CheckTimeAndMemoryLimit (handle, PID, TimeLimit, MemoryLimit, MaxMemoryUsed) of
          EXEC_OK:;
          EXEC_TL:begin
                    Result:=EXEC_TL;
                    LogAllInformation (handle, starttick, TimeUsed, MaxMemoryUsed);
                    TerminateProcess (handle, $1000ffff);
                    exit;
                  end;
          EXEC_ML:begin
                    Result:=EXEC_ML;
                    LogAllInformation (handle, starttick, TimeUsed, MaxMemoryUsed);
                    TerminateProcess (handle, $1000ffff);
                    exit;
                  end;
          else exit;
        end
      else exit;
    end;
    if (GetTickDist (starttick))>=TimeLimit*3+TimeLimitEps then begin
      LogAllInformation (handle, starttick, TimeUsed, MaxMemoryUsed);
      TerminateProcess (handle, $1000ffff);
      Result:=EXEC_TL;
      exit;
    end;
  until false;
  if not GetExitCodeProcess (handle, ReturnCode) then exit;
  LogAllInformation (handle, starttick, TimeUsed, MaxMemoryUsed);
  Result:=EXEC_OK;
end;


function WaitUtilityProcess (handle:THandle; flags:cardinal;
                             var ReturnCode:cardinal):cardinal;
begin
  case WaitWithAbort (handle, INFINITE, flags) of
    WAIT_OBJECT_0+1:
      begin
        Result:=EXEC_ABORT;
        TerminateProcess (handle, $1000ffff);
      end;
    WAIT_OBJECT_0:
      begin
        if not GetExitCodeProcess (handle, ReturnCode) then Result:=EXEC_FAIL
        else Result:=EXEC_OK;
      end;
    else Result:=EXEC_FAIL;
  end;
end;



function ExternalExecuteRedirect (const CmdStr, StartDirectory:string;
         flags, TimeLimit, memorylimit:cardinal; infile, outfile, errfile:THandle;
         var TimeUsed, MaxMemoryUsed:int64; var ReturnCode:cardinal):cardinal;
var SInfo:StartupInfo;
    PInfo:Process_Information;
    my_std_handle:array [1..StandardHandlesCount] of THandle;
    my_console_mode:array [1..StandardHandlesCount] of cardinal;
    i, eflags, olderrormode:cardinal;
    handle:THandle;
begin
  Result:=EXEC_FAIL;
  fillchar (SInfo, sizeof (SInfo), 0);
  SInfo.cb:=sizeof (SInfo);
  if (flags and EXEC_FLAG_NEW_CONSOLE)<>0 then begin
    SInfo.dwFlags:=STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
    SInfo.wShowWindow:=SW_MINIMIZE;
    eflags:=CREATE_NEW_CONSOLE;
  end else begin
    SInfo.dwFlags:=STARTF_USESTDHANDLES;
    if (flags and EXEC_FLAG_WINCALL)<>0 then eflags:=DETACHED_PROCESS
                                        else eflags:=0;
  end;
  if (flags and EXEC_FLAG_NEW_PROCESS_GROUP)<>0 then
    eflags:=eflags or CREATE_NEW_PROCESS_GROUP;
  SInfo.hStdInput:=infile;
  SInfo.hStdOutput:=outfile;
  SInfo.hStdError:=errfile;

  olderrormode:=SetErrorMode (SEM_FAILCRITICALERRORS or SEM_NOGPFAULTERRORBOX
                              or SEM_NOOPENFILEERRORBOX);{error mode to inherit}
  for i:=1 to StandardHandlesCount do begin
    my_std_handle[i]:=GetStdHandle (HDLTypes [i]);
    if not IsErrorHandle (my_std_handle[i]) then
      if not GetConsoleMode (my_std_handle[i], my_console_mode[i]) then
        my_std_handle[i]:=invalid_handle_value;
  end;

  if WaitForSingleObject (ExecAbortSemaphore, 0)=WAIT_OBJECT_0 then
    RESULT:=EXEC_ABORT
  else
  if CreateProcess (nil, PChar (CmdStr), nil, nil, true, eflags,
                    nil, PChar (ExcludeTrailingPathDelimiter (
                          ExpandFileName (StartDirectory))),
                    SInfo, PInfo) then begin
    {1. open valid handle to process}
    if (flags and (EXEC_FLAG_NEW_PROCESS_GROUP or EXEC_FLAG_NEW_CONSOLE or EXEC_FLAG_WINCALL))=0
        then
      handle:=OpenProcess (PROCESS_ALL_ACCESS, false,
                                   PInfo.dwProcessId){windows 2000 bug}
    else handle:=PInfo.hProcess;
    {writeln (Startdirectory, ' ', cmdstr);
    writeln (handle);
    writeln (GetLastError);}
    if IsErrorHandle (handle) then
      {ABORT!!!}
      TerminateProcess (PInfo.hProcess, $1000ffff){may be it helps...}
    else begin
      if (flags and EXEC_FLAG_UTILITY)<>0 then begin
        Result:=WaitUtilityProcess (handle, flags, ReturnCode);
        TimeUsed:=0;
        MaxMemoryUsed:=0;
      end else
        Result:=WaitContestantProcess (handle, TimeLimit, MemoryLimit,
                                       PInfo.dwProcessId, flags,
                                       TimeUsed, MaxMemoryUsed, ReturnCode);

      {writeln (ReturnCode);}


      if (flags and (EXEC_FLAG_NEW_PROCESS_GROUP or EXEC_FLAG_NEW_CONSOLE or EXEC_FLAG_WINCALL))=0
          then
        CloseHandle (handle); {different from provided}
    end;
    CloseHandle (PInfo.hProcess);
    CloseHandle (PInfo.hThread);
  end;

  for i:=1 to StandardHandlesCount do
    if not IsErrorHandle (my_std_handle[i]) then
      if SetStdHandle (HDLTypes[i], my_std_handle[i]) then
        SetConsoleMode (my_std_handle[i], my_console_mode[i]);
  SetErrorMode (olderrormode);
end;


(*function ExecuteContestant (const CmdStr, StartDirectory, InputFile, OutputFile:string;
                            flags, TimeLimit, memorylimit:cardinal;
                            var TimeUsed, MaxMemoryUsed:int64;
                            var ReturnCode:cardinal):cardinal;
var SecAttr:security_attributes;
    nulhdl, inhdl, outhdl:THandle;
begin
  SecAttr.nlength:=sizeof (SecAttr);
  SecAttr.lpSecurityDescriptor:=nil;
  SecAttr.bInheritHandle:=true;
  nulhdl:=createfile ('nul', generic_read or generic_write,
                       file_share_read or file_share_write,
                       @SecAttr, create_always, 0, 0);
  if IsErrorHandle (nulhdl) then Result:=EXEC_FAIL
  else begin
    if InputFile='con' then begin
      SecAttr.nlength:=sizeof (SecAttr);
      SecAttr.lpSecurityDescriptor:=nil;
      SecAttr.bInheritHandle:=true;
      inhdl:=createfile (PChar (IncludeTrailingBackSlash (StartDirectory)+'~input~.tmp'), generic_read, 0, @SecAttr,
                           open_existing, file_attribute_normal or
                           file_flag_sequential_scan,
                           0);
      if (IsErrorHandle (inhdl)) then begin
        Result:=EXEC_FAIL; CloseHandle (nulhdl); exit
      end;
    end else inhdl:=nulhdl;
    if OutputFile='con' then begin
      SecAttr.nlength:=sizeof (SecAttr);
      SecAttr.lpSecurityDescriptor:=nil;
      SecAttr.bInheritHandle:=true;
      outhdl:=createfile (PChar (IncludeTrailingBackSlash (StartDirectory)+'~output~.tmp'), generic_write, 0, @SecAttr,
                           create_always, file_attribute_normal or
                           file_flag_sequential_scan,
                           0);
      if (IsErrorHandle (outhdl)) then begin
        Result:=EXEC_FAIL; if InputFile='con' then CloseHandle (inhdl);
        CloseHandle (nulhdl); exit
      end;
    end else outhdl:=nulhdl;
    Result:=ExternalExecuteRedirect (CmdStr, StartDirectory, flags,
                           TimeLimit, memorylimit, inhdl, outhdl, outhdl, 
                           TimeUsed, MaxMemoryUsed, ReturnCode);
    CloseHandle (nulhdl);
    if InputFile='con' then CloseHandle (inhdl);
    if OutputFile='con' then CloseHandle (outhdl);
  end;
end;*)

function ExecuteContestant (const CmdStr, StartDirectory, InputFile, OutputFile:string;
                            flags, TimeLimit, memorylimit:cardinal;
                            var TimeUsed, MaxMemoryUsed:int64;
                            var ReturnCode:cardinal):cardinal;
var SecAttr:security_attributes;
    inhdl, outhdl:THandle;
begin
  SecAttr.nlength:=sizeof (SecAttr);
  SecAttr.lpSecurityDescriptor:=nil;
  SecAttr.bInheritHandle:=true;
  if InputFile='con' then
    inhdl:=createfile (PChar (IncludeTrailingPathDelimiter (StartDirectory)+'~input~.tmp'),
                       generic_read, 0, @SecAttr, open_existing, 
                       file_attribute_normal or file_flag_sequential_scan, 0)
  else 
    inhdl:=createfile ('nul', generic_read, file_share_read or file_share_write,
                       @SecAttr, create_always, 0, 0);
  if (IsErrorHandle (inhdl)) then begin
    Result:=EXEC_FAIL; exit
  end;
  SecAttr.nlength:=sizeof (SecAttr);
  SecAttr.lpSecurityDescriptor:=nil;
  SecAttr.bInheritHandle:=true;
  if OutputFile='con' then
    outhdl:=createfile (PChar (IncludeTrailingPathDelimiter (StartDirectory)+'~output~.tmp'), 
                        generic_write, 0, @SecAttr, create_always, 
                        file_attribute_normal or file_flag_sequential_scan, 0)
  else 
    outhdl:=createfile ('nul', generic_write, file_share_read or file_share_write,
                       @SecAttr, create_always, 0, 0);
  if (IsErrorHandle (outhdl)) then begin
    Result:=EXEC_FAIL; CloseHandle (inhdl);
    exit
  end;
  Result:=ExternalExecuteRedirect (CmdStr, StartDirectory, flags,
                         TimeLimit, memorylimit, inhdl, outhdl, {temporary}outhdl,
                         TimeUsed, MaxMemoryUsed, ReturnCode);
  CloseHandle (outhdl);
  CloseHandle (inhdl);
end;





function ExecuteUtility (const CmdStr, StartDirectory:string;
                         flags:cardinal; var ReturnCode:cardinal;
                         var OutHandle:THandle):cardinal;
var SecAttr:security_attributes;
    OutTempName(*, ErrorTempName*):array [0..MAX_PATH] of char;
    TimeUsed, MaxMemoryUsed:int64;
    InHandle:THandle;
begin
  Result:=EXEC_FAIL;
  if GetTempFileName (PChar (ExcludeTrailingPathDelimiter (StartDirectory)),
                      'ef', 0, OutTempName)=0 then exit;
  {if GetTempFileName (PChar (ExcludeTrailingBackSlash (StartDirectory)),
                      'ef', 0, ErrorTempName)=0 then exit;}
  SecAttr.nlength:=sizeof (SecAttr);
  SecAttr.lpSecurityDescriptor:=nil;
  SecAttr.bInheritHandle:=true;
  InHandle:=createfile ('nul', generic_read {or generic_write},
                       file_share_read or file_share_write,
                       @SecAttr, create_always, 0, 0);
  if IsErrorHandle (InHandle) then exit;
  SecAttr.nlength:=sizeof (SecAttr);
  SecAttr.lpSecurityDescriptor:=nil;
  SecAttr.bInheritHandle:=true;
  OutHandle:=createfile (OutTempName, generic_read or generic_write, 0, @SecAttr,
                       create_always, file_attribute_normal or
                       file_flag_sequential_scan or file_flag_delete_on_close,
                       0);
  if IsErrorHandle (OutHandle) then begin CloseHandle (InHandle); exit end;
  (*SecAttr.nlength:=sizeof (SecAttr);
  SecAttr.lpSecurityDescriptor:=nil;
  SecAttr.bInheritHandle:=true;
  ErrorHandle:=createfile (ErrorTempName, {generic_read or }generic_write, file_share_read, @SecAttr,
                       create_always, file_attribute_normal or
                       file_flag_sequential_scan or file_flag_delete_on_close,
                       0);
  if IsErrorHandle (ErrorHandle) then begin CloseHandle (OutHandle);
    CloseHandle (InHandle); exit end; {ErrorHandle:=INVALID_HANDLE_VALUE;}*)
  Result:=ExternalExecuteRedirect (CmdStr, StartDirectory,
                         flags or EXEC_FLAG_UTILITY,
                         0, 0, InHandle, OutHandle, OutHandle, TimeUsed, MaxMemoryUsed,
                         ReturnCode);
  if Result<>EXEC_OK then begin
    (*CloseHandle (ErrorHandle);*)
    CloseHandle (OutHandle);
  end;
  CloseHandle (InHandle);
end;



{here are some example functions for this module}
{returns result code}
function ExecuteContestantProgram (const ExeName, TestBox, InputFile, OutputFile:string;
                                   flags, timelimit, memorylimit:cardinal;
                                   var TimeUsed, MaxMemoryUsed:int64;
                                   var ResultCode:cardinal):cardinal;
begin
  assert ((flags and EXEC_FLAG_UTILITY)=0);
  Result:=ExecuteContestant (ExpandFileName (ExeName), TestBox, InputFile,
                             OutputFile, flags, timelimit, memorylimit,
                             TimeUsed, MaxMemoryUsed, ResultCode);
  if (Result=EXEC_OK) and (ResultCode<>0) then Result:=EXEC_RT;
end;


{returns result code}
function ExecuteContestantProgramInvoker (const ExeName, TestBox, InvokerName,
                                          InputName, OutputName, LogName:string;
                                          flags, timelimit, memorylimit:cardinal;
                                          var TimeUsed, MaxMemoryUsed:int64):cardinal;
var ResultCode:cardinal;
begin
  assert ((flags and EXEC_FLAG_UTILITY)=0);
  Result:=ExecuteContestant (ExpandFileName (InvokerName)+' '+ExeName+' '+
                                  InputName+' '+
                                  OutputName+' '+LogName, 
                                  TestBox, InputName, OutputName, flags,
                                  timelimit, memorylimit, TimeUsed, 
                                  MaxMemoryUsed, ResultCode);
  if Result=EXEC_OK then
    case ResultCode of
      INVOKER_OK:;
      INVOKER_RT:Result:=EXEC_RT;
      INVOKER_SV:Result:=EXEC_SV;
      else Result:=EXEC_FAIL;
    end;
end;


{returns result code as main value; outhandle as var}
function ExecuteChecker (const CheckerExe, TestBox, InputName, OutputName,
                         AnswerPath, CheckerLog:string; flags:cardinal;
                         var OutHandle:THandle):cardinal;
var ResultCode:cardinal;
begin
  assert( FileExists( ExpandFileName (CheckerExe) ), Format('Checker "%s" not found!',[CheckerExe]) );
  Result:=ExecuteUtility (ExpandFileName (CheckerExe)+' '+InputName+' '+
                                         OutputName+
                                     ' '+AnswerPath+' '+CheckerLog, TestBox,
                                     flags or EXEC_FLAG_UTILITY, ResultCode,
                          OutHandle);
  if Result=EXEC_OK then
    case ResultCode of
      CHECKER_OK:Result:=EXEC_OK;
      CHECKER_WA:Result:=EXEC_WA;
      CHECKER_PE:Result:=EXEC_PE;
      else Result:=EXEC_JE;
    end;
end;

function ExecuteCompiler (const CompilerExe, CompileBox,
                          CompilerPars, SourceFile:string;
                          flags:cardinal; var ResultCode:cardinal;
                          var OutHandle:THandle):cardinal;
begin
  Result:=ExecuteUtility (CompilerExe+' '+CompilerPars+' '+
                                  SourceFile, CompileBox, 
                                  flags or EXEC_FLAG_UTILITY, ResultCode,
                          OutHandle);
end;


function ProcessUtilityOutput (handle:THandle): string;
var tmp:string;
    s, d, l, h:cardinal;
begin
  Result:='';
  if SetFilePointer (handle, 0, nil, FILE_BEGIN)<>0 then exit;
  if not HandleToString (handle, 262144, false, tmp) then exit;
  setlength (Result, length (tmp)*2);
  d:=1; l:=1; h:=1;
  for s:=1 to length (tmp) do
    case tmp[s] of
      #8:if d>h then dec (d);
      #10:begin
            d:=l; Result[d]:=#13; Result[d+1]:=#10; inc (d, 2); h:=d; l:=d
          end;
      #13:d:=h;
    else begin
           Result[d]:=tmp[s];
           inc (d);
           if d>l then l:=d;
         end;
    end;
  if l>d then d:=l;
  SetLength (Result, d-1);
end;


procedure AbortTask;
begin
  SetEvent (ExecAbortSemaphore);
end;


procedure ResetAbortStatus;
begin
  ResetEvent (ExecAbortSemaphore);
end;

initialization
  ExecAbortSemaphore:=CreateEvent (nil, false, false, nil);
  assert (not IsErrorHandle (ExecAbortSemaphore)); 
finalization
  CloseHandle (ExecAbortSemaphore);
end.
