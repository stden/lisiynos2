{ Генератор тестов к задаче "На клетчатой бумаге" }

{$APPTYPE CONSOLE}

Function Solve( R:LongInt ):LongInt;
  Var X,Y,S1,S2,K:LongInt;
  Begin
    K:=0;
    S1:=R*R;
    X:=1; Y:=R;
    While (X<R) do
      Begin
        S2:=S1-X*X;
        While Y*Y>S2 do Dec(Y);
        K:=K+Y;
        X:=X+1;
      End;
    Solve:=K*4;
  End;

Const Tests : Array [1..10] of LongInt = (1,5,7,10,29,59,239,5123,9999,10000);

Var F:Text; R,I:LongInt; SS:String;
Begin
  For I:=1 to 10 do
    Begin
      Writeln('Test ',I);
      Str(I,SS);
      While Length(SS)<2 do SS:='0'+SS;
     { - Gen Input - }
      R:=Tests[I];
      Assign(F,SS); Rewrite(F);
      Writeln(F,R);
      Close(F);
     { - Gen Output - }
      Assign(F,SS+'.a'); Rewrite(F);
      Writeln(F,Solve(R));
      Close(F);
    End;
End.