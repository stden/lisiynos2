{$APPTYPE CONSOLE} { TimeLimit }

uses SysUtils;

Var
  N,M,I,J : LongInt;
  S : String;
Begin
  Assign(Input,'b.in'); Reset(Input);
  Assign(Output,'b.out'); Rewrite(Output);
  { Read }
  Read(N,M);
  for I:=1 to N do
    for J:=1 to I do
      S := S + IntToStr(I);
  { Out }
  for I:=1 to Length(S) do begin
    Write(S[I]);
    if I mod M = 0 then Writeln;
  end;
End.
