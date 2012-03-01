{ Решение задачи A }
Var A,B,Ans,SS:String;
Const TestsB : Array [3..10] of Byte = (10,15,30,50,60,70,100,200);
      TestsA : Array [3..10] of Byte = (4,6,7,7,9,10,10,5);
Var I,J:Word;
    F:Text;
Begin
  Randomize;
  For I:=3 to 10 do
    Begin
      Writeln('Test ',I);
      Str(I,SS);
      While Length(SS)<2 do SS:='0'+SS;
      A:='';
      For J:=1 to TestsA[I] do A:=A+Chr(Random(26)+Ord('a'));
      B:='';
      For J:=1 to TestsB[I] do B:=B+Chr(Random(26)+Ord('a'));
     { - Gen Input - }
      Assign(F,SS); Rewrite(F);
      Writeln(F,A);
      Writeln(F,B);
      Close(F);
     { - Work - }
      Ans:='';
      While Length(A)<=Length(B) do
        Begin
          If A[1]=B[1] then
            If Length(A)=1 then
              Begin
                Ans:='YES';
                Break;
              End
            Else
              Delete(A,1,1);
          Delete(B,1,1);
        End;
      If Ans='' then Ans:='NO';
     { - Gen Output - }
      Assign(F,SS+'.a'); Rewrite(F);
      Writeln(F,Ans);
      Close(F);
    End;
End.