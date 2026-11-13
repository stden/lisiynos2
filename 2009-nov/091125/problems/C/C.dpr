{ Решение задачи C }
Var N,I:LongInt;
Begin
  Assign(Input,'C.IN'); Reset(Input);
  Assign(Output,'C.OUT'); Rewrite(Output);
  Read(N);
  For I:=2 to Trunc(Sqrt(N)) do
    If (N mod I)=0 then
      Begin Writeln('NO,',I); Exit; End;
  Writeln('YES');
End.