{$N+}
Var I,N : Integer;
    D : Array [1..46] of Int64;
Begin
  Assign(Input,'b.in'); Reset(Input);
  Assign(Output,'b.out'); Rewrite(Output);
  D[1]:=1; D[2]:=1;
  Readln(N);
  assert( (1 <= N) and (N <= 70) );
  For I:=3 to N do D[I]:=D[I-1]+D[I-2];
  Writeln(D[N]);
End.