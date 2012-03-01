{$APPTYPE CONSOLE}

Var A    : Array [1..10000] of Longint;
    I, N : Longint;

Procedure Swap(Var A,B:Longint);
Var Tmp : Longint;
Begin
  Tmp:=A;
  A:=B;
  B:=Tmp;
End;

Begin
  Randomize;
  Read(N);
  For i:=1 to N do Read(A[i]);
  For i:=1 to 10*N do
    Swap(A[Random(N-1)+1],A[Random(N-1)+1]);
  Writeln(N);
  For i:=1 to N do Write(A[i],' ');
End.