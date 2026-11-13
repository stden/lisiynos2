{$APPTYPE CONSOLE}

Var I, N, J : Longint;


Begin
  Read(N);
  Writeln(N);
  For  i:=1 to N do Begin
    For j:=1 to N do 
       Write(Random(10000),' ');
    Writeln;
  End;

End.