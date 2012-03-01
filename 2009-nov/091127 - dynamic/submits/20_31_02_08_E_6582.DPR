{$APPTYPE CONSOLE}
Var K, X, Y, i, j, z : Longint;
    Pole : Array [-21..21, -21..21, -21..21] of Int64;

Begin
  FillChar(Pole, SizeOf(Pole), 0);
  Assign(input,'e.in');Reset(input);
  Assign(output,'e.out');Rewrite(output);
  Read(K, X, Y);
  Pole[0,0,0] := 1;
  Z := 1;
  While Z <= 19 do Begin
    i := -19;
    While i <= 19 do Begin
      j := -19;
      While J <= 19 do Begin
        Pole [Z, i, j] := Pole[Z-1, i - 1, j] + Pole[Z-1, i, j - 1] +
                         Pole[Z-1, i, j + 1] + Pole[Z-1, i + 1, j] ;
        Inc(J);
      End;
      Inc(I);
    End;
    Inc(Z);
  End;
  Writeln(Pole[k, x, y]);
End.
