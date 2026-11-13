Var I,N : Integer;
    D : Array [1..40] of Extended;
Begin
  Assign(Input,ParamStr(1)); Reset(Input);
  Assign(Output,ParamStr(2)); Rewrite(Output);
  D[1]:=1;D[2]:=2;D[3]:=4;
  Readln(N);
  For I:=4 to N do 
    D[I]:=D[I-1]+D[I-2]+D[I-3];
  Writeln(D[N]:0:0)
End.
