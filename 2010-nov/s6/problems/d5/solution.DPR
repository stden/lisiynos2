{ Решение задачи D }
Var
  A : Array [0..1001] of LongInt;
  N,L,X,I,J,MaxH : Longint;
Begin
  Assign(Input,'D5.IN'); Reset(Input);
  Assign(Output,'D5.OUT'); Rewrite(Output);
  Read(N);
  For I:=0 to 1001 do A[I]:=0;
  For i:=1 to N do Begin
    Read(L,X); MaxH:=0;
    for J:=X to X+L-1 do If A[J]>MaxH then MaxH:=A[J];
    for J:=X to X+L-1 do A[J]:=MaxH+1;
  End;
  MaxH:=0;
  For I:=0 to 1001 do If A[I]>MaxH then MaxH:=A[i];
  Writeln(MaxH);
End.