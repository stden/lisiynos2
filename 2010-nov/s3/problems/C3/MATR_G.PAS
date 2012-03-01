Var N,MinAij,MaxAij,I,J:LongInt;
    Err:Integer;
Begin
  If ParamCount=4 then
    Begin
      RandSeed := 239366;
      Assign(Output,ParamStr(1)); Rewrite(Output);
      Val(ParamStr(2),N,Err);
      If Err>0 then Halt(1);
      Val(ParamStr(3),MinAij,Err);
      If Err>0 then Halt(1);
      Val(ParamStr(4),MaxAij,Err);
      If Err>0 then Halt(1);
      Writeln(N);
      For I:=1 to N do
        Begin
          For J:=1 to N do Write(Random(MaxAij-MinAij+1)+MinAij,' ');
          Writeln;
        End;
    End
  Else
    Writeln('Matr_g <output-file> <N> <Aij min limit> <Aij max limit>');
End.