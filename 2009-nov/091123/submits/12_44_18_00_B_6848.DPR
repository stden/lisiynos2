var
  F : array [1..70] of Int64;
  N,i : Integer;
Begin
  Assign(Input,'b.in'); Reset(Input);
  Assign(Output,'b.out'); Rewrite(Output);
  F[1] := 1;
  F[2] := 1;
  for i:=3 to 70 do 
    F[i] := F[i-1] + F[i-2];
  Read(N);
  Writeln(F[N]);
End.