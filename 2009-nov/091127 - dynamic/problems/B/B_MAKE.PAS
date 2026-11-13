{$N+}
Var I,N : Integer;
    D : Array [1..46] of Extended;
Begin
  Assign(Input,ParamStr(1)); Reset(Input);
  Assign(Output,ParamStr(2)); Rewrite(Output);
  D[1]:=1; D[2]:=1;
  Readln(N);
  For I:=3 to N do D[I]:=D[I-1]+D[I-2];
  Writeln(D[N]:0:0);
End.