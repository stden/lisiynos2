{$APPTYPE CONSOLE}

Var I, N, J : Longint;

Begin
  Randomize;
  Read(N);
  Writeln(N);
  For i:=1 to N div 100 do 
    for j:=1 to 100 do
      Write(i,' ');
{  j:=1;
  For i:=1 to 1000 do Begin
    Write(3*i, ' ');
  End;  
}End.