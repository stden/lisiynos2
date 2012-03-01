Function Solve( N,M:LongInt ):Longint;
  Var R:LongInt;
  Begin
    r := n * (n - 1);
    r := r div 2;
    Solve := r - m;
  End;

var n,m,r,I,J,Last: LongInt; SS:String; F:Text;
begin
 { 03-07 - Все одинокие, расчходятся на первом перекрестке }
 { 08-10 - Отходит по одному хоббиту каждый раз + все одинокие }
  Randomize;
  For I:=3 to 10 do
    Begin
      Writeln('Test ',I);
      Str(I,SS);
      While Length(SS)<2 do SS:='0'+SS;
     { - Gen Input - }
      Assign(F,SS); Rewrite(F);
      N:=3+Random(20000-3);
      M:=0;
      Writeln(F,N,' ',M);
     { 03-07 - Все одинокие, расходятся на первом перекрестке }
      If ((I>=3) And (I<=7)) then
        Begin
          Write(F,1,' ',N,' ');
          For J:=2 to (N+1) do { Всего N групп }
            Write(F,J,' ',1,' ');
          Writeln(F);
        End;
     { 08-10 - Отходит по одному хоббиту каждый раз + все одинокие }
      If ((I>=8) And (I<=10)) then
        Begin
          Last:=1;
          For J:=1 to (N-1) do { (N-1) перекрестков }
            Begin
              { 1 2 (N-1) 3 1 }
              { 2 4 (N-2) 5 1 }
              { 4 6 (N-3) 7 1 }
              Writeln(F,Last,' ',J*2,' ',(N-J),' ',J*2+1,' 1');
              Last:=J*2;
            End;
        End;
      Close(F);
     { - Gen Output - }
      Assign(F,SS+'.a'); Rewrite(F);
      Writeln(F,Solve(N,M));
      Close(F);
    End;
end.