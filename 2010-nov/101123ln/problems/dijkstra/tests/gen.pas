{$C+,I+,O-,Q+,R+}
Var I, J, N, M, V: Longint;
    Err: Integer;
    RandSeed: Cardinal;

const RANDMULT: Extended = 1.0 / 65536.0 / 65536.0;
function Random (lim: Cardinal): Longint;
begin
  {$Q-}
  RandSeed := RandSeed * 1664525 + 1013904223;
  {$Q+}
  Random := Trunc (RandSeed * RANDMULT * lim);
end;

Begin
  Val(ParamStr(4), RandSeed, Err);
  Val(ParamStr(1), N, Err);
  Val(ParamStr(2), M, Err);
  Val(ParamStr(3), V, Err);
  Writeln(N, ' ', Random(N) + 1, ' ', Random(N) + 1);
  For I := 1 to N do Begin
    For J := 1 to N do begin
      If I = J 
      Then 
        Write('0')
      Else 
        If Random(5000) < V Then Write(Random(M - 1) + 2)
                           Else Write('-1');
      if j < n then
        write (' ')
      else
        writeln;
    end;
  End;
End.
