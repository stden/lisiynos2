{$APPTYPE CONSOLE}
Var K, X, Y, i, j, z : Longint;
    Pole : Array [-21..21, -21..21, -21..21] of Int64;

Begin
  FillChar(Pole, SizeOf(Pole), 0);
  Assign(input,'e.in');Reset(input);
  Assign(output,'e.out');Rewrite(output);
  Read(K, X, Y);
  Pole[1,0,1] := 1;  Pole[1,1,0] := 1;  Pole[1,0,-1] := 1;  Pole[1,-1,0] := 1;
  Z := 2;
  While Z <= 20 do Begin
    i := -20;
    While i <= 20 do Begin
      j := -20;
      While J <= 20 do Begin
        Pole [Z, i, j] := Pole[Z-1, i-1, j] + Pole[Z-1, i, j - 1] +
                         Pole[Z-1, i, j + 1] + Pole[Z-1, i + 1, j] ;
        Inc(J);
      End;
      Inc(I);
    End;
    Inc(Z);
  End;
  Writeln(Pole[k, x, y]);
End.
