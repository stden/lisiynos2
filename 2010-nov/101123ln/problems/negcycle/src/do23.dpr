const name='23';
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
  randseed:=12345;
  writeln(n);
  for i:=1 to n do
    for j:=1 to n do begin
      if j = i mod n + 1 then
        write('-10000')
      else 
        write('100000');
      if j < n then write (' ') else writeln;
    end;
end.
