Const MaxN = 70;
Var I,N : Integer;
    F : Array [1..MaxN] of Int64;
Begin
  Assign(Input,'b.in'); Reset(Input);
  Assign(Output,'b.out'); Rewrite(Output);
  F[1]:=1; F[2]:=1;
  Readln(N);
  assert( (1 <= N) and (N <= MaxN) ); { Проверяем корректность входного файла }
  For I:=3 to N do F[I]:=F[I-1]+F[I-2];
  Writeln(F[N]);
End.