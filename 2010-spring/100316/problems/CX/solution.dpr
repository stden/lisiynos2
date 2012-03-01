Var I,N : Integer;
    D : Array [1..40] of Int64;
Begin
  Assign(Input,'cx.in'); Reset(Input);
  Assign(Output,'cx.out'); Rewrite(Output);
  D[1]:=1;D[2]:=2;D[3]:=4;
  Readln(N);
  For I:=4 to N do 
    D[I]:=D[I-1]+D[I-2]+D[I-3];
  Writeln(D[N])
End.
