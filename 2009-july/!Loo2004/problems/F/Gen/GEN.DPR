{$APPTYPE CONSOLE}

Uses SysUtils;

Var i,N : Longint;

Begin
  Randomize;
  Read(N);
  Writeln(N);
  For i:=1 to n do Write(Random(3), ' ');
End.