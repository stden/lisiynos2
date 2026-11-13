const name='20';
      n=100;
var i,j:longint;
    RandSeed: Cardinal;

const RANDMULT: Extended = 1.0 / 65536.0 / 65536.0;
function Random (lim: Cardinal): Longint;
begin
  {$Q-}
  RandSeed := RandSeed * 1664525 + 1013904223;
  {$Q+}
  Random := Trunc (RandSeed * RANDMULT * lim);
end;

begin
  writeln(n);
  for i:=1 to n do
    for j:=1 to n do begin
      write('-1');
      if j < n then write (' ') else writeln;
    end;
end.
