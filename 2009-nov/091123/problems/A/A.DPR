program A;

{$APPTYPE CONSOLE}

uses
  SysUtils;

Var N,I,J,J1,J2,K,Max,Min,I1,I2,MaxAll,Sum,Cur:LongInt;
    MJ1,MJ2,MI1,MI2:Byte;
    Matr : Array [1..100,1..100] of Integer;
    Sums : Array [1..100,1..100] of LongInt;
Begin
  Assign(Input,'a.in'); Reset(Input);
  Assign(Output,'a.out'); Rewrite(Output);
  { Read }
  Read(N);
  For I:=1 to N do
    For J:=1 to N do
      Read(Matr[I,J]);
  { Count Sums }
  For I:=1 to N do Sums[I,1]:=Matr[I,1];
  For I:=1 to N do
    For J:=2 to N do
      Sums[I,J]:=Sums[I,J-1]+Matr[I,J];
  { Solve }
  MaxAll:=-MaxLongInt;
  For J1:=1 to N do { Начало полоски }
    For J2:=J1 to N do { Конец полоски }
      Begin
        Sum:=0;
        Min:=0; I1:=1;
        Max:=0; I2:=1;
        For I:=1 to N do
          Begin
            Cur:=Sums[I,J2]-Sums[I,J1]+Matr[I,J1];
            Sum:=Sum+Cur;
            If Sum<Min then
              If I<N then
                Begin
                  Min:=Sum; I1:=I+1;
                  Max:=Sum; I2:=I+1;
                End
              Else
                Break;
            If Sum>Max then Begin Max:=Sum; I2:=I; End;
            If (Max-Min)>MaxAll then
              Begin
                MaxAll:=Max-Min;
                MI1:=I1; MI2:=I2;
                MJ1:=J1; MJ2:=J2;
              End;
          End;
      End;
  { Output }
  For I:=MI1 to MI2 do
    Begin
      For J:=MJ1 to MJ2 do Write(Matr[I,J],' ');
      Writeln;
    End;
End.
