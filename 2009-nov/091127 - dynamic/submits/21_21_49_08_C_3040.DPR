{$APPTYPE CONSOLE}
Var St :Array [1..50] Of Int64;
    I, j, N : Longint;


Begin
  Assign(input,'c.in');Reset(input);
  Assign(output,'c.out');Rewrite(output);
  FillChar(St,SizeOf(St), 0);
  Read(N);
  St[1] := 1;
  St[2] := 2;
  St[3] := 4;
  For i := 4 to n do
    For j:= i - 3 to i - 1 do
      St[i] := St[i] + St[j];

  Writeln(St[n]);

End.