{$C+,I+,O-,Q+,R+}
Var I, J, N, M, LO, HI: Longint;
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
  Val(ParamStr(5), RandSeed, Err);
  Val(ParamStr(1), N, Err);
  Val(ParamStr(2), M, Err);
  Val(ParamStr(3), LO, Err);
  Val(ParamStr(4), HI, Err);
  Writeln(N, ' ', 1, ' ', N);
  For I := 1 to N do Begin
    For J := 1 to N do begin
      If I = J 
      Then 
        Write('0')
      Else 
        If abs (i - j) <= m Then Write(Random(HI - LO + 1) + LO)
                            Else Write('-1');
      if j < n then
        write (' ')
      else
        writeln;
    end;
  End;
End.
