{ Генератор тестов к задаче D }
Const Tests : Array [1..10] of LongInt = (2,4,7,10,13,19,23,51,99,100);
Var M : Word;
    A : Array [1..50000] of Boolean;
    F:Text; R,I,J,Test:LongInt; SS:String;
Begin
  For Test:=1 to 10 do
    Begin
      Writeln('Test ',Test);
      Str(Test,SS);
      While Length(SS)<2 do SS:='0'+SS;
     { - Gen Input - }
      Assign(F,SS); Rewrite(F);
      For I:=1 to 50000 do A[I]:=False;
      Writeln(F,Tests[Test]);
      For I:=1 to Tests[Test] do
        Begin
          For J:=1 to Tests[Test] do
            Begin
              M:=Random(Tests[Test]*Tests[Test])+1;
              Write(F,M,' ');
              A[M]:=True;
            End;
          Writeln(F);
        End;
      Close(F);
     { - Gen Output - }
     { Выводим минимальное число отсутвующее в таблице }
      M:=1; 
      While A[M] do Inc(M); { Выхода за границы A не может быть, т.к. 
         в A 50000 элементов из которых True не более 10000 }
      Assign(F,SS+'.a'); Rewrite(F);
      Writeln(F,M);
      Close(F);
    End;
End.