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
  For I1:=1 to N do
    For I2:=I1 to N do 
      For J1:=1 to N do 
        For J2:=J1 to N do begin
          Sum := 0;
          for i:=I1 to I2 do 
            Sum := Sum + Sums[I,J2] - Sums[I,J1] + Matr[I,J1];
          if Sum > MaxAll then begin
            MaxAll := Sum;
            MI1 := I1; MJ1 := J1;
            MI2 := I2; MJ2 := J2;
          end;
        end;  
  { Output }
  For I:=MI1 to MI2 do
    Begin
      For J:=MJ1 to MJ2 do Write(Matr[I,J],' ');
      Writeln;
    End;
End.
