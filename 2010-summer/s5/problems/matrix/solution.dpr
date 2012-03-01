{ Решение задачи D }
Var N,M,I,J : Word;
    A : Array [1..50000] of Boolean;
Begin
  Assign(Input,'matrix.in'); Reset(Input);
  Assign(Output,'matrix.out'); Rewrite(Output);
  For I:=1 to 50000 do A[I]:=False;
  Read(N);
  For I:=1 to N do
    For J:=1 to N do
      Begin
        Read(M);
        A[M]:=True;
      End;
  M:=1;
  While A[M] do Inc(M);
  Writeln(M);
  Close(Output);
End.