{ Решение задачи A }
Var A,B:String;
Begin
  Assign(Input,'wordgame.in'); Reset(Input);
  Assign(Output,'wordgame.out'); Rewrite(Output);
  Readln(A); 
  Readln(B);
  While Length(A)<=Length(B) do
    Begin
      If A[1]=B[1] then
        If Length(A)=1 then
          Begin
            Writeln('YES');
            Exit;
          End
        Else
          Delete(A,1,1);
      Delete(B,1,1);
    End;
  Writeln('NO');
End.