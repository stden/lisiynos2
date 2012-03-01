unit runlog;

interface

uses SysUtils, TestSysUtil, TestSysTime, Dialogs;

var RunLogName:string=''; //run.log';

procedure WriteLog (const S:String);
procedure WriteOnlyLog (const S:String);
procedure WriteLogEmpty;
procedure OnlyLogString (const S : string; P : array of const);
procedure LogString (const S : string; P : array of const);

implementation

uses Judge_PZ_Main;

procedure WriteOnlyLog (const S:String);
var Z:string;
begin
  z:=MyDateTimeToStr (MyNow)+' '+S;
  F.LogList.WordWrap := true;
  F.LogList.Lines.Add(Z); { Выводим лог в формочку }
  {}
  if RunLogName<>'' then begin
    if not AppendStringToFile (Z+#13#10, RunLogName, true) then
      writeln ('WARNING: unable to write log file '+RunLogName);
  end;
end;

procedure WriteLogEmpty;
begin
  if RunLogName<>'' then begin
    if not AppendStringToFile (#13#10, RunLogName, true) then
      writeln ('WARNING: unable to write log file '+RunLogName);
  end;
end;

procedure WriteLog (const S:String);
begin
  WriteOnlyLog (s);
end;

procedure OnlyLogString (const S : string; P : array of const);
begin
  WriteOnlyLog (format (S, P));
end;

procedure LogString (const S : string; P : array of const);
begin
  try
    WriteLog (format (S, P));
  except
    ShowMessage( 'Wrong format: '+S );
  end;
end;

end.
