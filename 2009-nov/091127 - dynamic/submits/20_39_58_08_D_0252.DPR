{$APPTYPE CONSOLE}

Uses math;

Var Old, Pole : Array [0..200, 0..200] of Longint;
    I,j, N  : LOngint;

Function Go(X, Y : Longint): Longint;
Var i, J: Longint;
Begin
  For i:=1 to N do
    For j:=1 to N do
      Pole[i,j] := Max(Pole[i-1,j] + Pole[i,j] , POle[i,j-1] + Pole[i,j]);
  Result := Pole[n,n];
End;

Begin
  Assign(input,'d.in');Reset(input);
  Assign(output,'d.out');Rewrite(output);
  Read(N);
  FillChar(Pole, SizeOf(Pole), 0 );
  For i:=1 to N do
    For j:= 1 to N do
      Read(pole[i,j]);
  Writeln(Go(1,1));
End.
