{ Решение задачи A }
Var N,I,XorSum,Curr:LongInt;
Begin
  Assign(Input,'A.IN'); Reset(Input);
  Assign(Output,'A.OUT'); Rewrite(Output);
  Read(N);
  While N<>0 do
    Begin
      XorSum:=0;
      For I:=1 to N do
        Begin
          Read(Curr);
          XorSum:= XorSum Xor Curr;
        End;
      Writeln(XorSum);
      Read(N);
    End;
End.